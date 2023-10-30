{ config, home-manager, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = false;
  };

  systemd.user.targets.hyprland-session = {
    description = "hyprland compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };
  
  environment.etc."greetd/environments".text = ''
    ${config.programs.hyprland.package}/bin/Hyprland
  '';

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager.users.main = {
    xdg.configFile."hypr/hyprland.conf".text = ''
      # Systemd integration
      exec-once=${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP && systemctl --user start hyprland-session.target
    '' + "\n" + (builtins.readFile ./hyprland.conf);
  };
}