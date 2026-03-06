{ config, ... }:
{
  system.primaryUser = config.dotfiles.username;

  homebrew = {
    enable = true;

    enableFishIntegration = true;

    taps = [
      "r-lib/rig"
    ];

    casks = [
      "1password"
      "1password-cli"
      "deskpad"
      "discord"
      "displaylink"
      "docker-desktop"
      "firefox"
      "hammerspoon"
      "karabiner-elements"
      "linearmouse"
      "rectangle"
      "signal"
      "spotify"
      "wezterm@nightly"

      # Work stuff
      "chromium"
      "rig"
      "slack"
      "tunnelblick"
    ];
  };
}
