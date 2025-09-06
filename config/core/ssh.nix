{ ... }:
{
  programs.ssh.extraConfig = ''
    ConnectTimeout=10
  '';

  home-manager.users.main.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      serverAliveInterval = 15;
      serverAliveCountMax = 5;
    };
  };
}
