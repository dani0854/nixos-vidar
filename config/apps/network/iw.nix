{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    iw
  ];
}
