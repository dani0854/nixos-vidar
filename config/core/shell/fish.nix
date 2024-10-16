{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.main.shell = pkgs.fish;

  home-manager.users.main = {
    programs.fish = {
      enable = true;
    };
  };
}
