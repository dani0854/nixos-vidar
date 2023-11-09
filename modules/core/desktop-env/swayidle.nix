{ pkgs, ... }:

{
  home-manager.users.main = {
    services.swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock-effects}/bin/swaylock -f";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock-effects}/bin/swaylock -f";
        }
      ];

      timeouts = [
        {
          timeout = 250;
          command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 300;
          command = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          timeout = 400;
          command = "${pkgs.systemd}/bin/systemctl hibernate";
        }
      ];
    };
  };
}