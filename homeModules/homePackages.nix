{ pkgs, systemSettings, ... }:
{
  home.packages = with pkgs; [
    ### CLI utils ###

    # fetch files from web address
    wget

    # get detailed hardware information
    lshw

    # Anime Tools
    ani-cli
    ani-skip
    
    # Audio Visualizer (used in waybar)
#    cava

    ### Hardware and Peripherals ###

    # Open-source CLI tool to manage headset settings
    headsetcontrol
    # volume control GUI
    pavucontrol
    # Command line monitor tool
    xorg.xrandr

    ### Data manipulation ###

    # wayland clipboard utilities
    wl-clipboard
    # Open-source office suite
    libreoffice
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
    lutris
    wine
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
}
