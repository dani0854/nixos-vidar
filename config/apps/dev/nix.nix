{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixd
    nix-tree
    nix-output-monitor
    nixfmt
  ];
}
