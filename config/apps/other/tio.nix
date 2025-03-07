{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tio
  ];
}
