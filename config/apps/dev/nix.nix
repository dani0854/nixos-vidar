{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nil
    nix-tree
    nix-output-monitor
    nixfmt-rfc-style
  ];
}
