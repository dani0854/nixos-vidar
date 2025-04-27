{ ... }:
{
  hardware.rtl-sdr.enable = true;

  users.users.main.extraGroups = [ "plugdev" ];
}
