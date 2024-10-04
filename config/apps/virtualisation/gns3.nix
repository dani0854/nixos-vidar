{ pkgs, ... }: {
  services.gns3-server = {
    enable = true;
    ubridge.enable = true;
    # log.debug = true;
  };

  environment.systemPackages = with pkgs; [
    gns3-gui
  ];
}
