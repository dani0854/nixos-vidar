{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    go
    delve
    gopls
    gotools
    golangci-lint
    golangci-lint-langserver
  ];
}
