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
    
    ### Hardware and Peripherals ###

    # Open-source CLI tool to manage headset settings
    headsetcontrol
    # volume control GUI
    pavucontrol

    ### Data manipulation ###

    # wayland clipboard utilities
    wl-clipboard
    # Open-source office suite
    libreoffice
    # drag and drop utility
    dragon-drop

    ### Alternate browsers ###
    ungoogled-chromium
    librewolf

    ### Security ###
    # Password Manager
    bitwarden
    # VPN
    protonvpn-gui

    ### Games/Emulation ###
    # Sound Voltex Emulator
    unnamed-sdvx-clone
    # Wine Emulator
    lutris
    wine
    # Wine Manager
    protonplus
    # Console Emulators
    dolphin-emu
##    parallel-launcher #Why is this broken ;-;
    azahar
    melonDS
    cemu

    ### Video/Audio/Pictures ###
    # Video
    vlc
    # Music
    spotify


    ### Backup Utility ###
    luckybackup



  ] ++ lib.optionals (systemSettings.hostname == "nixos-desktop") [
    ### Desktop only ###
    # Video Editor
    ##kdenlive #This also seems to be broken
    # Audio Editor
    reaper
    # Torrent Client
    qbittorrent

    # ...
  ] ++ lib.optionals (systemSettings.hostname == "nixos-laptop") [
    ### Laptop only ###

    # DDR emulator
    stepmania
  ];
}
