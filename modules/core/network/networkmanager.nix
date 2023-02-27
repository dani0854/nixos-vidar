{pkgs, ... }:
# TODO: Refactor
# TODO: Add comments
{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager-sstp
    ];
  };

  environment.systemPackages = with pkgs; [ 
    networkmanagerapplet
  ];

  networking.useDHCP = false;
  networking.interfaces.enp2s0f0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  networking.networkmanager.logLevel = "INFO";
}