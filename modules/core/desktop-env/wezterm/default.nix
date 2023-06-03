{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wezterm
  ];

  home-manager.users.main = {
    xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
  };
}