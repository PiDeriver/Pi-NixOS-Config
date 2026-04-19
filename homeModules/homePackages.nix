{ pkgs, pkgs-stable, systemSettings, ... }:
{
  home.packages = (with pkgs; [
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
#    libreoffice
    # Zip Files
    zip
    unzip
    p7zip
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
    proton-vpn

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
    #Minecraft
    prismlauncher

    ### Video/Audio/Pictures ###
    # Video
    vlc
    # Recording
    obs-studio
    # Music
    spotify
    # Pictures
    krita
    gimp
    qimgv

    ### Backup Utility ###
    luckybackup

  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-desktop") [
    ### Desktop only ###
    # Video Editor
#    kdePackages.kdenlive #broke on unstable
    # Audio Editor
    reaper
    # Torrent Client
    qbittorrent
    # XLR device
    goxlr-utility
    # Video Downloader
    tartube-yt-dlp
    # Possible clients for discord alternative
    element-desktop
    cinny-desktop #Broken atm
    revolt-desktop
    # ...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### Laptop only ###

    # DDR emulator
    stepmania
  ])++ (with pkgs-stable; [
    ### Packages that break often and don't need to be bleeding edge ###
    parallel-launcher
#    cemu
#    dolphin-emu
    kdePackages.kdenlive
#    protonvpn-gui
#    libreoffice
  ]);

  #Add enviroment path for konaste
  home.sessionPath = [ "$HOME/.local/bin" ];
  
  #Change to custom cursor
  gtk.cursorTheme.name = "Chiharu";
  gtk.cursorTheme.size = 12;
}
