{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "lunar";
  version = "5.8.0";

  src = fetchurl {
    url = "https://github.com/alin23/Lunar/releases/download/v${version}/Lunar-${version}.dmg";
    sha256 = "sha256-gdjYoJpxsc1R/bMHwMifE3t4k88zWdC7Sm0f2nHqdl4=";
  };

  nativeBuildInputs = [undmg];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    description = "Intelligent adaptive brightness for your external monitors";
    longDescription = ''
      The defacto app for controlling monitors

      Adjust brightness, change volume, switch inputs

      macOS app for controlling monitors, with native support for both Intel and Apple Silicon
    '';
    homepage = "https://lunar.fyi";
    changelog = "https://github.com/alin23/Lunar/releases/tag/v${version}";
    mainProgram = "PlayCover";
    license = licenses.mit;
    platforms = platforms.darwin;
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
