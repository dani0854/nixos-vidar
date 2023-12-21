{pkgs, ...}: {
  home-manager.users.main = {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        image = "~/.config/swaylock/screenlock.png";
        clock = true;
        indicator = true;
        indicator-radius = 200;
        indicator-thickness = 20;
        grace = 2;
        grace-no-mouse = true;
        grace-no-touch = true;
        line-uses-ring = false;
        show-failed-attempts = false;

        font = "Fira Code Nerd Font";
        timestr = "%H:%M";
        datestr = "%d / %m / %y";
        effect-vignette = "0.5:0.5";

        color = "00000000";

        bs-hl-color = "b48eadff";
        key-hl-color = "a3be8cff";

        inside-color = "2e3440ff";
        inside-clear-color = "81a1c1ff";
        inside-ver-color = "5e81acff";
        inside-wrong-color = "bf616aff";

        line-color = "2e3440";
        line-ver-color = "2e3440";
        line-clear-color = "2e3440";
        line-wrong-color = "2e3440";

        ring-color = "3b4252ff";
        ring-clear-color = "88c0d0ff";
        ring-ver-color = "81a1c1ff";
        ring-wrong-color = "d08770ff";

        separator-color = "00000000";

        text-color = "eceff4ff";
        text-clear-color = "3b4252ff";
        text-ver-color = "3b4252ff";
        text-wrong-color = "3b4252ff";
      };
    };
    xdg.configFile."swaylock/screenlock.png".source = ./screenlock.png;
  };

  security.pam.services.swaylock.text = ''
    # Account management.
    account required pam_unix.so

    # Authentication management.
    auth sufficient pam_unix.so
    auth sufficient pam_exec.so quiet stdout ${pkgs.bash}/bin/bash /run/current-system/sw/bin/fprintd-on-open-lid
    auth required pam_deny.so

    # Password management.
    password sufficient pam_unix.so nullok yescrypt

    # Session management.
    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
  '';
}
