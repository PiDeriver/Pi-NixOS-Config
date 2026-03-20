{ pkgs, pkgs-stable, systemSettings, ... }:
{
  #Defaulting to stable packages in the first section then using the second section for unstable packages
  home.packages = (with pkgs-stable; [
    ##### Stable Packages #####

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

    #Tool to list open files
    lsof

    # Anime Tools
    ani-cli
    ani-skip

    ### Hardware and Peripherals ###

    # Open-source CLI tool to manage headset settings
    headsetcontrol
    # volume control GUI
    pavucontrol
    # Command line monitor tool
    xrandr
    # Audio patchbay
    qpwgraph
    # Disk tool
    gparted
    ntfs3g
    # Remote drive tools
    cifs-utils
    nfs-utils

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

    ### Security ###
    # Password Manager
    bitwarden-desktop
    # VPN
    protonvpn-gui

    ### Games/Emulation ###
    # Console Emulators
    parallel-launcher

    ### Video/Audio/Pictures ###
    # Music
    spotify
    # Pictures
    krita
    gimp
    qimgv

    ### Backup Utility ###
    luckybackup

  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-desktop") [
    ### Desktop only (stable) ###
    # Video Editor
    kdePackages.kdenlive
    
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### Laptop only (stable) ###

    # ...
  ])++ (with pkgs; [
    ##### Unstable Packages #####

    ### Games/Emulation ###
    # Sound Voltex Emulator
    unnamed-sdvx-clone
    # Wine Emulator
    winetricks
    wineWow64Packages.waylandFull
    bottles
    heroic
    # Wine Manager
    protonplus
    # Console Emulators
    dolphin-emu
    azahar
    melonds
    cemu
    # Archipelago
    archipelago
    poptracker

    ### Video/Audio/Pictures ###
    # Video
    vlc
    # Recording
    obs-studio

  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-desktop") [
    ### Desktop only (Unstable) ###
    # Torrent Client
    qbittorrent
    # XLR device
    goxlr-utility
    # Video Downloader
    tartube-yt-dlp
    # Possible client for discord alternative
    element-desktop

  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### Laptop only (Unstable) ###

    # DDR emulator
    stepmania

  ]);

  #Add enviroment path for konaste
  home.sessionPath = [ "$HOME/.local/bin" ];
  
  #Change to custom cursor
  gtk.cursorTheme.name = "Chiharu";
  gtk.cursorTheme.size = 12;
}
