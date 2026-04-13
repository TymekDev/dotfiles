{ config, lib, ... }:
let
  inherit (lib) fromHexString;
in
{
  system.startup.chime = false;

  system.keyboard = {
    enableKeyMapping = true;
    nonUS.remapTilde = true;
    remapCapsLockToEscape = true;
    builtinKeyboardOnly = true;
    userKeyMapping = [
      # Right Command -> Right Option
      {
        HIDKeyboardModifierMappingSrc = fromHexString "0x7000000E7";
        HIDKeyboardModifierMappingDst = fromHexString "0x7000000E6";
      }

      # Right Option -> Right Command
      {
        HIDKeyboardModifierMappingSrc = fromHexString "0x7000000E6";
        HIDKeyboardModifierMappingDst = fromHexString "0x7000000E7";
      }

      # Tilde -> Caps lock (non US keyboard)
      {
        HIDKeyboardModifierMappingSrc = fromHexString "0x700000035";
        HIDKeyboardModifierMappingDst = fromHexString "0x700000039";
      }
    ];
  };

  system.defaults = {
    CustomUserPreferences = {
      "org.hammerspoon.Hammerspoon" = {
        MJConfigFile = "~/.config/hammerspoon/init.lua";
      };
    };

    NSGlobalDomain = {
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleScrollerPagingBehavior = true;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticPeriodSubstitutionEnabled = false;
      _HIHideMenuBar = true;
      "com.apple.keyboard.fnState" = true;
      "com.apple.sound.beep.feedback" = 0;
    };

    WindowManager = {
      AppWindowGroupingBehavior = false;
      EnableStandardClickToShowDesktop = false;

      # I use rectangle for that
      EnableTilingByEdgeDrag = false;
      EnableTilingOptionAccelerator = false;
      EnableTopTilingByEdgeDrag = false;

      # TODO: maybe I could replace Rectangle with the builtin one by enabling this?
      # system.defaults.WindowManager.EnableTiledWindowMargins = false;
    };

    controlcenter = {
      Bluetooth = true;
      Display = true;
      FocusModes = true; # FIXME: this is always on. Should be "only when active"
      NowPlaying = true; # FIXME: this is always on. Should be "only when active"
      Sound = true;
    };

    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      mineffect = "scale";
      mru-spaces = false;
      tilesize = 48;
      wvous-br-corner = 1; # disabled bottom right hot corner
      persistent-apps = [
        { app = "/Applications/Firefox.app"; }
        { app = "/Applications/Nix Apps/WezTerm.app"; }
        { app = "/Applications/Windows App.app"; }
        { app = "/Applications/Slack.app"; }
        { app = "/Applications/Spotify.app"; }
      ];
      persistent-others = [
        { folder = "${config.dotfiles.home}/Downloads"; }
      ];
    };

    finder = {
      FXPreferredViewStyle = "Nlsv"; # list view
      NewWindowTarget = "Home";
      ShowPathbar = true;
    };

    hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";

    menuExtraClock = {
      ShowDate = 0;
      ShowDayOfWeek = true;
    };

    trackpad = {
      TrackpadPinch = true;
      TrackpadRightClick = true;
      TrackpadRotate = true;
      TrackpadThreeFingerTapGesture = 0; # disabled
      TrackpadTwoFingerDoubleTapGesture = true;
    };
  };
}
