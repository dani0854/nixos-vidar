{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gotools
  ];
}
