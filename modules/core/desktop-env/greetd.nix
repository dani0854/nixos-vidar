{config, ...}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${config.home-manager.users.main.wayland.windowManager.hyprland.package}/bin/Hyprland";
        user = config.users.users.main.name;
      };
      default_session = initial_session;
    };
  };
}
