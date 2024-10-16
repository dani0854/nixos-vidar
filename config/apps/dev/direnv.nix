{ ... }: {
  home-manager.users.main.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
