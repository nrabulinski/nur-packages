# Stolen from https://github.com/devins2518/nur/blob/4ae0e8d988306cd327a65f1715bd4d6a6bf4f3fd/pkgs/zig-master/default.nix
{
  stdenv,
  fetchurl,
  lib,
}: let
  os =
    if stdenv.isLinux
    then "linux"
    else "macos";
  arch =
    if stdenv.isx86_64
    then "x86_64"
    else "aarch64";
  v = "0.10.0";
  shas = {
    x86_64-linux = "631ec7bcb649cd6795abe40df044d2473b59b44e10be689c15632a0458ddea55";
    aarch64-linux = "2a126f3401a7a7efc4b454f0a85c133db1af5a9dfee117f172213b7cbd47bfba";
    x86_64-darwin = "3a22cb6c4749884156a94ea9b60f3a28cf4e098a69f08c18fbca81c733ebfeda";
    aarch64-darwin = "02f7a7839b6a1e127eeae22ea72c87603fb7298c58bc35822a951479d53c7557";
  };
in
  stdenv.mkDerivation rec {
    pname = "zig";
    version = "0.10.0";

    src = fetchurl {
      url = "https://ziglang.org/download/${v}/zig-${os}-${arch}-${v}.tar.xz";
      sha256 = shas.${stdenv.hostPlatform.system};
    };

    installPhase = ''
      install -D zig "$out/bin/zig"
      install -D LICENSE "$out/usr/share/licenses/zig/LICENSE"
      cp -r lib "$out/lib"
      install -d "$out/usr/share/doc"
      cp -r doc "$out/usr/share/doc/zig"
    '';

    meta = with lib; {
      description = "General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software.";
      homepage = "https://github.com/ziglang/zig";
      maintainers = import ../maintainers.nix;
      platforms = with platforms; linux ++ darwin;
    };
  }
