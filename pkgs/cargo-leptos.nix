# TODO: Add sass as dependency
{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  makeWrapper,
  cargo-generate,
  stdenv,
  darwin,
}: let
  darwinInputs = with darwin.apple_sdk.frameworks; [
    Security
    CoreServices
  ];
  vPrefix = version:
    lib.optionalString (lib.versionAtLeast version "0.1.11") "v";
in
  rustPlatform.buildRustPackage rec {
    pname = "cargo-leptos";
    version = "0.1.11";

    src = fetchFromGitHub {
      owner = "leptos-rs";
      repo = pname;
      rev = "${vPrefix version}${version}";
      hash = "sha256-hZevu2lwyYFenABu1uV7/mZc7SXfLzR6Pdmc3zHJ2vw=";
    };

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "leptos_hot_reload-0.3.0" = "sha256-Pl3nZaz5r5ZFagytLMczIyXEWQ6AFLb3+TrI/6Sevig=";
      };
    };

    doCheck = false;

    nativeBuildInputs = [makeWrapper pkg-config];
    buildInputs = [openssl] ++ lib.optionals stdenv.isDarwin darwinInputs;

    postFixup = ''
      wrapProgram $out/bin/cargo-leptos \
        --prefix PATH : ${lib.makeBinPath [cargo-generate]}
    '';

    meta = with lib; {
      description = "Build tool for Leptos";
      homepage = "https://github.com/leptos-rs/cargo-leptos";
      changelog = "https://github.com/leptos-rs/cargo-leptos/releases/tag/${version}";
      license = licenses.mit;
      maintainers = import ../maintainers.nix;
    };
  }
