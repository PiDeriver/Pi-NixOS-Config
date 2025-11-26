{ lib, userSettings, systemSettings, ... }:

{
  imports = [
    ### environment ###

    # window manager
    homeModules/hyprland.nix
    # taskbar
    homeModules/waybar.nix
    # menu generator
    homeModules/rofi.nix
    # wallpaper util
    homeModules/hyprpaper.nix
    # notification daemon
    homeModules/mako.nix
    # window portal
    homeModules/xdg-portal.nix
    # screenshot util
    homeModules/hyprshot.nix

    ### basic programs ###

    # terminal emulator
    homeModules/${userSettings.terminal}.nix
    # browser
    homeModules/${userSettings.browser}.nix
    # file manager
    homeModules/${userSettings.fileManager}.nix
    # text editor   
    homeModules/${userSettings.editor}.nix
    ### CLI tools ###

    # zsh
    homeModules/zsh.nix
    # git
    homeModules/git.nix
    # fzf, general fuzzy finder
    homeModules/fzf.nix

    # other packages to be managed by home-manager
    homeModules/homePackages.nix

    ### Wine programs ###
    homeModules/lutris.nix
  
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-desktop") [
    ### desktop only ###

    # discord client
    homeModules/vesktop.nix
    # ...
  ] ++ lib.optionals (systemSettings.hostname == "pi-nixos-laptop") [
    ### laptop only ###

    # discord client
    homeModules/vesktop.nix
  ];
  
  # extra info for home-manager
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
  home.stateVersion = "25.05";
  
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
