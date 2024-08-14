{
  lib,
  unzip,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "intel-one-mono";
  version = "1.4.0";

  nativeBuildInputs = [unzip];

  src = fetchurl {
    url = "https://github.com/intel/intel-one-mono/releases/download/V${version}/otf.zip";
    sha256 = "sha256-dO+O5mdAPHYHRbwS/F4ssWhFRBlPrT1TQJGcFzqCJ/w=";
  };

  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/share/fonts/${pname}
    cp -t $out/share/fonts/${pname} **/*.otf
  '';

  meta = with lib; {
    description = "Intel One Mono, an expressive monospaced font family that’s built with clarity, legibility, and the needs of developers in mind.";
    homepage = "https://github.com/intel/intel-one-mono";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = import ../maintainers.nix;
  };
}
