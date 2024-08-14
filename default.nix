{pkgs ? import <nixpkgs> {}}: {
  playcover = pkgs.callPackage ./pkgs/playcover.nix {};
  lunar = pkgs.callPackage ./pkgs/lunar.nix {};
  transmission-bin = pkgs.callPackage ./pkgs/transmission-bin.nix {};
  zig_0_10 = pkgs.callPackage ./pkgs/zig_0_10.nix {};
  klong = pkgs.callPackage ./pkgs/klong.nix {};
  qutebrowser-bin = pkgs.callPackage ./pkgs/qutebrowser-bin.nix {};
  sensors = pkgs.callPackage ./pkgs/sensors.nix {};
  intel-one-mono = pkgs.callPackage ./pkgs/intel-one-mono.nix {};
  operator-mono-nf = pkgs.callPackage ./pkgs/operator-mono-nf.nix {};
}
