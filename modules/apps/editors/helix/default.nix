{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    helix
  ];

  home-manager.users.main = {
    xdg.configFile."helix/config.toml".source = ./config.toml;
    xdg.configFile."helix/languages.toml".source = ./languages.toml;
  };
}