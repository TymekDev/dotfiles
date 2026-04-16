{
  inputs,
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
    inputs.neovim-nightly-overlay.overlays.default

    (final: _: {
      arf = final.callPackage ./wrappers/arf-bin.nix { };
      serve-remote-open = final.callPackage ./custom/serve-remote-open.nix { };
      setup-codespace-ssh = final.callPackage ./custom/setup-codespace-ssh.nix { };
      tarsnap-1pass = final.callPackage ./custom/tarsnap-1pass.nix { };
      tarsnap-1pass-backup = final.callPackage ./custom/tarsnap-1pass-backup.nix { };
    })

    (_: prev: {
      fzf = prev.fzf.overrideAttrs (prevAttrs: {
        patches = (prevAttrs.patches or [ ]) ++ [ ./patches/fzf_light-tui-arrow-handling.patch ];
      });

      fzf-git-sh = prev.fzf-git-sh.overrideAttrs (prevAttrs: {
        patches = (prevAttrs.patches or [ ]) ++ [ ./patches/fzf-git-sh_no-keybindings.patch ];
      });
    })
  ]
  ++ lib.optionals (!isCodespace) [
    (final: prev: {
      # NOTE: I just need the terminfo there, so I use the nixpkgs one as the patches don't modify the terminfo.
      wezterm = import ./wrappers/wezterm.nix { inherit final prev; };
    })
  ]
  ++ lib.optionals isCodespace [
    (final: _: {
      nix-codespace = final.callPackage ./custom/nix-codespace.nix { };
      nvim-persistent = final.callPackage ./custom/nvim-persistent.nix { };
    })
  ];
}
