{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst
  ];

  systemd.user.services.dunst = {
    enable = true;
    description = "Dunst notification daemon";
    documentation = [ "man:dunst(1)" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.dunst}/bin/dunst";
        Slice = "session.slice";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

  home-manager.users.main = {
    xdg.configFile."dunst/dunstrc".source = ./dunstrc;
  };
}