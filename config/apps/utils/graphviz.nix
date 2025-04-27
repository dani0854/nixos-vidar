{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    graphviz
  ];
}
