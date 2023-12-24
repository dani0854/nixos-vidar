{ modulesPath
, pkgs
, ...
}: {
  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm

    imports = [ (modulesPath + "/virtualisation/qemu-vm.nix") ];

    virtualisation = {
      memorySize = 8192;
      cores = 16;
      qemu.options = [
        "-vga none"
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];
    };

    # add initial password for test
    users.users.main.initialPassword = "test";
  };
}
