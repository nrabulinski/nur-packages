{pkgs ? import <nixpkgs> {}}: {
  playcover = pkgs.callPackage ./pkgs/playcover.nix {};
  lunar = pkgs.callPackage ./pkgs/lunar.nix {};
  transmission-bin = pkgs.callPackage ./pkgs/transmission-bin.nix {};
  zig_0_10 = pkgs.callPackage ./pkgs/zig_0_10.nix {};
  swiftcord = pkgs.callPackage ./pkgs/swiftcord.nix {};
  min-lang = pkgs.callPackage ./pkgs/min-lang.nix {};
  klong = pkgs.callPackage ./pkgs/klong.nix {};
  yabai-bin = pkgs.callPackage ./pkgs/yabai-bin.nix {};
  qutebrowser-bin = pkgs.callPackage ./pkgs/qutebrowser-bin.nix {};
  cargo-leptos = pkgs.callPackage ./pkgs/cargo-leptos.nix {};
  taplo = pkgs.callPackage ./pkgs/taplo.nix {};
}
