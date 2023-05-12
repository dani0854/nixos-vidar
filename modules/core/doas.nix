{ pkgs, ... }:

{
  security.sudo.enable = false;

  security.doas = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    doas-sudo-shim
  ];

  users.users.main.extraGroups = [ "wheel" ];
}