{ pkgs, ... }: {
  services.gns3-server-fix = {
    enable = true;
    ubridge.enable = true;

    log.debug = true;
  };

  environment.systemPackages = with pkgs; [
    gns3-gui
  ];

  # users.users.main.extraGroups = [ "ubridge" ];
}
