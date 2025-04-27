{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Privacy = "device";
  };
  services.blueman.enable = true;
  home-manager.users.main.services.blueman-applet.enable = true;
}
