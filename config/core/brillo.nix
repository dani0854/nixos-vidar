{ ... }:
{
  hardware.brillo.enable = true;

  users.users.main.extraGroups = [ "video" ];

  home-manager.users.main.wayland.windowManager.hyprland.settings.bind = [
    ",XF86MonBrightnessDown,exec,brillo -q -U 5"
    ",XF86MonBrightnessUp,exec,brillo -q -A 5"
  ];
}
