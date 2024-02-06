{ ... }: {
  home-manager.users.main.programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile ./dir_colors;
  };
}
