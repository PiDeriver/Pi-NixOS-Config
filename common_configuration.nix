{ systemSettings, ... }:
{
  imports = [
    ### System services ###
    nixModules/boot.nix
    nixModules/login.nix
    nixModules/networking.nix
    nixModules/shells.nix
    nixModules/localization.nix

    ### Hardware and Peripherals ###
    ./${systemSettings.hostname}_hardware-configuration.nix
    nixModules/${systemSettings.hostname}_gpu.nix
    nixModules/keyboard.nix
    nixModules/audio.nix
    nixModules/print.nix
    nixModules/bluetooth.nix
    
    ### Users ###
    nixModules/users/user_pideriver.nix

    ### Theming ###
    nixModules/stylix.nix

  ];
  
  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # enable flatpak
  services.flatpak.enable = true;
  
  system.stateVersion = "25.05";
}
