{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.main.shell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    powerline-go
  ];

  home-manager.users.main = {
    xdg.configFile."fish/config.fish".source = ./config.fish;
  };
}