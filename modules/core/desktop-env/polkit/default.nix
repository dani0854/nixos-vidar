{ pkgs, ... }:

{
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    polkit-kde-agent
  ];

  systemd.user.services.polkit-kde-authentication-agent = {
    enable = true;
    description = "KDE PolicyKit Authentication Agent";
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "dbus";
        BusName = "org.kde.polkit-kde-authentication-agent-1";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Slice = "background.slice";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
}