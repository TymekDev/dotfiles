{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage {
  pname = "arf";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "eitsupi";
    repo = "arf";
    rev = "v0.2.5";
    hash = "sha256-oBrQWVzKV+yfRdiXecvUxNeXky5ksviWUObFnFKZZqM=";
  };

  cargoHash = "sha256-WvG9mKL6RsoxWtEGcBMVSDNpXFexeoChcmiIhRqR09g=";

  cargoExtraArgs = "--package arf-console";

  # Two tests (test_meta_cd_no_args, test_meta_cd_tilde) fail in the nix
  # sandbox because HOME is not set. Disable the test phase.
  doCheck = false;

  meta = with lib; {
    description = "Alternative R Frontend — a modern R console written in Rust";
    homepage = "https://github.com/eitsupi/arf";
    license = licenses.mit;
    mainProgram = "arf";
  };
}
