{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "lunar";
  version = "6.1.3";

  src = fetchurl {
    url = "https://github.com/alin23/Lunar/releases/download/v${version}/Lunar-${version}.dmg";
    sha256 = "sha256-ysQIlnLVYs5f1yq2tbmrVdVEd5wTYhUDmbe8OSqa/wI=";
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
    mainProgram = "Lunar";
    license = licenses.mit;
    platforms = platforms.darwin;
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
