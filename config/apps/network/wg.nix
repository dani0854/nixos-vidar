{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.wg-quick.interfaces.wg0.configFile = "/etc/wireguard/wg0.conf";
}
