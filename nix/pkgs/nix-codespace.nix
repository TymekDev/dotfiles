{
  writeShellApplication,
}:
writeShellApplication {
  name = "nix-codespace";
  text = ''
    usage() {
      echo "Usage: nix-codespace <command> [options]"
      echo ""
      echo "Commands:"
      echo "  rebuild [ref]  Rebuild Home Manager configuration"
    }

    case "''${1:-}" in
    rebuild)
      shift
      REF=""
      if [ -n "''${1:-}" ]; then
        REF="?ref=$1"
      fi
      nix run github:nix-community/home-manager -- \
        switch --flake "git+https://code.tymek.dev/TymekDev/dotfiles''${REF}#$(id -un)" --refresh
      ;;
    --help | -h)
      usage
      ;;
    *)
      usage
      exit 1
      ;;
    esac
  '';
}
