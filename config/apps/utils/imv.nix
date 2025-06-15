{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    imv
  ];

  home-manager.users.main = {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "float,class:(imv)"
      "center,class:(imv)"
    ];

    xdg.mimeApps.defaultApplications = lib.attrsets.genAttrs [
      "image/png"
      "image/jpeg"
      "image/gif"
      "image/svg+xml"
    ] (_: "imv.desktop");
  };
}
