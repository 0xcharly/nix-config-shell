{
  rev,
  lib,
  stdenv,
  makeFontsConf,
  makeWrapper,
  apdbctl,
  ddcutil,
  hyprland,
  recursive,
  material-symbols,
  rubik,
  nerd-fonts,
  qt6,
  quickshell,
  cmake,
  ninja,
  debug ? false,
}: let
  version = "0.0.1";

  runtimeInputs = [
    apdbctl
    ddcutil
    hyprland
  ];

  fontconfig = makeFontsConf {
    fontDirectories = [material-symbols nerd-fonts.symbols-only recursive rubik];
  };

  cmakeVersionFlags = [
    (lib.cmakeFeature "VERSION" version)
    (lib.cmakeFeature "GIT_REVISION" rev)
    (lib.cmakeFeature "DISTRIBUTOR" "nix-flake")
  ];
in
  stdenv.mkDerivation {
    inherit version;
    pname = "arc-shell";
    src = ./..;

    nativeBuildInputs = [cmake ninja makeWrapper qt6.wrapQtAppsHook];
    buildInputs = [quickshell qt6.qtbase];
    propagatedBuildInputs = runtimeInputs;

    cmakeFlags =
      [
        (lib.cmakeFeature "ENABLE_MODULES" "shell")
        (lib.cmakeFeature "INSTALL_QSCONFDIR" "${placeholder "out"}/share/arc-shell")
      ]
      ++ cmakeVersionFlags;

    dontStrip = debug;

    prePatch = ''
      substituteInPlace shell.qml \
        --replace-fail 'ShellRoot {' 'ShellRoot {  settings.watchFiles: false'
    '';

    postInstall = ''
      makeWrapper ${quickshell}/bin/qs $out/bin/arc-shell \
      	--prefix PATH : "${lib.makeBinPath runtimeInputs}" \
      	--set FONTCONFIG_FILE "${fontconfig}" \
      	--add-flags "-p $out/share/arc-shell"
    '';

    meta = {
      description = "A bespoke desktop shell";
      homepage = "https://github.com/0xcharly/nix-config-shell";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [_0xcharly];
      mainProgram = "arc-shell";
    };
  }
