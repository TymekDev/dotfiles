{
  config,
  lib,
  ...
}:
let
  inherit (config.dotfiles) isCodespace;
in
{
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      arf = final.callPackage ./arf-bin.nix { };

      serve-remote-open = final.callPackage ./serve-remote-open.nix { };

      setup-codespace-ssh = final.callPackage ./setup-codespace-ssh.nix { };

      tarsnap-1pass = final.callPackage ./tarsnap-1pass.nix { };

      tarsnap-1pass-backup = final.callPackage ./tarsnap-1pass-backup.nix { };

      fzf-git-sh = prev.fzf-git-sh.overrideAttrs (prevAttrs: {
        patches = (prevAttrs.patches or [ ]) ++ [ ./fzf-git-sh-no-keybindings.patch ];
      });
    })
  ]
  ++ lib.optionals (!isCodespace) [
    (final: prev: {
      # NOTE: I just need the terminfo there, so I use the nixpkgs one as the patches don't modify the terminfo.
      wezterm = import ./wezterm.nix { inherit final prev; };
    })
  ]
  ++ lib.optionals isCodespace [
    (final: prev: {
      nix-codespace = final.callPackage ./nix-codespace.nix { };
      nvim-persistent = final.callPackage ./nvim-persistent.nix { };
    })
  ];
}
