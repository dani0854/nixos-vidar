{ ... }: {
  home-manager.users.main.programs.powerline-go = {
    enable = true;
    modules = [
      "cwd"
      "nix-shell"
      "direnv"
      "git"
      "exit"
    ];
  };
}
