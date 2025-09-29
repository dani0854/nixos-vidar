{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.uwsm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  home-manager.users.main.wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # use UWSM
    systemd.enable = false;

    settings = {
      monitor = ",preferred,auto,1";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        "col.inactive_border" = "rgba(3b4252aa)"; # nord1
        "col.active_border" = "rgba(81a1c1ee) rgba(8fbcbbee) 45deg"; # nord8 -> nord7 gradient
        "col.nogroup_border" = "rgb(ebcb8b)"; # nord13
        "col.nogroup_border_active" = "rgb(a3be8c)"; # nord14
      };

      decoration = {
        rounding = 3;
        shadow.color = "rgba(2e3440ee)";
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";

        touchpad = {
          natural_scroll = true;
          tap-and-drag = false;
        };
      };

      misc.enable_anr_dialog = false;

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, F, fullscreen,"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Select and copy
        "$mainMod SHIFT, s, exec, ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -t image/png"

        # Shutdown
        "$mainMod SHIFT ALT, p, exec, ${lib.getExe' config.systemd.package "shutdown"} now"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
