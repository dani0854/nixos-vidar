{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wezterm
  ];

  home-manager.users.main = {
    home.file.".config/wezterm/wezterm.lua".source = ./wezterm.lua;
  };
}