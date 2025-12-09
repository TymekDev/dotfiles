function update_theme --on-event fish_focus_in --on-event fish_prompt
  set -f MODE "$(cat ~/.local/state/tymek-theme/mode || echo 'dark')"

  if [ "$MODE" = "light" ]
    set -f THEME "tokyonight_day"
  else
    set -f THEME "tokyonight_storm"
  end

  source "$HOME/.local/share/nvim/lazy/tokyonight.nvim/extras/fish/$THEME.fish"
  return 0
end
