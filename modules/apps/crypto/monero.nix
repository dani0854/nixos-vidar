{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    monero-gui
  ];
}