function update_theme
  set -f VARIANT "$(cat ~/.local/state/tymek-theme || echo 'dark')"
  set -f FORMAT "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/fish/%s.fish"

  if [ "$VARIANT" = "light" ]
    set -f THEME "tokyonight_day"
  else
    set -f THEME "tokyonight_storm"
  end

  source $(printf $FORMAT $THEME)
end
