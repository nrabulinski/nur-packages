{
  lib,
  fetchFromGitHub,
  fetchurl,
  nimPackages,
  runCommandLocal,
  stdenvNoCC,
}: let
  version = "0.39.0";
  mergeDirs = {
    name,
    dirs,
  }: let
    esc = lib.escapeShellArg;
    cmds =
      map ({
        src,
        dst,
      }: ''
        mkdir -p "$(dirname ${esc "${dst}"})"
        cp -R ${esc "${src}"} ${esc "${dst}"}
        chmod -R +w ${esc "${dst}"}
      '')
      dirs;
  in
    runCommandLocal name {} ''
      mkdir -p $out
      cd $out
      ${lib.concatStrings cmds}
    '';
  min-src = fetchFromGitHub {
    owner = "h3rald";
    repo = "min";
    rev = "v${version}";
    hash = "sha256-GM4Ho6d4FpLqbaLWTui8ZXKs6offh4Sibj/Wqn2Ze/0=";
  };
  minline = fetchFromGitHub {
    owner = "h3rald";
    repo = "minline";
    rev = "e9197ce86354f8e157949cd433c2535e6cf8ae96";
    hash = "sha256-opwMRyTEeQp5wtHfYr518vFyiJTltQh7aNZvvxugrHo=";
  };
  niftylogger = fetchurl {
    url = "https://raw.githubusercontent.com/h3rald/nifty/f2d24457b17a4bc16c91657103d61ded2e502bea/src/niftypkg/niftylogger.nim";
    hash = "sha256-Olg7nBNJQ4oNmx8cmb36TjKP5CntqvGVuKiiSVWd7hE=";
  };
  src-dir = mergeDirs {
    name = "source";
    dirs = [
      {
        src = min-src;
        dst = "src/";
      }
      {
        src = minline;
        dst = "src/minpkg/packages/minline/";
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
  pkg = nimPackages.buildNimPackage rec {
    pname = "min";
    inherit version;

    src = "${src-dir}/src";

    patches = [../assets/min-lang.patch];

    buildInputs = [nimPackages.zippy];
  };
in
  runCommandLocal "min" {
    pname = "min";
    inherit version;

    meta = with lib; {
      license = licenses.mit;
      platforms = with platforms; let
        archs = concatLists [x86_64 aarch64];
        os = concatLists [linux darwin];
      in
        intersectLists archs os;
      maintainers = import ../maintainers.nix;
      broken = true;
    };
  } ''
    mkdir -p $out/bin
    cp ${pkg}/bin/min $out/bin/
  ''
