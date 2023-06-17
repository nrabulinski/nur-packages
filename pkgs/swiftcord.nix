{
  lib,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "swiftcord";
  version = "0.6.1";

  src = fetchurl {
    url = "https://github.com/SwiftcordApp/Swiftcord/releases/download/v${version}/Swiftcord.${version}.dmg";
    sha256 = "sha256-baefiJMM44SljD/ZAvda1k7wueAVqlR9tqha99RrIDI=";
  };

  # Swiftcord now uses APFS dmg which undmg does not support
  unpackCmd = ''
    if ! [[ "$curSrc" =~ \.dmg$ ]]; then return 1; fi

    mnt=$(mktemp -d -t dmg-XXXXXXXXXX)

    function finish {
      /usr/bin/hdiutil detach $mnt -force
      rm -rf $mnt
    }
    trap finish EXIT
    /usr/bin/hdiutil attach -nobrowse -readonly $src -mountpoint $mnt
    ls -lah $mnt/
    ls -lah $mnt/*.app/
    cp -R $mnt/*.app ./
    trap - EXIT
    finish
  '';

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
