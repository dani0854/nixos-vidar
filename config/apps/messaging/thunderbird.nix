{ pkgs, ... }: {
  home-manager.users.main.programs.thunderbird = {
    enable = true;
    package = pkgs.betterbird;

    profiles.default = {
      isDefault = true;
    };
  };

  environment.systemPackages = with pkgs; [
    protonmail-bridge
  ];
}
