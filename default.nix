{pkgs ? import <nixpkgs> {}}: {
  playcover = pkgs.callPackage ./pkgs/playcover.nix {};
  lunar = pkgs.callPackage ./pkgs/lunar.nix {};
  transmission-bin = pkgs.callPackage ./pkgs/transmission-bin.nix {};
  zig_0_10 = pkgs.callPackage ./pkgs/zig_0_10.nix {};
}
