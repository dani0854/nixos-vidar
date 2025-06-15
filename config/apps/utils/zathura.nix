{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zathura
  ];

  home-manager.users.main = {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "float,class:(org.pwmt.zathura)"
      "center,class:(org.pwmt.zathura)"
    ];

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };
}
