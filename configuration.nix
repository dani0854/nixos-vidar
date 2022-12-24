# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./luks-configuration.nix
      ./sway-configuration.nix
      ./zsh-configuration.nix
      ./nm-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.editor = false;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "thinkpad-nixos"; # Define your hostname.
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.interfaces = ["wlp3s0"];

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Printer
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ 
  	gutenprint
	gutenprintBin
        samsung-unified-linux-driver
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "ru";
  };


  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dsuetin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  nix.settings.auto-optimise-store = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget
    firefox
    git
    kitty
    neofetch
    vscodium
    spotify
    lxqt.lxqt-policykit
    pavucontrol
    scala
    sbt
    smartmontools
    brightnessctl
    chromium
    dbeaver
    ctop
    bind
    skypeforlinux
    ripgrep
    htop
    mtr
    nmap
    tldr
    discord
    wireguard-tools
    docker-compose
    remmina
    grim
    wl-clipboard
    slurp
    freerdp
    openssl
    thunderbird
    ledger-live-desktop
    rustup
    gcc
    go
    hugo
    inkscape
    bintools-unwrapped
    qbittorrent
    mpv
    dolphin
    traceroute
    s3cmd
    unstable.drawio
    xdg-utils
    rclone
    rclone-browser
    wineWowPackages.stable
    playonlinux
    python3
    just
    nushell
    go-task
    minikube
    kubectl
    tcpdump
    whois
    libreoffice
    anydesk
    xclip
    busybox
  ];

  xdg.portal.enable = true;
  services.flatpak.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "dsuetin" ];

  environment.sessionVariables = rec {
    TERMINAL="/run/current-system/sw/bin/kitty";
  };

  # Java
  programs.java.enable = true;


  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };
  services.pcscd.enable = true;

  programs.steam.enable = true;
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        icu
      ];
    };
  };

  virtualisation.docker.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  networking.firewall = {
   # wireguard trips rpfilter up
   extraCommands = ''
     ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --sport 40613 -j RETURN
     ip46tables -t raw -I nixos-fw-rpfilter -p udp -m udp --dport 40613 -j RETURN
   '';
   extraStopCommands = ''
     ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --sport 40613 -j RETURN || true
     ip46tables -t raw -D nixos-fw-rpfilter -p udp -m udp --dport 40613 -j RETURN || true
   '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

