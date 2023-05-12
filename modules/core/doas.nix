{ ... }:

{
  security.sudo.enable = false;

  security.doas = {
    enable = true;
  };

  users.users.main.extraGroups = [ "wheel" ];
}