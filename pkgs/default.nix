{ pkgs, ... }: {
  wezterm = pkgs.callPackage ./wezterm { };
  betterfox = pkgs.callPackage ./betterfox.nix { };
}
