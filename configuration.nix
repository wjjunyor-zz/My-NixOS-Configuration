# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Enable the KDE Desktop Environment.
      ./user-configuration.nix
      ./local-configuration.nix
      ./wjjunyor-configuration.nix
      ./x-configuration.nix
      # Sets-ip the Home Manager
      # "${home-manager}/nixos"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  # Uses the most recent packages.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Grub menu is painted really slowly on HiDPI, so we lower the
  # resolution. Unfortunately, scaling to 1280x720 (keeping aspect
  # ratio) doesn't seem to work, so we just pick another low one.
  boot.loader.grub.gfxmodeEfi = "1024x768";
  boot.loader.grub.enableCryptodisk = true;
  boot.initrd.luks.devices = {
    "root" = {
    device = "/dev/disk/by-uuid/d83054a8-ef44-4e19-99a9-d498ba6a6d62";
    preLVM = true;
    allowDiscards = true;
    };
  };

  # Networking set-up
  networking.hostName = "T101"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.nameservers = [ "84.200.69.80" "84.200.70.40" ]; # CloudFlare / DNS Watch
  
  # Wi-fi corporate network set-up
  networking.wireless.networks = {
    "walCOR Seguros" = {         # SSID with spaces and/or special characters
    pskRaw = "8800e2ad89df3154f75d1f2b7945588309b9ccde7b2761389f599f2f0674c489";
    };
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp1s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console.font = "Lat2-Terminus32";   
  console.keyMap = "br-abnt2";
  i18n.defaultLocale = "pt_BR.UTF-8";
  
  # Set your time zone.
  time.timeZone = "America/Campo_Grande";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Team Viewer Listener
  services.teamviewer.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  
  powerManagement.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
  
  # Auto upgrade Always ON.
  system.autoUpgrade.enable = true;

  # Fundamental core packages
  environment.systemPackages = with pkgs; 
   [ # Basic command line tools
     bash
     wget
     file
     gksu
     git
     hdf5
     zip
     unzip
     htop
     yle-dl
     youtube-dl
     # Tool for searching files/binaries from Nix packages
     nix-index
     dnsutils
     whois
     coreutils
     vbetool
     killall
     nethogs
     unrar
     # Gamin: a file and directory monitoring system
     fam
     # Basic image manipulation and handling stuff
     imagemagick
     ghostscript
     # Text editors
     vim
     # system clipboard support for vim
     xclip
     # VPN
     pptp
     openvpn
     # File format conversions
     pandoc
     pdf2svg
     # Screen brightness and temperature
     # redshift
     # SSH filesystem
     sshfsFuse
     # Yet another dotfile manager
     yadm
     # Password hash generator
     mkpasswd
     # Android
     jmtpfs
     gphoto2
     libmtp
     mtpfs
     nix-prefetch-git
     # Make NTFS filesystems (e.g., USB drives)
     ntfs3g
     # GUI for sound control
     pavucontrol
     # python3Packages.magic-wormhole   
     # Bluetooth Support
     bluez
     bluezFull
     bluez-tools
   ];
}
