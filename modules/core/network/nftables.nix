{ pkgs, ... }:

{
  networking.nftables.enable = true;

  networking.firewall.package = pkgs.nftables;
  networking.firewall.checkReversePath = "loose";
}
