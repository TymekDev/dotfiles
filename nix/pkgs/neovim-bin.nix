{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:
let
  version = "0.12.0";

  platform =
    {
      aarch64-darwin = {
        target = "nvim-macos-arm64";
        hash = "sha256-zwE31pYXhcNJJvh5t6W1+gNxqw1uKVnjkOLwC0YWXOk=";
      };
      x86_64-linux = {
        target = "nvim-linux-x86_64";
        hash = "sha256-FgtpEl3vsW5gsoO2m+ES/UhQ1nrI+adSMowgrUPsNK8=";
      };
    }
    .${stdenv.hostPlatform.system}
      or (throw "neovim-bin: unsupported system ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "neovim";
  inherit version;

  src = fetchurl {
    url = "https://github.com/neovim/neovim/releases/download/v${version}/${platform.target}.tar.gz";
    inherit (platform) hash;
  };

  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];
  buildInputs = lib.optionals stdenv.isLinux [ stdenv.cc.cc.lib ];

  sourceRoot = platform.target;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -r bin lib share "$out"/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Hyperextensible Vim-based text editor";
    homepage = "https://neovim.io";
    license = licenses.asl20;
    mainProgram = "nvim";
    platforms = [
      "aarch64-darwin"
      "x86_64-linux"
    ];
  };
}
