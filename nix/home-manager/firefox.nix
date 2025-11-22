{ pkgs, ... }:
let
  engine = alias: url: queryParamName: {
    definedAliases = [ alias ];
    urls = [
      {
        template = url;
        params = [
          {
            name = queryParamName;
            value = "{searchTerms}";
          }
        ];
      }
    ];
  };
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "pl"
    ];

    profiles.default = {
      isDefault = true;

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        onepassword-password-manager
      ];

      search = {
        force = true;
        default = "ddg";
        engines = {
          "Nix Packages" = engine "@np" "https://search.nixos.org/packages" "query";
          "Nix Options" = engine "@no" "https://search.nixos.org/options" "query";
          "MDN" = engine "@mdn" "https://developer.mozilla.org/en-US/search" "q";
        };
      };

      settings = {
        "general.autoScroll" = true;

        # Telemetry
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.tabs.crashReporting.sendReport" = false;
        "devtools.onboarding.telemetry.logged" = false;

        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        "browser.newtab.url" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.tabs.firefox-view" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  };
}
