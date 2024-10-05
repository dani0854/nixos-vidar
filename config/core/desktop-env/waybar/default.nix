{ ... }: {
  programs.waybar.enable = true;

  home-manager.users.main = {
    xdg.configFile."waybar/config".source = ./config;
    xdg.configFile."waybar/style.css".source = ./style.css;
  };
}
