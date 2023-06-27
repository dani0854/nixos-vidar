{ pkgs, ... }:

{
  services.connman = {
    enable = true;
    package = pkgs.connman.override { firewallType = "nftables"; };   
    wifi.backend = "iwd";
  };
  
  environment.systemPackages = with pkgs; [
    cmst
  ];
}