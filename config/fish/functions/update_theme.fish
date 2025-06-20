function update_theme
  set -f THEME "$(cat ~/.local/state/tymek-theme | jq -r '.theme' || echo 'tokyonight')"
  set -f MODE "$(cat ~/.local/state/tymek-theme | jq -r '.mode' || echo 'dark')"

  if [ "$THEME" = "tokyonight" ]
    if [ "$MODE" = "light" ]
      set -f THEME "tokyonight_day"
    else
      set -f THEME "tokyonight_storm"
    end
    set -f FISH_THEME "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/fish/$THEME.fish"
  end

  source $FISH_THEME
end
