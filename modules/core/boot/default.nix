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
    options usbcore use_both_schemes=y
    options usbcore autosuspend=-1
  ";
}
