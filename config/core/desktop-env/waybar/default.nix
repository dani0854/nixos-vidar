{ pkgs, inputs, ... }: {
  programs.waybar = {
    enable = true;
    package = inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
  };

  home-manager.users.main = {
    xdg.configFile."waybar/config".source = ./config;
    xdg.configFile."waybar/style.css".source = ./style.css;
  };
}
