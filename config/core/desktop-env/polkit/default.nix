{ ... }:
{
  security.polkit.enable = true;

  home-manager.users.main.services.hyprpolkitagent.enable = true;
}
