{ ... }: {
  home-manager.users.main = {
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };
  };
}
