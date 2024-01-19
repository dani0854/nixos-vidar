{ pkgs, ... }: {

  home-manager.users.main = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;

      profiles.default = {

        extensions = with pkgs.inputs.firefox-addons; [
          ublock-origin
          bitwarden
          theme-nord-polar-night
          # languagetool
          decentraleyes
          sponsorblock
          return-youtube-dislikes
          tab-stash
        ];

        # search = {
        #   default = "DuckDuckGo";
        #   order = [
        #     "DuckDuckGo"
        #     "Google"
        #     "Yandex"
        #   ];
        # };

        extraConfig = (builtins.readFile "${pkgs.betterfox}/share/betterfox/user.js");

        settings = {
          "extensions.activeThemeID" = "{758478b6-29f3-4d69-ab17-c49fe568ed80}";
        };
      };
    };
  };
}
