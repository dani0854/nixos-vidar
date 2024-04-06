{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tmux
  ];

  home-manager.users.main.programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    keyMode = "vi";
    terminal = "tmux-256color";
    extraConfig = "set -as terminal-features 'alacritty:rgb'\n";
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
  };
}
