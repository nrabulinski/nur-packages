{
  lib,
  unzip,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "sensors";
  version = "1.2.0";

  src = fetchurl {
    url = "https://github.com/macmade/Sensors/releases/download/1.0.1/Sensors.app.zip";
    sha256 = "sha256-AJBBNdj8/oOiUf6BE0zUcJTmUz4dPBqBr1GKt+mDlh0=";
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
