{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;

    enableFishIntegration = true;

    nix-direnv.enable = true;
  };

  xdg.configFile."direnv/lib/python.sh".source = pkgs.writeShellScript "python.sh" ''
    layout_uv() {
      if [[ ! -d ".venv" ]]; then
        log_status "Creating venv with uv..."
        uv venv
      fi

      VIRTUAL_ENV="$(pwd)/.venv"
      PATH_add "$VIRTUAL_ENV/bin"
      export VIRTUAL_ENV

      if [[ -f "uv.lock" ]]; then
        watch_file uv.lock
      fi

      if [[ -f "pyproject.toml" ]]; then
        watch_file pyproject.toml
        log_status "Syncing dependencies with uv..."
        uv sync --all-extras
      fi
    }
  '';
}
