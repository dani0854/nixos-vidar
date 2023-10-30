{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swayidle
  ];

  systemd.user.services.swayidle = {
    enable = true;
    description = "Idle manager for Wayland";
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.swayidle}/bin/swayidle";
        Slice = "session.slice";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

  home-manager.users.main = {
    xdg.configFile."swayidle/config".source = ./config;
  };
}
