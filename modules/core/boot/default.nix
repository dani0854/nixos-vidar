{ ... }:

{
  boot.initrd.availableKernelModules = [ 
    "nvme"
    "ehci_pci"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
    "amdgpu"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];

  hardware.enableRedistributableFirmware = true;

  boot.extraModprobeConfig = "
    options iwlwifi power_save=0
    options iwlmvm power_scheme=1
    options kvm_amd nested=1
  ";
}
