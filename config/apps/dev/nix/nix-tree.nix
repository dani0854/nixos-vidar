{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nix-tree
  ];
}
