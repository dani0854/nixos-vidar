{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    eww-wayland
  ];

  systemd.user.services.eww-daemon = {
    enable = true;
    description = "Eww daemon";
    partOf = [ "hyprland-session.target" ];
    wantedBy = [ "hyprland-session.target" ];
    serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.eww-wayland}/bin/eww daemon";
        Slice = "session.slice";
        Restart = "on-failure";
        RestartSec = 3;
        TimeoutStopSec = 10;
      };
  };

  systemd.user.services.eww-bar = {
    enable = true;
    description = "Eww status bar";
    partOf = [ "hyprland-session.target" ];
    wantedBy = [ "hyprland-session.target" ];
    requires = [ "eww-daemon.service" ];
    after = [ "eww-daemon.service" ];
    serviceConfig = {
        Type = "oneshot";
        RemainAfterExit= "yes";
        ExecStart = "echo '${pkgs.eww-wayland}/bin/eww -c $XDG_CONFIG_HOME/eww/bar open bar'";
        ExecStop = "${pkgs.eww-wayland}/bin/eww -c $XDG_CONFIG_HOME/eww/bar close bar";
        Slice = "session.slice";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };

  home-manager.users.main = {
    xdg.configFile."eww/bar" = { source = ./bar; recursive = true; };
  };
}