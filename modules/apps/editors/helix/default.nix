{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    helix
  ];

  home-manager.users.main = {
    home.file.".config/helix/config.toml".source = ./config.toml;
    home.file.".config/helix/languages.toml".source = ./languages.toml;
  };
}