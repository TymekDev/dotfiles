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
      "discord"
      "displaylink"
      "docker-desktop"
      "firefox"
      "ghostty"
      "hammerspoon"
      "karabiner-elements"
      "linearmouse"
      "rectangle"
      "signal"
      "spotify"

      # Work stuff
      "chromium"
      "claude"
      "deskpad"
      "meetingbar"
      "rig"
      "slack"
      "tunnelblick"
      "zoom"
    ];
  };
}
