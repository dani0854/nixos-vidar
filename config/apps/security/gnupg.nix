{ ... }:
{
  programs.gnupg.agent.enable = true;

  home-manager.users.main.programs.gpg = {
    enable = true;
    settings = {
      default-new-key-algo = "ed25519/cert+ed25519/sign";
      auto-key-retrieve = true;
      keyserver-options = "honor-keyserver-url";
    };
  };
}
