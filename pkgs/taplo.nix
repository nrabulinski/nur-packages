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
    owner = "tamasfe";
    repo = "taplo";
    rev = "55c393ec1fb84eed54933d512a4342ae54056d5a";
    hash = "sha256-kcHZaeX4NCjFTiqI0vF2gxYhU0SSa06q3swMA17/VWQ=";
  };

  cargoHash = "sha256-rlxOwK9CfvZmaRd2dWJlwIwQwBEi9RdxMqXn4Xvfs0M=";

  buildInputs = lib.optional stdenv.isDarwin darwin.apple_sdk.frameworks.Security;

  buildFeatures = lib.optional withLsp "lsp";

  meta = with lib; {
    description = "A TOML toolkit written in Rust";
    homepage = "https://taplo.tamasfe.dev";
    license = licenses.mit;
    maintainers = import ../maintainers.nix;
  };
}
