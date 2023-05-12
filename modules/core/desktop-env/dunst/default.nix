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
    serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.dunst}/bin/dunst";
        Slice = "background.slice";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

  home-manager.users.main = {
    home.file.".config/dunst/dunstrc".source = ./dunstrc;
  };
}