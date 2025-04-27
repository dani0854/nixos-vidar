{ lib, config, ... }:
{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
        user = config.users.users.main.name;
      };
      default_session = initial_session;
    };
  };
}
