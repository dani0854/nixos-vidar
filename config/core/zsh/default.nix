{ pkgs, ... }: {

  programs.zsh.enable = true;
  users.users.main.shell = pkgs.zsh;

  environment.pathsToLink = [ "/share/zsh" ];

  home-manager.users.main = {
    programs.zsh = {
      enable = true;
      package = pkgs.zsh;
      enableAutosuggestions = true;
      enableVteIntegration = true;
      autocd = false;
      syntaxHighlighting.enable = true;
    };

    programs.powerline-go = {
      enable = true;
      modules = [
        "cwd"
        "nix-shell"
        "git"
        "exit"
      ];
    };
  };
}
