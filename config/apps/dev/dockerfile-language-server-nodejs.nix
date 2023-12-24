{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    dockerfile-language-server-nodejs
  ];
}
