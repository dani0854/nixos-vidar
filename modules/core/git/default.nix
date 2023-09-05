{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    git-lfs
  ];
  
  home-manager.users.main = {
    home.file.".gitconfig".source = ./.gitconfig;
  };
}