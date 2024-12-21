{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ltex-ls
  ];
}
