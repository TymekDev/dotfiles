{ ... }:
{
  # TODO: I don't like how this differs between pkgs and pkgs-unstable. How do I make that uniform?
  nixpkgs.config.allowUnfree = true;
}
