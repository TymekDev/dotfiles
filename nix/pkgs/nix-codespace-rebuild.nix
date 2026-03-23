{
  writeShellApplication,
}:
writeShellApplication {
  name = "nix-codespace-rebuild";
  text = ''
    nix run github:nix-community/home-manager \
      --experimental-features "flakes nix-command" \
      -- \
      switch --flake "git+https://code.tymek.dev/TymekDev/dotfiles#$(whoami)" \
      --experimental-features "flakes nix-command"
  '';
}
