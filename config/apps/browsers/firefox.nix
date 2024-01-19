{ config, pkgs, ... }: {

  home-manager.users.main = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;

      profiles.default = {

        extensions = with config.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          theme-nord-polar-night
          languagetool
          decentraleyes
          sponsorblock
          return-youtube-dislikes
          tab-stash
          translate-web-pages
        ];

        search = {
          default = "SearXNG";
          force = true;
          engines = {
            "SearXNG" = {
              description = "SearXNG is a metasearch engine that respects your privacy.";
              urls = [
                {
                  rels = [ "results" ];
                  method = "POST";
                  template = "http://localhost:8888/search";
                  params = [{ name = "q"; value = "{searchTerms}"; }];
                }
                {
                  rels = [ "suggestions" ];
                  method = "POST";
                  type = "application/x-suggestions+json";
                  template = "http://localhost:8888/autocompleter?q={searchTerms}";
                }
              ];

              searchForm = "http://localhost:8888/search";
              iconUpdateURL = "http://localhost:8888/static/themes/simple/img/favicon.svg";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@searx" ];
            };
            "DuckDuckGo".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
        };

        extraConfig = (builtins.readFile "${pkgs.betterfox}/share/betterfox/user.js");

        settings = {
          "extensions.activeThemeID" = "{758478b6-29f3-4d69-ab17-c49fe568ed80}";
        };
      };
    };
  };
}
