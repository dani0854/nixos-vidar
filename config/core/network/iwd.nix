{ pkgs, ... }:
{
  networking.wireless.iwd.enable = true;

  environment.systemPackages = with pkgs; [
    iwgtk
    adwaita-icon-theme
  ];

  systemd.user.services.iwgtk = {
    enable = true;
    description = "Lightweight wireless networking GUI (front-end for iwd)";
    after = [ "waybar.service" ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${pkgs.iwgtk}/bin/iwgtk --indicators";
      Slice = "session.slice";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
