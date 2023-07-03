{ pkgs, ... }:

{
  services.connman = {
    enable = true;
    package = pkgs.connman.override { firewallType = "nftables"; };   
    wifi.backend = "iwd";
  };
  
  environment.systemPackages = with pkgs; [
    cmst
  ];

  systemd.user.services.cmst = {
    enable = true;
    description = "QT GUI for Connman with system tray icon";
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    after = [ "waybar.service" ];
    serviceConfig = {
        Type = "exec";
        ExecStart = "${pkgs.cmst}/bin/cmst -m";
        Slice = "session.slice";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
}