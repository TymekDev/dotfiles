{ final, prev }:
let
  rev = "c1c57af8556fd78a51f9556bdbbb56c3c38e0b57";
  meta = fetchGit {
    url = "https://github.com/JafarAbdi/wezterm.git";
    inherit rev;
  };
  date =
    let
      d = meta.lastModifiedDate;
    in
    "${builtins.substring 0 8 d}-${builtins.substring 8 6 d}";
  version = "${date}-${meta.shortRev}-tymek";
in
prev.wezterm.overrideAttrs (
  finalAttrs: prevAttrs: {
    patches = (prevAttrs.patches or [ ]) ++ [ ./wezterm-csi-2031.patch ];
    version = rev;
    src = final.fetchFromGitHub {
      owner = "JafarAbdi";
      repo = "wezterm";
      rev = finalAttrs.version;
      fetchSubmodules = true;
      hash = "sha256-cH7kdJ1h+5qTsd4GG7JFg+o8gNm42VVEAdbR3zE1ieE=";
    };
    cargoDeps = final.rustPlatform.fetchCargoVendor {
      inherit (finalAttrs) src;
      hash = "sha256-o6VEpAzNUPtONbtI63DXyGWiLDVU9q8IZethlzz5duk=";
    };
    postPatch = (prevAttrs.postPatch or "") + ''
      echo "${version}" > .tag
    '';
  }
)
