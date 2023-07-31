{
  lib,
  undmg,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "lunar";
  version = "6.2.2";

  src = fetchurl {
    url = "https://github.com/alin23/Lunar/releases/download/v${version}/Lunar-${version}.dmg";
    hash = "sha256-pi9hif3N0FeC6NjFBWSnwkKxFUxJ39wWS1nyGKmv/mU=";
  };

  # Lunar now uses APFS dmg which undmg does not support
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
