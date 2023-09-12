{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sc-controller
  ];
}