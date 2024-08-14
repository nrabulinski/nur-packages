{
  lib,
  unzip,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "sensors";
  version = "1.2.2";

  src = fetchurl {
    url = "https://github.com/macmade/Sensors/releases/download/${version}/Sensors.zip";
    sha256 = "sha256-6AqhHzL/LD82KKGPkCS0AastuqBewsQM/lFyBpo+W0w=";
  };

  nativeBuildInputs = [unzip];
  sourceRoot = ".";
  unpackCmd = "unzip -o $curSrc";
  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    mainProgram = "Sensors";
    platforms = platforms.darwin;
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
