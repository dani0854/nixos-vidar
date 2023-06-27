{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  systemd.user.services.hyprpaper = {
    enable = true;
    description = "Wayland wallpaper";
    partOf = [ "hyprland-session.target" ];
    wantedBy = [ "hyprland-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
        Slice = "session.slice";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

  home-manager.users.main = {
    xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;
  };
}