{pkgs, ... }:
{
  imports = [
    ./boot
    ./localization
    ./network
    ./printing
    ./users
    ./core.nix
  ];
}