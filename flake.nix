{
  description = "nrabulinski's personal NUR packages";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
  }:
    flake-parts.lib.mkFlake {inherit self;} {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem = {pkgs, ...}: {
        packages = import ./default.nix {inherit pkgs;};
        formatter = pkgs.alejandra;
      };

      flake = {
        overlay = import ./overlay.nix;
      };
    };
}
