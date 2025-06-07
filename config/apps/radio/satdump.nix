{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    satdump
  ];
}
