{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    peazip
  ];
}