{
  lib,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "playcover";
  version = "3.0.0";

  src = fetchurl {
    url = "https://github.com/PlayCover/PlayCover/releases/download/${version}/PlayCover_${version}.dmg";
    sha256 = "sha256-wl3u7b5IBtTFxIbgXnaW40ecEpSnxR8LrxcV7VM3HiY=";
  };

  # PlayCover now uses APFS dmg which undmg does not support
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
    description = "Run iOS apps and games on Apple Silicon Macs with mouse, keyboard and controller support.";
    longDescription = ''
      Welcome to PlayCover! This software is all about allowing you to run iOS apps and games on Apple Silicon devices running macOS 12.0 or newer.

      PlayCover works by putting applications through a wrapper which imitates an iPad. This allows the apps to run natively and perform very well.

      PlayCover also allows you to map custom touch controls to keyboard, which is not possible in alternative sideloading methods such as Sideloadly.

      These controls include all the essentials, from WASD, camera movement, left and right clicks, and individual keymapping, similar to a popular Android emulator’s keymapping system called Bluestacks.

      This software was originally designed to run Genshin Impact on your Apple Silicon device, but it can now run a wide range of applications. Unfortunately, not all games are supported, and some may have bugs.
    '';
    homepage = "https://playcover.io";
    changelog = "https://github.com/PlayCover/PlayCover/releases/tag/${version}";
    mainProgram = "PlayCover";
    license = licenses.gpl3;
    platforms = ["aarch64-darwin"];
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = import ../maintainers.nix;
  };
}
