{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixos-option
    wget
    htop
  ];
}