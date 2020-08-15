# ARQUIVO X, ORGANIZADO E CONFERIDO EM 18/5/2020 - POR WMQJR
# CONTÉM TODOS OS ELEMENTOS COMUNS A TODOS OS USUÁRIOS DO AMBIENTE GRÁFICO NA REDE
# ARQUIVOS ESPECÍFICOS DE USUÁRIOS COM PREVILÉGIOS ESTÃO RELACIONADOS NOS ARQUIVOS POR USUÁRIOS
#

{ pkgs, ... }: 

{

   #Open ports for KDE Connect
   networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
   networking.firewall.allowedUDPPortRanges = [ { from = 1717; to = 1764; } ];
  
   # Enable the X11 windowing system.
   services.xserver.enable = true;
   # Enable touchpad support.
   services.xserver.libinput.enable = true;
   # Use Plasma 5
   services.xserver.desktopManager.plasma5.enable = true;
   services.xserver.displayManager.defaultSession = "plasma5";
   services.xserver.layout = "br";
   services.xserver.xkbVariant = "abnt2";
 
   hardware.opengl.driSupport32Bit = true;

   # Online acoounts integration
   # enableOnlineAccounts = true; # NOT YET IMPLEMENTED
   environment.variables.SSO_PLUGINS_DIR = ["/run/current-system/sw/lib/signon"];
   environment.variables.SSO_EXTENSIONS_DIR = ["/run/current-system/sw/lib/signon/extensions"];

   # Fonts Settings.   
   fonts.enableFontDir = true;
   fonts.enableGhostscriptFonts = true;
   fonts.fonts = with pkgs;
    [ dina-font
      fira-code
      fira-code-symbols
      font-awesome-ttf 
      freefont_ttf 
      gentium 
      inconsolata
      liberation_ttf 
      liberationsansnarrow 
      libertine
      mplus-outline-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      opensans-ttf 
      proggyfonts
      source-code-pro  
      symbola 
      ttf_bitstream_vera 
      ubuntu_font_family 
      unifont 
    ];

   # User packages for graphic environment.
   environment.systemPackages = with pkgs; with qt5; with libsForQt5; 
    [ # Password manager for KDE
      kdeFrameworks.kwallet 
      kdeFrameworks.kconfigwidgets
      kdeFrameworks.kio
      kdeFrameworks.kconfig      
      kdeFrameworks.bluez-qt

      # This is needed for graphical dialogs used to enter GPG passphrases
      kdeplasma-addons

      # Plasma System Settings 
      plasma5.systemsettings
      plasma5.libkscreen
      plasma5.kdecoration
      plasma5.khotkeys
      plasma5.libksysguard	
      plasma5.polkit-kde-agent
      plasma5.powerdevil
      # plasma5.sddm-kcm
      plasma5.user-manager
      
      plasma-browser-integration
      plasma-integration
      plasma-desktop
      plasma-workspace
      plasma-pa
      plasma-nm
      

      # Screenshots
      kdeApplications.spectacle
      kdeApplications.kwalletmanager
      # Printing and scanning
      kdeApplications.print-manager
      kdeApplications.dolphin-plugins
      kdeApplications.kio-extras
      kdeApplications.knotes
      # Desktop sharing tool
      kdeApplications.krfb              
      # kdeApplications.kaccounts-providers    
      # kdeApplications.kaccounts-integration
      # kdeApplications.signon-kwallet-extension

      # KDE apps
      kscreen
      konsole
      kcalc
      kwalletcli
      # Allow automatic unlocking of kwallet if the same password. This seems to work without installing kwallet-pam.
      kwallet-pam
      # ssh-add prompts a user for a passphrase using KDE. Not sure if it is used by anything? ssh-add just asks passphrase on the console.
      ksshaskpass
      # GPG manager for KDE
      kgpg
      # Text editor
      kate
      # Archives (e.g., tar.gz and zip)
      ark
      # Browsers
      chromium
      dolphin
      # Office Suit
      libreoffice
      # Spell checker 
      sonnet
       aspellDicts.en
       aspellDicts.es
       aspellDicts.fr
       aspellDicts.pt_BR
      # Document readers
      okular
      # Media player
      pacman
      # Suporte SegFy e TI
      teamviewer
      unrar
      vlc

      # kio-gdrive    
       #libsForQt5.signond                     
       #libsForQt5.signon-ui
       #libsForQt5.signon-plugin-oauth2
    ];
  }
