{
  config,
  pkgs,
  lib,
  ...
}:
let
  fprintdSkip = pkgs.writeTextFile rec {
    name = "fprintd-skip";
    text = ''
      #!${lib.getExe pkgs.dash}

      set -eu

      if ${lib.getExe' pkgs.busybox "grep"} -q closed /proc/acpi/button/lid/LID/state; then
        >&2 echo "Lid is closed, skipping fingerprint auth"
        exit 0
      fi

      exit 1
    '';
    executable = true;
    destination = "/bin/${name}";
    checkPhase = ''
      ${lib.getExe pkgs.shellcheck} --shell sh $out/bin/${name}
    '';
    meta.mainProgram = name;
  };
in
{
  security.sudo.enable = false;

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  security.pam.services.doas.text = ''
    # Account management.
    account required pam_unix.so

    # Authentication management.
    auth [success=1 default=ignore] pam_exec.so quiet stdout ${lib.getExe fprintdSkip}
    auth sufficient ${config.services.fprintd.package}/lib/security/pam_fprintd.so
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

  users.users.main.extraGroups = [ "wheel" ];
}
