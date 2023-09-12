{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sc-controller
  ];
  hardware.uinput.enable = true;
}