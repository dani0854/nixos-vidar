{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    imv
  ];

  home-manager.users.main = {
    wayland.windowManager.hyprland.settings.windowrule = [
      {
        name = "imv";
        "match:class" = "imv";

        float = true;
        center = true;
      }
    ];

    xdg.mimeApps.defaultApplications = lib.attrsets.genAttrs [
      "image/png"
      "image/jpeg"
      "image/gif"
      "image/svg+xml"
    ] (_: "imv.desktop");
  };
}
