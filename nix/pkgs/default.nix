{ ... }:
{
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      tarsnap-1pass = final.callPackage ./tarsnap-1pass.nix { };

      tarsnap-1pass-backup = final.callPackage ./tarsnap-1pass-backup.nix { };

      # TODO: remove this once https://github.com/junegunn/fzf-git.sh/pull/108 is merged and available on nixpkgs
      fzf-git-sh = prev.fzf-git-sh.overrideAttrs (
        finalAttrs: prevAttrs: {
          version = "5d90f98bb1ef6ae1f3e140ec03a4222e08cf96cc";
          src = final.fetchFromGitHub {
            owner = "TymekDev";
            repo = "fzf-git.sh";
            rev = finalAttrs.version;
            hash = "sha256-4dR3bF4iKXZGWwr3FfmGqflhghdBB02EoVgjPu97mAk=";
          };
        }
      );
    })
  ];
}
