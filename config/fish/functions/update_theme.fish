function update_theme
  set -f THEME "$(cat ~/.local/state/tymek-theme | jq -r '.theme' || echo 'tokyonight')"
  set -f MODE "$(cat ~/.local/state/tymek-theme | jq -r '.mode' || echo 'dark')"

  if [ "$THEME" = "rosepine" ]
    if [ "$MODE" = "light" ]
      set -f THEME "Rosé Pine Dawn"
    else
      set -f THEME "Rosé Pine Moon"
    end

    fish_config theme choose $THEME
    return
  end

  if [ "$THEME" = "tokyonight" ]
    if [ "$MODE" = "light" ]
      set -f THEME "tokyonight_day"
    else
      set -f THEME "tokyonight_storm"
    end

    source "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/fish/$THEME.fish"
    return
  end

  echo "[ERROR] Unknown theme: '$THEME'"
  return 1
end
