{ pkgs, ... }:
{
  programs.zsh.enable = true;

  users.users.main.shell = pkgs.zsh;

  home-manager.users.main.programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        patterns = {
          "rm -rf *" = "fg=white,bold,bg=red";
          "chown -R *" = "fg=white,bold,bg=red";
          "cmod -R *" = "fg=white,bold,bg=red";
        };
      };
      history = {
        append = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignorePatterns = [
          "rm *"
          "chmod *"
          "chown *"
          "pkill *"
          "kill *"
        ];
        ignoreSpace = true;
        save = 15000;
        size = 15000;
        share = true;
      };
    };

    nix-your-shell = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      colors = {
        "fg" = "#D8DEE9";
        "bg" = "#2E3440";
        "hl" = "#A3BE8C";
        "fg+" = "#D8DEE9";
        "bg+" = "#434C5E";
        "hl+" = "#A3BE8C";
        "pointer" = "#BF616A";
        "info" = "#4C566A";
        "spinner" = "#4C566A";
        "header" = "#4C566A";
        "prompt" = "#81A1C1";
        "marker" = "#EBCB8B";
      };
    };

    powerline-go = {
      enable = true;
      modules = [
        "cwd"
        "nix-shell"
        "direnv"
        "git"
      ];
    };

    dircolors.enableFishIntegration = true;
  };
}
