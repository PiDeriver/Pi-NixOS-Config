{ pkgs, pkgs-stable, systemSettings, ... }:
{
  # First section is for unstable packages and the later sections are for stable
  home.packages = (with pkgs; [
    ### Stable Packages ###
    ## CLI utils ##

    # fetch files from web address
    wget

    # Used for desktop integration
    xdg-utils

    # get detailed hardware information
    lshw

    # System Monitor
    monitor

    #Tool to list open files
    lsof

    # Anime Tools
    ani-cli
    ani-skip

    ## Hardware and Peripherals ##

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

    ## Data manipulation ##

    # wayland clipboard utilities
    wl-clipboard
    # Zip Files
    zip
    unzip
    p7zip
    # Ebook Reader
    foliate
    # drag and drop utility
    dragon-drop

    ## Alternate browsers ##
    ungoogled-chromium

    ## Security ##
    # Password Manager
    bitwarden-desktop
    # VPN
    proton-vpn

    ## Games/Emulation ##
    # Sound Voltex Emulator
    unnamed-sdvx-clone
    # Wine Emulator
    winetricks
    wineWow64Packages.waylandFull
    bottles
    heroic
    # Wine Manager
    protonplus
    # Archipelago
    archipelago
    poptracker
    #Minecraft
    prismlauncher

    ## Video/Audio/Pictures ##
    # Video
    vlc
    # Music
    strawberry
    tauon
#    sayonara
    quodlibet-full
    # Recording
    obs-studio
    # Pictures
    krita
    gimp
    qimgv

    # ...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-desktop") [
    ### Unstable Desktop only ###
    
    # Torrent Client
    qbittorrent

    # XLR device
    goxlr-utility

    # Video Downloader
    tartube-yt-dlp

    # Possible clients for discord alternative
    element-desktop
    cinny-desktop
    revolt-desktop

    # ...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### Unstable Laptop only ###
    # Possible clients for discord alternative
    element-desktop
    cinny-desktop
    revolt-desktop
    
    # ...
  ])++ (with pkgs; [
    #### Stable Packages ####
    # Music Player
    spotify
    # Open-source office suite
    libreoffice

    # Console Emulators
    dolphin-emu
    parallel-launcher
    azahar
    melonds
    cemu

    # Backup Utility
    luckybackup

    #...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-desktop") [
    ### Stable Desktop only ###
    # Audio Editor
    reaper
    # Video Editor
    kdePackages.kdenlive
    
    # ...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### Stable Laptop only ###
    # DDR emulator
    stepmania

    # ...
  ]);

  #Add enviroment path for konaste
  home.sessionPath = [ "$HOME/.local/bin" ];
  
  #Change to custom cursor
  gtk.cursorTheme.name = "Chiharu";
  gtk.cursorTheme.size = 12;
}
