{pkgs, ...}: let
  fprintdOnOpenLid = pkgs.writeScriptBin "fprintd-on-open-lid" ''
    #!/usr/bin/env bash

    if ${pkgs.gnugrep}/bin/grep -Fq closed /proc/acpi/button/lid/LID/state
    then
    	echo "Lid is closed, skipping fingerprint auth"
    	exit 1
    else
    	echo "Place your right index finger on the fingerprint reader"
    	${pkgs.fprintd}/bin/fprintd-verify > /dev/null
    fi
  '';
in {
  environment.systemPackages = [
    pkgs.fprintd
    fprintdOnOpenLid
  ];

  systemd.packages = [pkgs.fprintd];

  services.dbus.packages = [pkgs.fprintd];
}
