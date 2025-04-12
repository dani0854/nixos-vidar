{ pkgs, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "ehci_pci"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
        "amdgpu"
      ];
      kernelModules = [ "dm-snapshot" ];
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "kvm-amd"
      "ntsync"
    ];

    extraModprobeConfig = "
      options iwlwifi power_save=0
      options iwlmvm power_scheme=1
      options kvm_amd nested=1
    ";

    kernel.sysctl."vm.swappiness" = 1;
  };
}
