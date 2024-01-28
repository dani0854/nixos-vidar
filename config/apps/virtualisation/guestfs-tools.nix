{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    guestfs-tools
  ];
}
