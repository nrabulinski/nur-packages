{
  lib,
  fetchzip,
  stdenv,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "klong";
  version = "20220315";

  nativeBuildInputs = [makeWrapper];

  src = fetchzip {
    url = "https://t3x.org/klong/klong${version}.tgz";
    sha256 = "sha256-7oy6WuA5T0+pdyt6xIPN7f0vFkFKyq6eOl1Aim5ixkI=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp kg $out/bin/
    cp -r lib/ $out/kglib
  '';

  postFixup = ''
    wrapProgram $out/bin/kg \
      --set KLONGPATH $out/kglib/
  '';

  meta = with lib; {
    description = "A simple array language";
    homepage = "https://t3x.org/klong/";
    license = licenses.cc0;
    platforms = platforms.all;
    maintainers = import ../maintainers.nix;
  };
}
