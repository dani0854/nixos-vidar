{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    p7zip
  ];
}
