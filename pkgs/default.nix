{ pkgs, ... }: rec {

  # gns3Packages = pkgs.dontRecurseIntoAttrs (pkgs.callPackage ./gns3 { });
  # gns3-gui = gns3Packages.guiStable;
  # gns3-server = gns3Packages.serverStable;
}
