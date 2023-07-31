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
      rev = "10da9485a5052695c89b5ea832f643d617fbc664";
      hash = "sha256-/WBK95oDFQ9L0jy5XeAWWo+HZOI7nK7mdZdjWQpv3gc=";
    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "heed-0.10.6" = "sha256-rm02pJ6wGYN4SsAbp85jBVHDQ5ITjZZd+79EC2ubRsY=";
        "reqwest-0.11.9" = "sha256-wH/q7REnkz30ENBIK5Rlxnc1F6vOyuEANMHFmiVPaGw=";
        "ruma-0.8.2" = "sha256-+CjVDLopvkyunZ7jhkDLgfyGkUpl9069h0xDhmLoijQ=";
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
