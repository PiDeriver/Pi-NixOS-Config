{ pkgs, pkgs-stable, systemSettings, ... }:
{
  # First section is for unstable packages and the later sections are for stable
  home.packages = (with pkgs; [
    ### Unstable Packages ###
    ## CLI utils ##

    # fetch files from web address
    wget

    # Used for desktop integration
    xdg-utils

    # get detailed hardware information
    lshw

    # System Monitor
    monitor

    # Tool to list open files
    lsof

    # Anime Tools
    ani-cli
    ani-skip

    # Key Generation
    openssl_3

    # Download tool
#    fanbox-dl

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
    # Disk health checking and monitoring
    smartmontools
    # Remote drive tools
    cifs-utils
    nfs-utils
    
    ## Data manipulation ##

    # GUI file manager
    nemo-with-extensions
    nemo-python
    nemo-emblems
    folder-color-switcher
    nemo-fileroller
    file-roller #This is an archive manager
    kdePackages.filelight #GUI disk space usage
    # wayland clipboard utilities
    wl-clipboard
    # Zip Files
    zip
    unzip
    p7zip
    unrar
    # Ebook Reader
    foliate
    # drag and drop utility
    dragon-drop

    ## Alternate browsers ##
    ungoogled-chromium
    brave

    ## Security ##
    # Password Manager
#    bitwarden-desktop
    # VPN
    proton-vpn

    ## Games/Emulation ##
    # Sound Voltex Emulator
    unnamed-sdvx-clone
    # Wine Emulator
    winetricks
    wineWow64Packages.waylandFull
#    bottles
    heroic
    # Wine Manager
    protonplus
    # Archipelago
    archipelago
    poptracker
    # Minecraft
    prismlauncher
    # Console
    shadps4-qtlauncher
    eden
    dolphin-emu

    ## Video/Audio/Pictures ##
    # Video
    vlc
    # Music
    finamp
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

    # Rip blu ray and dvd
#    makemkv


    # Possible clients for discord alternative
    element-desktop
    cinny-desktop
#    revolt-desktop

    # ...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### Unstable Laptop only ###
    # Possible clients for discord alternative
    element-desktop
    cinny-desktop
    
    # ...
  ])++ (with pkgs-stable; [
    #### Stable Packages ####
    # Music Player
    spotify

    # Open-source office suite
    libreoffice

    # Console Emulators
#    dolphin-emu
    parallel-launcher
    azahar
    melonds
    cemu
    ppsspp-sdl-wayland

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
