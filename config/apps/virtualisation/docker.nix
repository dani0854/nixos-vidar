{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  users.users.main.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    ctop
  ];
}
