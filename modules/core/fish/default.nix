{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.main.shell = pkgs.fish;
}