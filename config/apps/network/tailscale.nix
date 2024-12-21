{ ... }:
{
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--accept-dns=false" ];
  };

  services.unbound.settings.forward-zone = [
    {
      name = "ts.net.";
      forward-addr = "100.100.100.100";
    }
  ];
}
