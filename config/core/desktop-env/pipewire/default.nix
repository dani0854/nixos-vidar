{ pkgs, ... }:
{
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.wireplumber.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
