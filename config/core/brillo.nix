{ ... }: {
  hardware.brillo.enable = true;

  users.users.main.extraGroups = [ "video" ];
}
