{ ... }:
{
  programs.ssh.extraConfig = "ConnectTimeout=10";

  home-manager.users.main.programs.ssh = {
    enable = true;
    serverAliveInterval = 15;
    serverAliveCountMax = 5;
  };
}
