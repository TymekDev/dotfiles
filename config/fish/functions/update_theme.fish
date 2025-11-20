function update_theme --on-event fish_focus_in --on-event fish_prompt
  set -f THEME "$(cat ~/.local/state/tymek-theme/theme || echo 'tokyonight')"
  if type -q rod
    set -f MODE "$(rod print | tr '[:upper:]' '[:lower:]')"
  else
    set -f MODE "$(cat ~/.local/state/tymek-theme/mode || echo 'dark')"
  end

  if [ "$THEME" = "rosepine" ]
    if [ "$MODE" = "light" ]
      set -f THEME "Rosé Pine Dawn"
    else
      set -f THEME "Rosé Pine Moon"
    end

    fish_config theme choose $THEME
    return 0
  end

  if [ "$THEME" = "tokyonight" ]
    if [ "$MODE" = "light" ]
      set -f THEME "tokyonight_day"
    else
      set -f THEME "tokyonight_storm"
    end

    source "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/fish/$THEME.fish"
    return 0
  end

  if status is-interactive
    echo "[ERROR] Unknown theme: '$THEME'"
  end
  return 1
end
