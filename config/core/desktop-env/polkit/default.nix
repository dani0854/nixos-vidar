{ pkgs, ... }:
{
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.polkit-kde-agent-1
  ];

  systemd.user.services.polkit-kde-authentication-agent = {
    enable = true;
    description = "KDE PolicyKit Authentication Agent";
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "dbus";
      BusName = "org.kde.polkit-kde-authentication-agent-1";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Slice = "background.slice";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
