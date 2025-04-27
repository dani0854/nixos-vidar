{
  pkgs,
  lib,
  config,
  ...
}:
{
  home-manager.users.main = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = lib.getExe pkgs.alacritty;
          launch-prefix = "${lib.getExe config.programs.uwsm.package} app -- ";
        };
        colors = {
          background = "2e3440ff"; # nord0 — dark background
          text = "d8dee9ff"; # nord4 — main foreground
          prompt = "e5e9f0ff"; # nord5 — subtle prompt
          placeholder = "4c566aff"; # nord3 — dimmed placeholder
          input = "d8dee9ff"; # nord4 — input matches text
          match = "88c0d0ff"; # nord8 — standout Frost blue
          selection = "434c5eff"; # nord2 — selection background
          selection-text = "e5e9f0ff"; # nord5 — text on selection
          selection-match = "88c0d0ff"; # nord8 — match inside selected
          counter = "4c566aff"; # nord3 — subtle UI text
          border = "3b4252ff"; # nord1 — soft border
        };
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, R, exec, ${lib.getExe config.home-manager.users.main.programs.fuzzel.package}"
    ];
  };
}
