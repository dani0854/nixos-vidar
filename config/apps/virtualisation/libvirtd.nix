{ pkgs, ... }: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [
      virtiofsd
    ];
  };

  programs.virt-manager.enable = true;

  users.users.main.extraGroups = [ "libvirtd" ];
  home-manager.users.main.home.sessionVariables.LIBVIRT_DEFAULT_URI = "qemu:///system";
}
