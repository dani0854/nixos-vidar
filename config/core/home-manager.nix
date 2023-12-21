{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager.useUserPackages = false;
  home-manager.useGlobalPkgs = true;
  programs.dconf.enable = true;
}
