{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sparrow-wifi
  ];
}
