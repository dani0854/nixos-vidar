{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    polkit-kde-agent
    qt5.qtwayland
  ];
}
