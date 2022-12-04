{
  lib,
  fetchFromGitHub,
  fetchurl,
  nimPackages,
  runCommandLocal,
  stdenvNoCC,
}:
let 
  version = "0.37.0";
  mergeDirs = { name, dirs }: let
    esc = lib.escapeShellArg;
    cmds = map ({ src, dst }: ''
      mkdir -p "$(dirname ${esc "${dst}"})"
      cp -R ${esc "${src}"} ${esc "${dst}"}
      chmod -R +w ${esc "${dst}"}
    '') dirs;
  in runCommandLocal name {} ''
    mkdir -p $out
    cd $out
    ${lib.concatStrings cmds}
  '';
  min-src = fetchFromGitHub {
    owner = "h3rald";
    repo = "min";
    rev = "v${version}";
    sha256 = "sha256-HxT2Yzx2KS7QJE1EdkMcWqGwUmjS53lSQ54+IZ+kD/8=";
  };
  nimline = 
    fetchFromGitHub {
      owner = "h3rald";
      repo = "nimline";
      rev = "73012b2d9fc7809a4f48a9733c929d0a969a9c8b";
      sha256 = "sha256-DwXMh9z4JJMCdBHAJk1JtUNjabrAzfT+D3WBd/GVeB4=";
    };
  niftylogger = fetchurl {
    url = "https://raw.githubusercontent.com/h3rald/nifty/master/src/niftypkg/niftylogger.nim";
    sha256 = "sha256-cBbIB35OhJ5uKJo8oQATNtBesos9SiKiP3eZEF1Glp4=";
  };
  src-dir = 
  mergeDirs {
    name = "source";
    dirs = [
      {
        src = min-src;
        dst = "src/";
      }
      {
        src = nimline;
        dst = "src/minpkg/packages/nimline/";
      }
      {
        src = niftylogger;
        dst = "src/minpkg/packages/niftylogger.nim";
      }
      {
        src = ../assets/libpcre.a;
        dst = "src/minpkg/vendor/pcre/macosx/libpcre.a";
      }
    ];
  };
  pkg = 
    nimPackages.buildNimPackage rec {
      pname = "min";
      version = "0.37.0";
  
      src = "${src-dir}/src";
  
      patches = [ ../assets/min-lang.patch ];
  
      buildInputs = [ nimPackages.zippy ];
    };
in 
  runCommandLocal "min" {
    pname = "min";
    version = "0.37.0";

    meta = with lib; {
      license = licenses.mit;
      platforms = with platforms; let
        archs = concatLists [ x86_64 aarch64 ];
        os = concatLists [ linux darwin ];
      in intersectLists archs os;
      maintainers = import ../maintainers.nix;
    };
  } ''
    mkdir -p $out/bin
    cp ${pkg}/bin/min $out/bin/
  ''
