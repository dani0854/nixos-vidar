{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sdrpp
  ];
}
