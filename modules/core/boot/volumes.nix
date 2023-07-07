{...}:
# TODO: Refactor
# TODO: Add comments
{
  boot.initrd.luks.devices = {
     luksroot = {
      device = "/dev/disk/by-label/luksRoot"; 
      };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];
}