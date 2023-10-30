{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
		swaylock
	];
	
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

  home-manager.users.main = {
    xdg.configFile."swaylock/config".source = ./config;
    xdg.configFile."swaylock/screenlock.png".source = ./screenlock.png;
  };
  
}
