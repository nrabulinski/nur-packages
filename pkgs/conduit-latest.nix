{
  fetchFromGitLab,
  lib,
  stdenv,
  libiconv,
  darwin,
  rustPlatform,
}: let
  darwinInputs = with darwin.apple_sdk.frameworks; [
    Security
    libiconv
  ];
in
  rustPlatform.buildRustPackage rec {
    pname = "matrix-conduit";
    version = "0.6.0-alpha1";

    src = fetchFromGitLab {
      owner = "famedly";
      repo = "conduit";
      rev = "def079267d3a4255df2c3dd38ed317ca65df5416";
      sha256 = "sha256-ufDLrsDUAQNUsWLGVAFsPA2W/u8pmyMVyed5xUI11FQ=";
    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "heed-0.10.6" = "sha256-rm02pJ6wGYN4SsAbp85jBVHDQ5ITjZZd+79EC2ubRsY=";
        "reqwest-0.11.9" = "sha256-wH/q7REnkz30ENBIK5Rlxnc1F6vOyuEANMHFmiVPaGw=";
        "ruma-0.8.2" = "sha256-tgqUqiN6LNUyz5I6797J0YFsiFyYWfexa7n2jwUoHWA=";
      };
    };

    doCheck = false;

    nativeBuildInputs = [rustPlatform.bindgenHook];
    buildInputs = lib.optionals stdenv.isDarwin darwinInputs;

    meta = with lib; {
      description = "A Matrix homeserver written in Rust";
      homepage = "https://conduit.rs/";
      license = licenses.asl20;
      maintainers = import ../maintainers.nix;
      mainProgram = "conduit";
    };
  }
