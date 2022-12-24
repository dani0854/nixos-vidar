{ config, pkgs, ... }:

{
  programs.sway = {
    enable = true;

    extraPackages = with pkgs; [
      swaylock
      swayidle
      mako
      waybar
      wofi
      xwayland
    ];
  };

  fonts.fonts = with pkgs; [
    font-awesome
    meslo-lgs-nf
  ];

  # xdg.portal.wlr.enable = true;
}
