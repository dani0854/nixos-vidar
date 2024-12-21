{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wofi
  ];

  home-manager.users.main = {
    xdg.configFile."wofi/config".source = ./config;
    xdg.configFile."wofi/style.css".source = ./style.css;
  };
}
