{ ... }:
{
  home-manager.users.main = {
    programs.password-store.enable = true;
    services.pass-secret-service.enable = true;
  };
}
