{ pkgs, ... }:

{
  security.sudo.enable = false;

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    doas-sudo-shim
  ];

  users.users.main.extraGroups = [ "wheel" ];
}