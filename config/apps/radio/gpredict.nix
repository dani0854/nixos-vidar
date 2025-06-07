{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gpredict-unstable
  ];
}
