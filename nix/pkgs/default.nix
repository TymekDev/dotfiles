{
  config,
  lib,
  opencode,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
in
{
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      arf = final.callPackage ./arf.nix { };

      are-we-dark-yet = final.callPackage ./are-we-dark-yet.nix { };

      tarsnap-1pass = final.callPackage ./tarsnap-1pass.nix { };

      tarsnap-1pass-backup = final.callPackage ./tarsnap-1pass-backup.nix { };

      # TODO: remove this once https://github.com/wezterm/wezterm/pull/7444 is merged and available on nixpkgs
      wezterm = prev.wezterm.overrideAttrs (
        finalAttrs: prevAttrs: {
          version = "c1c57af8556fd78a51f9556bdbbb56c3c38e0b57";
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
        }
      );
    })
  ]
  ++ lib.optionals (!isCodespace) [
    opencode.overlays.default
  ]
  ++ lib.optionals isCodespace [
    (final: prev: {
      nix-codespace-rebuild = final.callPackage ./nix-codespace-rebuild.nix { };
    })
  ];
}
