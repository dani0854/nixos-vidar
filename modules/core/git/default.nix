{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
  ];
  
  home-manager.users.main = {
    home.file.".gitconfig".source = ./.gitconfig;
  };
}