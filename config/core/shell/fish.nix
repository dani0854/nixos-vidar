{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.main.shell = pkgs.fish;

  home-manager.users.main.programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
    };
    fzf.enableFishIntegration = true;
    dircolors.enableFishIntegration = true;
  };
}
