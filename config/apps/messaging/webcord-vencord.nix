{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # TODO: Enable when merged
    # https://github.com/NixOS/nixpkgs/pull/459739
    # webcord-vencord
  ];
}
