{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zathura
  ];

  home-manager.users.main = {
    wayland.windowManager.hyprland.settings.windowrule = [
      {
        name = "zathura";
        "match:class" = "org.pwmt.zathura";

        float = true;
        center = true;
      }
    ];

    xdg.mimeApps.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };
}
