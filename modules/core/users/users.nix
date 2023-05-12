{pkgs, ... }:
# TODO: Refactor
# TODO: Add comments
{
  users.users.dsuetin = {
    isNormalUser = true;
    group = "admin";
    shell = pkgs.zsh;
  };
}