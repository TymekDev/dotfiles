{ lib, ... } :
{
  xdg.configFile."wezterm/theme.lua".source = ../../config/wezterm/theme.lua;

  home.activation.weztermMkdirThemeDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir $VERBOSE_ARG --parents $HOME/.local/state/tymek-theme
  '';

  programs.wezterm = {
    enable = true;

    extraConfig = ''
      local theme = require("theme")
      local wezterm = require("wezterm")
      local config = wezterm.config_builder()

      config.term = "wezterm"
      config.font = wezterm.font("JetBrainsMono Nerd Font")
      config.font_size = 14
      config.window_padding = {
        top = 0,
        right = 0,
        bottom = 0,
        left = 0,
      }

      config.keys = {
        { key = "w", mods = "SUPER", action = wezterm.action.Nop },

        { key = "t", mods = "SUPER|SHIFT", action = wezterm.action_callback(theme.cycle_theme) },
        { key = "m", mods = "SUPER|SHIFT", action = wezterm.action_callback(theme.cycle_mode) },
        { key = "m", mods = "SUPER|SHIFT|META", action = wezterm.action_callback(theme.enable_auto_mode) },
      }

      theme.setup(config)

      return config
    '';
  };
}
