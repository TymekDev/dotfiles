{
  writeShellApplication,
  neovim,
  fzf,
  coreutils,
}:
writeShellApplication {
  name = "nvim-persistent";
  runtimeInputs = [
    neovim
    fzf
    coreutils
  ];
  text = ''
    SOCKET_DIR="/tmp/nvim-servers"
    mkdir -p "$SOCKET_DIR"

    usage() {
      echo "Usage: nvim-persistent [options] [-- <nvim args...>]"
      echo ""
      echo "Options:"
      echo "  --pick         Pick an existing server to reattach to"
      echo "  --help, -h     Show this help message"
    }

    cleanup_dead_servers() {
      local ids
      ids="$(find /tmp/nvim-servers/ \( -name '*.pid' -o -name '*.sock' \) -exec basename {} \; | sed -E 's,\.(pid|sock)$,,' | uniq)"
      for id in $ids; do
        local pid_file="$SOCKET_DIR/$id.pid"
        local sock="$SOCKET_DIR/$id.sock"

        if [ -e "$sock" ]; then
          if timeout 2 nvim --headless --server "$sock" --remote-expr 'v:true' &>/dev/null; then
            continue # responsive server, let it be
          fi
          rm -f "$sock"
        fi

        # The server is unresponsive
        if [ -e "$pid_file" ]; then
          kill "$(cat "$pid_file")" 2>/dev/null || true
          rm -f "$pid_file"
        fi
      done
    }

    next_available_number() {
      local n
      n=0
      while [ -e "$SOCKET_DIR/$n.sock" ]; do
        n=$((n + 1))
      done
      echo "$n"
    }

    start_and_attach() {
      local n
      n="$(next_available_number)"
      local sock
      sock="$SOCKET_DIR/$n.sock"

      nvim --headless --listen "$sock" "$@" &
      echo $! >"$SOCKET_DIR/$n.pid"

      # Wait for the server socket to appear
      for _ in $(seq 1 50); do
        if [ -e "$sock" ]; then
          break
        fi
        sleep 0.1
      done

      if [ ! -e "$sock" ]; then
        echo "Error: Neovim server failed to start (socket not created)" >&2
        exit 1
      fi

      nvim --server "$sock" --remote-ui
    }

    pick_and_attach() {
      cleanup_dead_servers

      local sockets=()
      for sock in "$SOCKET_DIR"/*.sock; do
        [ -e "$sock" ] || continue
        sockets+=("$sock")
      done

      if [ ''${#sockets[@]} -eq 0 ]; then
        echo "No live Neovim servers found."
        exit 0
      fi

      local sock
      sock="$(printf '%s\n' "''${sockets[@]}" | fzf --prompt="Select server> " --height=~50%)" || exit 0

      nvim --server "$sock" --remote-ui
    }

    mode="new"
    nvim_args=()

    while [ $# -gt 0 ]; do
      case "$1" in
      --help | -h)
        usage
        exit 0
        ;;
      --pick)
        mode="pick"
        shift
        ;;
      --)
        shift
        nvim_args=("$@")
        break
        ;;
      *)
        nvim_args+=("$1")
        shift
        ;;
      esac
    done

    trap cleanup_dead_servers EXIT INT TERM

    case "$mode" in
    new)
      start_and_attach "''${nvim_args[@]}"
      ;;
    pick)
      pick_and_attach
      ;;
    esac
  '';
}
