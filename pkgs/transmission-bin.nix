{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "transmission";
  version = "4.0.6";

  src = fetchurl {
    url = "https://github.com/transmission/transmission/releases/download/${version}/Transmission-${version}.dmg";
    sha256 = "sha256-5phX8VLgwvU4TMYDWGw9/ywwyT5nQmM0anAoY+cnfBo=";
  };

  nativeBuildInputs = [undmg];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    description = "Transmission is a fast, easy, and free BitTorrent client.";
    homepage = "https://transmissionbt.com";
    changelog = "https://github.com/transmission/transmission/releases/tag/${version}";
    mainProgram = "Transmission";
    license = licenses.mit;
    platforms = platforms.darwin;
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
