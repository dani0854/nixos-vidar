{ ... }: {
  home-manager.users.main.programs.dircolors = {
    enable = true;
    enableFishIntegration = true;
    extraConfig = builtins.readFile ./dir_colors;
  };
}
