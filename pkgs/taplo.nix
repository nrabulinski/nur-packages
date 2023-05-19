{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
  withLsp ? true,
}:
rustPlatform.buildRustPackage rec {
  pname = "taplo";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "nrabulinski";
    repo = "taplo";
    rev = "da44fa68b6c8883b51a0e497c67c0575785740c7";
    sha256 = "sha256-OS5ww5VCuAflyt1aFe5uklcqoWq6fbqXWW5jmI+t28s=";
  };

  cargoSha256 = "sha256-GzUcq4JzbxrkQUyA+NjetSpWmNX2dzlS1XZqn01gkEs=";

  buildInputs = lib.optional stdenv.isDarwin darwin.apple_sdk.frameworks.Security;

  buildFeatures = lib.optional withLsp "lsp";

  meta = with lib; {
    description = "A TOML toolkit written in Rust";
    homepage = "https://taplo.tamasfe.dev";
    license = licenses.mit;
    maintainers = import ../maintainers.nix;
  };
}
