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
in
  rustPlatform.buildRustPackage rec {
    pname = "cargo-leptos";
    version = "0.1.1";

    src = fetchFromGitHub {
      owner = "leptos-rs";
      repo = pname;
      rev = version;
      hash = "sha256-thELkSFC45GveOZOat2PQrTM7Fx5phyhIpgjWwe6r40=";
    };

    cargoSha256 = "sha256-AzTJnZ+6Mhs6KhnaQk8TRj+0z0Ev8tP+C2r7B/GVELA=";

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
