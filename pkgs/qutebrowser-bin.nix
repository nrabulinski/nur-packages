{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "qutebrowser";
  version = "2.5.3";

  src = fetchurl {
    url = "https://github.com/qutebrowser/qutebrowser/releases/download/v${version}/qutebrowser-${version}.dmg";
    sha256 = "sha256-T3DMZhIuXxI1tDCEi7knu6lscGCVSjU1UW76SaKd1N4=";
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
