{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    ruff
    pyright
  ];
}
