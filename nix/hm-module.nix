self: {
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  options = with lib; {
    programs.arcshell = {
      enable = mkEnableOption "Enable Desktop shell";
      package = mkOption {
        type = types.package;
        default =
          if wayland.windowManager.hyprland.enable
          then self.packages.${system}.arc-shell-hyprland
          else self.packages.${system}.arc-shell-i3;
        description = "The package of desktop shell";
      };
      compositor = {
        protocol = mkOption {
          type = types.oneOf ["hyprland" "i3"];
          default =
            if wayland.windowManager.hyprland.enable
            then "hyperland"
            else "i3";
          description = "The IPC protocol to use to communicate with the compositor";
        };
      };
      systemd = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable the systemd service for shell";
        };
        target = mkOption {
          type = types.str;
          description = ''
            The systemd target that will automatically start the shell.
          '';
          default = config.wayland.systemd.target;
        };
        environment = mkOption {
          type = types.listOf types.str;
          description = "Extra Environment variables to pass to the shell systemd service.";
          default = [];
          example = [
            "QT_QPA_PLATFORMTHEME=gtk3"
          ];
        };
      };
      settings = mkOption {
        type = types.attrsOf types.anything;
        default = {};
        description = "Desktop shell settings";
      };
      extraConfig = mkOption {
        type = types.str;
        default = "";
        description = "Desktop shell extra configs written to shell.json";
      };
    };
  };

  config = let
    cfg = config.programs.arcshell;
    shell = cfg.package;
  in
    lib.mkIf cfg.enable {
      systemd.user.services.arcshell = lib.mkIf cfg.systemd.enable {
        Unit = {
          Description = "Desktop Shell Service";
          After = [cfg.systemd.target];
          PartOf = [cfg.systemd.target];
          X-Restart-Triggers = lib.mkIf (cfg.settings != {}) [
            "${config.xdg.configFile."arcshell/shell.json".source}"
          ];
        };

        Service = {
          Type = "exec";
          ExecStart = lib.getExe shell;
          Restart = "on-failure";
          RestartSec = "5s";
          TimeoutStopSec = "5s";
          Environment =
            [
              "QT_QPA_PLATFORM=wayland"
            ]
            ++ cfg.systemd.environment;

          Slice = "session.slice";
        };

        Install = {
          WantedBy = [cfg.systemd.target];
        };
      };

      xdg.configFile = let
        defaultSettings.compositor.protocol = cfg.compositor.protocol;
        mkConfig = c:
          lib.pipe (
            if c.extraConfig != ""
            then c.extraConfig
            else "{}"
          ) [builtins.fromJSON (lib.recursiveUpdate (defaultSettings / c.settings)) builtins.toJSON];
      in {
        "arcshell/shell.json".text = mkConfig cfg;
      };

      home.packages = [shell];
    };
}
