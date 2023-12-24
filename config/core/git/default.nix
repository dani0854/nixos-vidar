{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    git-crypt
    git-secrets
  ];

  home-manager.users.main = {
    home.file.".gitconfig".source = ./.gitconfig;
  };
}
