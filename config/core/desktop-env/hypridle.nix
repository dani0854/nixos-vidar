{ inputs
, pkgs
, ...
}:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  hypridle = inputs.hypridle.packages.${pkgs.system}.hypridle;
in
{
  home-manager.users.main.services.hypridle = {
    enable = true;
    package = hypridle;
    settings = {
      general = {
        lock_cmd = "${pkgs.swaylock-effects}/bin/swaylock -f";
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
        after_sleep_cmd = "${hyprland}/bin/hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "${hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${hyprland}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 400;
          on-timeout = "${pkgs.systemd}/bin/systemctl hibernate";
        }
      ];
    };
  };
}
