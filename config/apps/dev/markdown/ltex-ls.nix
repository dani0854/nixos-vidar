{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ltex-ls
  ];

  home-manager.users.main.programs.helix.languages.language-server.ltex-ls = {
    config.ltex.languageToolHttpServerUri = "http://localhost:8081/";
  };
}
