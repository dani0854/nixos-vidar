{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      proton-cachyos-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    mangohud
    gamemode
  ];

  hardware.steam-hardware.enable = true;
}
