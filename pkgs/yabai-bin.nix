{
  lib,
  installShellFiles,
  fetchzip,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "yabai";
  version = "5.0.2";

  src = fetchzip {
    url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
    sha256 = "sha256-wL6N2+mfFISrOFn4zaCQI+oH6ixwUMRKRi1dAOigBro=";
  };

  nativeBuildInputs = [
    installShellFiles
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r ./bin $out
    installManPage ./doc/yabai.1
    runHook postInstall
  '';

  meta = with lib; {
    description = "A tiling window manager for macOS based on binary space partitioning";
    longDescription = ''
      yabai is a window management utility that is designed to work as an extension to the built-in
      window manager of macOS. yabai allows you to control your windows, spaces and displays freely
      using an intuitive command line interface and optionally set user-defined keyboard shortcuts
      using skhd and other third-party software.
    '';
    homepage = "https://github.com/koekeishiya/yabai";
    changelog = "https://github.com/koekeishiya/yabai/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    platforms = ["aarch64-darwin"];
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
