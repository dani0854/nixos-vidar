{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gramps
  ];
}
