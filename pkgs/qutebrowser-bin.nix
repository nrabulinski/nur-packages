{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}: let
  systemSuffix = if stdenvNoCC.isAarch64 then "arm64" else "x86_64";
in stdenvNoCC.mkDerivation rec {
  pname = "qutebrowser";
  version = "3.2.1";

  src = fetchurl {
    url = "https://github.com/qutebrowser/qutebrowser/releases/download/v${version}/qutebrowser-${version}-${systemSuffix}.dmg";
    # TODO: Both x86 and arm hash
    hash = "sha256-HNEXLXy1rgHiD97JyOEuBuZAeGjge1wvHgo9esZZKCY=";
  };

  nativeBuildInputs = [undmg];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/{bin,Applications}
    cp -r *.app $out/Applications
    ln -s $out/Applications/qutebrowser.app/Contents/MacOS/qutebrowser $out/bin/qutebrowser
  '';

  meta = with lib; {
    description = "qutebrowser is a keyboard-focused browser with a minimal GUI.";
    homepage = "https://qutebrowser.org/";
    changelog = "https://github.com/qutebrowser/qutebrowser/releases/tag/v${version}";
    mainProgram = "Transmission";
    license = licenses.gpl3;
    platforms = platforms.darwin;
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
