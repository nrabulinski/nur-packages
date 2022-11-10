{ pkgs ? import <nixpkgs> {} }:

{
  playcover = pkgs.callPackage ./pkgs/playcover.nix { };
}
