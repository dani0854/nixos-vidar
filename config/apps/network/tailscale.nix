{ ... }:
{
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--accept-dns=false" ];
  };

  services.dnsmasq.settings.address = "/ts.net./100.100.100.100";
}
