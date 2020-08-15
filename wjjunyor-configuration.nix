{ config, lib, options, modulesPath, users, pkgs, environment }: 
{

  # Allow GPU Driver for T-101 station.
  nixpkgs.config.allowUnfree = true;

  # Nix daemon allowance for this user.
  nix.allowedUsers = [ "@wheel" "wjjunyor" ];

  # Specific services to be enabled for this user. 
  services.openssh.enable = true;
  # services.tor.client.enable = true;
  # services.tor.client.transparentProxy.enable =  true;
  # services.blueman.enable = true;      # Estudar esta parada pois quero BT em meu note 
  
  # Loads GPU drivers on T-101 station.
  services.xserver.videoDrivers = [ "intel" "amdgpu" ];

  # Enable SmarCard Daemon.
  services.pcscd.enable = true; 
  services.pcscd.plugins =  with pkgs;
   [ acsccid                   # SmartCard Apps 
     ccid 
     # chrome-token-signing      # Chrome and Firefox extension for signing with your eID on the web
     cryptsetup                # Encrypted USB sticks etc
     eid-mw                    # Belgian electronic identity card (eID) middleware VAI QUE 
     encfs
     gnupg                     # Encryption key management
     gnupg-pkcs11-scd          # A smart-card daemon to enable the use of PKCS#11 tokens with GnuPG   
     gnupg1orig
     glibc                     # Para o WebSigner Certsign 
     # globalplatform            # Library for interacting with smart card devices                      # NOT WORKING
     # gpshell                   # Smartcard management application                                     # NOT WORKING
     libfx2                    # Chip support package for Cypress EZ-USB FX2 series microcontrollers
     libusb 
     libusb1 
     opensc                    # Set of libraries and utilities to access smart cards
     openct                    # Drivers for several smart card readers
     openssl 
     pcsctools 
     pcsc-cyberjack     
     pcsclite 
     pcmciaUtils               # PCMCIA Tools 
     pinentry                  # GPG password entry from the terminal
     usbutils
   ];
  
  # Specific programs for this user
  programs.adb.enable = true;
 
  # Specific hardware setings for this user
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

  # User fonts.   
  fonts.fonts = with pkgs;
   [ aileron
     aminal
     ankacoder
     b612
     baekmuk-ttf
     cnstrokeorder
     comfortaa
     comic-neue
     crimson
     encode-sans
     # euvypn-font
     eunomia
     f5_6
     font-awesome_4
     font-awesome
     gohufont
     google-fonts
     gubbi-font
     hanazono
     helvetica-neue-lt-std
     hermit
     hyperscrypt-font
     ipaexfont
     luculent
     norwester-font
     noto-fonts
     overpass
     pecita
     penna
     # ricty
     roboto
     source-sans-pro
   ];

  # Specific packages for graphic environment for this user
  environment.systemPackages = with pkgs;
   [ # Drop-down terminal
     yakuake
     gimp-with-plugins #  Photo/Image Editor
     gparted
     # Vector Editor 
     inkscape
     # ps2edit #For .eps file 
     # Torrenting
     ktorrent
     # Browsers Suport 
     # firefox-wayland 
     # firefox
     firefox-beta-bin
     # Instant messaging
     # cutegram
     tdesktop    #Telegram
     # element-web
     element-desktop
     linphone
     #haskellPackage.signal
     signal-cli
     signal-desktop
     # Mobile device connect 
     kdeconnect
     # SU
     kdesu
     # ZOOM Meeting - Tirar depois de usar essa coisa unsafe da porra
     zoom-us
     # E-books
     fbreader
     calibre
     adobe-reader
     # Browser
     tor-arm
     tor                            # PARA PRODUÇÃO DEIXAR O TOR E OS FIREFOX SOMENTE PARA OS USUÁRIOS wjjunyor e caroles.melo
     tor-browser-bundle-bin         # Erro Download
     # Instant messaging
     # cutegram
     # For Whatsapp Bridging on Riot
     # mautrix-whatsapp 
     # RSS Reader
     rssguard
     # FTP Client
     filezilla
     # Password manager
     # keepass-keeagent
     # keepass-keepasshttp
     # keepass
     # Separate tiling window manager
     # i3
     patchelf
     # JOGOS DA QUARENTENA
     libGL
     discord
     minecraft
     # Mobile SSH replacement
     mosh
     k3b
     #Wireless 
     wirelesstools
     networkmanager
      # Bluetooth
      # bluedevil
     # Cosmos Application from Cardiff University requires JAVA
     jre
     jdk 	 
   ];
}

