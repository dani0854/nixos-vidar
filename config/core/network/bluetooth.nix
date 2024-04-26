{ ... }: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Privacy = "device";
  };
  services.blueman.enable = true;
}
