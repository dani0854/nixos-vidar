{ ... }:
{
  networking = {
    resolvconf.enable = false;
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    dhcpcd.extraConfig = "nohook resolv.conf";
  };

  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = [
          "127.0.0.1"
          "::1"
        ];
      };
      forward-zone = [
        {
          name = "ts.net.";
          forward-addr = "100.100.100.100";
        }
        {
          name = ".";
          forward-addr = "1.1.1.1@853#cloudflare-dns.com";
          forward-tls-upstream = "yes";
        }
      ];
    };
  };
}
