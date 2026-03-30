{
  writeShellApplication,
  symlinkJoin,
}:
let
  nix-codespace = writeShellApplication {
    name = "nix-codespace";
    text = ''
      usage() {
        echo "Usage: nix-codespace <command> [options]"
        echo ""
        echo "Commands:"
        echo "  rebuild [ref]  Rebuild Home Manager configuration"
        echo "  version        Print the dotfiles commit of the current configuration"
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
        nvim --headless '+Lazy! restore' '+qa'
        ;;
      version)
        shift
        cat ~/.cache/nix/gitv3/*/FETCH_HEAD
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
  };
in
symlinkJoin {
  name = "nix-codespace";
  paths = [ nix-codespace ];
  postBuild = ''
    ln -s "$out"/bin/nix-codespace "$out"/bin/nix-cs
  '';
}
