{ ... }:
{
  # TODO: I don't like how this differs between pkgs and pkgs-unstable. How do I make that uniform?
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      tarsnap-1pass = final.callPackage ./tarsnap-1pass.nix { };

      tarsnap-1pass-backup = final.callPackage ./tarsnap-1pass-backup.nix { };

      tmux = prev.tmux.overrideAttrs (
        finalAttrs: prevAttrs: {
          version = "348f16093c35cbb318281e68f4405dae5b2627d1";
          src = final.fetchFromGitHub {
            owner = "tmux";
            repo = "tmux";
            rev = finalAttrs.version;
            sha256 = "sha256-TXApnm9VpHEeUnfzz+jKc8q5RJBqv54eBd8d2sVNW3E=";
          };
        }
      );
    })
  ];
}
