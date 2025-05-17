{ ... } :
{
  xdg.configFile."wezterm/theme.lua".source = ../../config/wezterm/theme.lua;

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
      }

      theme.set(config, false)

      return config
    '';
  };
}
