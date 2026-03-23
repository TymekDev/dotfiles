{
  writeShellApplication,
}:
writeShellApplication {
  name = "nix-codespace-rebuild";
  text = ''
    REF=""
    if [ -n "''${1:-}" ]; then
      REF="?ref=$1"
    fi

    nix run github:nix-community/home-manager -- \
      switch --flake "git+https://code.tymek.dev/TymekDev/dotfiles''${REF}#$(id -un)" --refresh
  '';
}
