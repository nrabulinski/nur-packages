{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "qutebrowser";
  version = "2.5.2";

  src = fetchurl {
    url = "https://github.com/qutebrowser/qutebrowser/releases/download/v${version}/qutebrowser-${version}.dmg";
    sha256 = "sha256-nFLHreNIUQNoazHknSV22j9X9Du6KwYlKJiKXuYGuzk=";
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
