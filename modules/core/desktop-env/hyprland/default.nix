{ config, home-manager, hyprland, split-monitor-workspaces, pkgs, ... }:

{
  environment.etc."greetd/environments".text = ''
    ${config.home-manager.users.main.wayland.windowManager.hyprland.package}/bin/Hyprland
  '';

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];

  xdg.portal = {
    enable = true;
    configPackages = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  home-manager.users.main = {
    imports = [ hyprland.homeManagerModules.default ];
    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      systemdIntegration = true;
      recommendedEnvironment = true;
      plugins = [
        split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];
      extraConfig = builtins.readFile ./hyprland.conf;
    };
  };
}
