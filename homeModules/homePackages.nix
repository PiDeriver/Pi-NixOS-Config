{ pkgs, systemSettings, ... }:
{
  home.packages = with pkgs; [
    ### CLI utils ###

    # fetch files from web address
    wget

    # Linux コナステ dependancies
    xdg-utils
    zenity
    (import ../konaste-linux/install-konaste.nix)

    # get detailed hardware information
    lshw

    # System Monitor
    monitor

    # Anime Tools
    ani-cli
    ani-skip

    ### Hardware and Peripherals ###

    # Open-source CLI tool to manage headset settings
    headsetcontrol
    # volume control GUI
    pavucontrol
    # Command line monitor tool
    xorg.xrandr
    # GTK patchbay for pipewire
    helvum

    ### Data manipulation ###

    # wayland clipboard utilities
    wl-clipboard
    # Open-source office suite
    libreoffice
    # Zip Files
    zip
    unzip
    # Ebook Reader
    foliate
    # drag and drop utility
    dragon-drop

    ### Alternate browsers ###
    ungoogled-chromium
    librewolf

    ### Security ###
    # Password Manager
    bitwarden-desktop
    # VPN
    protonvpn-gui

    ### Games/Emulation ###
    # Sound Voltex Emulator
    unnamed-sdvx-clone
    # Wine Emulator
    winetricks
    wineWowPackages.full
    bottles
    # Wine Manager
    protonplus
    # Console Emulators
    dolphin-emu
    parallel-launcher
    azahar
    melonDS
    cemu
    # Archipelago
    archipelago
    poptracker

    ### Video/Audio/Pictures ###
    # Video
    vlc
    # Recording
    obs-studio
    # Music
    spotify
    # Pictures
    krita
    #gimp

    ### Backup Utility ###
    luckybackup

    ### Custom Cursor ###
#    win2xcur
#    hyprcursor
#    rose-pine-hyprcursor

  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-desktop") [
    ### Desktop only ###
    # Video Editor
    kdePackages.kdenlive
    # Audio Editor
    reaper
    # Torrent Client
    qbittorrent
    # XLR device
    goxlr-utility
    # Video Downloader
    ytdownloader
    # ...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### Laptop only ###

    # DDR emulator
    stepmania
  ];

  #Add enviroment path for konaste
  home.sessionPath = [ "$HOME/.local/bin" ];
  
  #Change to custom cursor
  gtk.cursorTheme.name = "Chiharu";
  gtk.cursorTheme.size = 12;
#  home.pointerCursor = {
#    gtk.enable = true;
#    x11.enable = true;
#    name = "Chiharu";
#    size = 12;
#  };
#  xsession.pointerCursor.name = "Chiharu";
#  xsession.pointerCursor.size = 12;
#  xsession.pointerCursor.defaultCursor = "Chiharu";

}
