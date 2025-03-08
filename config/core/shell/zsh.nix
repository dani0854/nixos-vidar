{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # disable global init, since compinit is slow, and initialized by user rc file
    enableGlobalCompInit = false;
  };

  environment.systemPackages = with pkgs; [
    nix-zsh-completions
    zsh-completions
  ];

  users.users.main.shell = pkgs.zsh;

  home-manager.users.main.programs = {
    zsh = {
      enable = true;
      defaultKeymap = "viins";
      enableVteIntegration = true;

      enableCompletion = true;
      completionInit = ''
        autoload -U compinit && compinit
        autoload -U bashcompinit && bashcompinit
      '';

      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "pattern"
        ];
        patterns = {
          "rm -rf *" = "fg=white,bold,bg=red";
          "chown -R *" = "fg=white,bold,bg=red";
          "chgrp -R *" = "fg=white,bold,bg=red";
          "chmod -R *" = "fg=white,bold,bg=red";
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
          "chgrp *"
          "pkill *"
          "kill *"
        ];
        ignoreSpace = true;
        save = 15000;
        size = 15000;
        share = true;
      };

      plugins = [
        {
          name = "fzf-tab";
          src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
        }
      ];

      initExtra = ''
        # case insensetive compleations
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        # disable sort when completing `git checkout`
        zstyle ':completion:*:git-checkout:*' sort false

        # set descriptions format to enable group support
        zstyle ':completion:*:descriptions' format '[%d]'

        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        # force zsh not to show completion menu
        zstyle ':completion:*' menu no

        # preview directory's content with eza when completing cd
        zstyle ':fzf-tab:complete:cd:*' fzf-preview '${lib.getExe pkgs.eza} -1 --color=always $realpath'

        # To make fzf-tab follow FZF_DEFAULT_OPTS.
        zstyle ':fzf-tab:*' use-fzf-default-opts yes
      '';
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

    eza.enableZshIntegration = true;

    dircolors.enableZshIntegration = true;
  };
}
