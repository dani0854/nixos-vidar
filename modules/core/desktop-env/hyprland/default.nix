{
  inputs,
  pkgs,
  ...
}: {
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
    imports = [inputs.hyprland.homeManagerModules.default];
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      systemd.enable = true;
      plugins = [
        inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];
      extraConfig = builtins.readFile ./hyprland.conf;
    };
  };
}
