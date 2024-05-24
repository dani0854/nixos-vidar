{ ... }: {
  home-manager.users.main.programs.mpv = {
    enable = true;
    bindings = {
      WHEEL_UP = "ignore";
      WHEEL_DOWN = "ignore";
      WHEEL_RIGHT = "ignore";
      WHEEL_LEFT = "ignore";
    };
  };
}
