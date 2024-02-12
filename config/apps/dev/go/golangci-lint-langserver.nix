{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    golangci-lint-langserver
  ];
}
