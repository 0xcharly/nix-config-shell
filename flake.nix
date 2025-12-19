{
  description = "Bespoke desktop shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apdbctl = {
      url = "github:0xcharly/apdbctl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = fn:
      nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux (
        system: fn nixpkgs.legacyPackages.${system}
      );
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: rec {
      arc-shell = pkgs.callPackage ./nix {
        rev = self.rev or self.dirtyRev;
        stdenv = pkgs.clangStdenv;
        apdbctl = inputs.apdbctl.packages.${pkgs.stdenv.hostPlatform.system}.default;
        quickshell = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
          withHyprland = true;
          withX11 = false;
          withI3 = true;
        };
      };
      default = arc-shell;
    });

    devShells = forAllSystems (pkgs: {
      default = let
        shell = self.packages.${pkgs.stdenv.hostPlatform.system}.default;
      in
        pkgs.mkShell.override {stdenv = shell.stdenv;} {
          inputsFrom = [shell];
          packages = with pkgs; [
            alejandra
            kdePackages.qtdeclarative
            nixd

            material-symbols
            nerd-fonts.symbols-only
            recursive
            rubik
          ];
        };
    });

    homeManagerModules.default = import ./nix/hm-module.nix self;
  };
}
