{
  writeShellApplication,
}:
writeShellApplication {
  name = "nix-codespace-rebuild";
  text = ''
    nix run github:nix-community/home-manager -- \
      switch --flake "git+https://code.tymek.dev/TymekDev/dotfiles#$(id -un)"
  '';
}
