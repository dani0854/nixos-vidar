{ home-manager, hyprland, pkgs, ... }:

{
  home-manager.users.main = {
    imports = [ hyprland.homeManagerModules.default ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = true;

      # default options, you don't need to set them
      xwayland = {
        enable = true;
        hidpi = true;
      };

      nvidiaPatches = false;

      extraConfig = "source = ~/.config/hypr/custom.conf";
    };

    home.file.".config/hypr/custom.conf".source = ./custom.conf;
  };
}