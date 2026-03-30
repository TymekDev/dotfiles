{
  lib,
  stdenv,
  fetchurl,
}:
let
  platform =
    {
      x86_64-linux = {
        target = "x86_64-unknown-linux-gnu";
        hash = "sha256-J6q8l6bgssxZ3ONCQQeNSMhcp0F0vxwkwZS/c3ZzZcY=";
      };
      aarch64-linux = {
        target = "aarch64-unknown-linux-gnu";
        hash = "sha256-Kt8iDnbcPwTt/iNnajxHPUYtn+s75lR8g6MOPHm8dcw=";
      };
      aarch64-darwin = {
        target = "aarch64-apple-darwin";
        hash = "sha256-yn4unGWwZW4sBuCQPq7Qs7Dyk12V75g6YFYlCHhHos8=";
      };
      x86_64-darwin = {
        target = "x86_64-apple-darwin";
        hash = "sha256-44fZUG9Bh3SQNWU1zsmiQR2moHR6vMZ0H0H4CnK3pb0=";
      };
    }
    .${stdenv.hostPlatform.system}
      or (throw "arf-bin: unsupported system ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "arf";
  version = "0.2.5";

  src = fetchurl {
    url = "https://github.com/eitsupi/arf/releases/download/v0.2.5/arf-console-${platform.target}.tar.xz";
    inherit (platform) hash;
  };

  buildInputs = lib.optionals (stdenv.isLinux) [ stdenv.cc.cc.lib ];

  sourceRoot = "arf-console-${platform.target}";

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"/bin
    install -m 755 arf "$out"/bin/arf
    runHook postInstall
  '';

  meta = with lib; {
    description = "Alternative R Frontend — a modern R console written in Rust";
    homepage = "https://github.com/eitsupi/arf";
    license = licenses.mit;
    mainProgram = "arf";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  };
}
