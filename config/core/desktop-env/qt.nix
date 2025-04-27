{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];

  home-manager.users.main = {
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
    };
  };
}
