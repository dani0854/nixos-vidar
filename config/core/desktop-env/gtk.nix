{ pkgs, ... }: {
  home-manager.users.main = {
    gtk = {
      enable = true;
      theme = {
        package = pkgs.nordic;
        name = "Nordic";
      };
      font.name = "Fira Code Nerd Font";
      iconTheme = {
        package = pkgs.nordzy-icon-theme;
        name = "Nordzy";
      };
    };
  };
}
