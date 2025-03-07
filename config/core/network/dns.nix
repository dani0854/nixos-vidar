{ config, ... }:
{
  services.dnsmasq = {
    enable = true;
    settings = {
      listen-address = "127.0.0.1,::1";
      bind-interfaces = true;

      cache-size = 10000;

      # DNSSEC
      conf-file = "${config.services.dnsmasq.package}/share/dnsmasq/trust-anchors.conf";
      dnssec = true;
    };
  };
}
