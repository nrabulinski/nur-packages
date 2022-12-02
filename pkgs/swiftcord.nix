{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "swiftcord";
  version = "0.5.1";

  src = fetchurl {
    url = "https://github.com/SwiftcordApp/Swiftcord/releases/download/v${version}/Swiftcord.${version}.dmg";
    sha256 = "sha256-5Sb9n5zKUfOm2IHVfqV3nqq0kAsj7mPcx/2PsTGtoc0=";
  };

  nativeBuildInputs = [undmg];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    description = "Native Discord client for macOS built in Swift";
    longDescription = ''
      Swiftcord is beautiful, follows design principals of the official client and most importantly, its fast!

      Powered by DiscordKit, a Swift Discord implementation built from the ground up.
    '';
    homepage = "https://swiftcordapp.github.io/Swiftcord/";
    changelog = "https://github.com/SwiftcordApp/Swiftcord/releases/tag/v${version}";
    mainProgram = "Swiftcord";
    license = licenses.gpl3;
    platforms = platforms.darwin;
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
