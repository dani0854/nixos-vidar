{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix
  ];

  home-manager.users.main = {
    xdg.configFile."helix/config.toml".source = ./config.toml;
    xdg.configFile."helix/languages.toml".source = ./languages.toml;
  };
}
