{ pkgs, ... } :
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" "pl" ];

    profiles.default = {
      isDefault = true;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        darkreader
        onepassword-password-manager
      ];

      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            definedAliases = [ "@np" ];
          };
          "Nix Options" = {
            urls = [{
              template = "https://search.nixos.org/options";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            definedAliases = [ "@no" ];
          };
        };
      };

      settings = {
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
