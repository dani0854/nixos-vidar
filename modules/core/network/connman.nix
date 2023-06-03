{ pkgs, ... }:

{
  services.connman = {
    enable = true;
    package = pkgs.connman.override { firewallType = "nftables"; dnsType = "systemd-resolved"; };   
    wifi.backend = "iwd";
  };
  
  environment.systemPackages = with pkgs; [
    cmst
  ];
}