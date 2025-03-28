{ pkgs, ... }:
{

  home-manager.users.main.programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;

    profiles.default = {
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        theme-nord-polar-night
        languagetool
        decentraleyes
        sponsorblock
        return-youtube-dislikes
        tab-stash
        translate-web-pages
        vimium
        i-dont-care-about-cookies
        leechblock-ng
        remove-youtube-s-suggestions
      ];

      search = {
        default = "google";
        privateDefault = "brave";
        force = true;
        engines = {
          brave = {
            urls = [
              {
                rels = [ "results" ];
                template = "https://search.brave.com/search?q={searchTerms}";
              }
              {
                rels = [ "suggestions" ];
                type = "application/x-suggestions+json";
                template = "https://search.brave.com/api/suggest?q={searchTerms}";
              }
            ];

            icon = "https://brave.com/static-assets/images/cropped-brave_appicon_release-32x32.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@brave" ];
          };
          ddg.metaData.hidden = true;
          bing.metaData.hidden = true;
          amazondotcom-us.metaData.hidden = true;
          wikipedia.metaData.hidden = true;
        };
      };

      preConfig = (
        builtins.readFile "${pkgs.nur.repos.dsuetin.firefox.userjs.betterfox}/share/betterfox/user.js"
      );

      settings = {
        "extensions.activeThemeID" = "{758478b6-29f3-4d69-ab17-c49fe568ed80}";
        "browser.search.suggest.enabled" = true;
      };
    };
  };
}
