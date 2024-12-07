{ ... }:

{
  networking.dhcpcd = {
    allowInterfaces = [ "wlan0" ];
  };
}
