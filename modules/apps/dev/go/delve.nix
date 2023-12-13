{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    delve
  ];
}
