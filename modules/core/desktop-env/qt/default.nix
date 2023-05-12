{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    libsForQt5.polkit-kde-agent
  ];
}