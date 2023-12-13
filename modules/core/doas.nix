{pkgs, ...}: {
  security.sudo.enable = false;

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = ["wheel"];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  security.pam.services.doas.text = ''
    # Account management.
    account required pam_unix.so

    # Authentication management.
    auth sufficient pam_exec.so quiet stdout ${pkgs.bash}/bin/bash /run/current-system/sw/bin/fprintd-on-open-lid
    auth sufficient pam_unix.so nullok likeauth try_first_pass
    auth required pam_deny.so

    # Password management.
    password sufficient pam_unix.so nullok yescrypt

    # Session management.
    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
  '';

  environment.systemPackages = with pkgs; [
    doas-sudo-shim
  ];

  users.users.main.extraGroups = ["wheel"];
}
