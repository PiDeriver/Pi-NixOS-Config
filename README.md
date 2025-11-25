For first build:

1. cd /etc/nixos
2. sudo nano configuration.nix

3. Change hostname to desired build (pi-nixos-laoptop or pi-nixos-desktop)
4. And add the lines below:
5. nix.settings.experimental-features = [ "nix-command" "flakes" ];
6. programs.git.enable = true;

7. sudo nixos-rebuild switch
8. reboot

9. copy everything to $HOME/.dotfiles
10. Make sure to change the home.nix hostname (for lib.optionals), homePackages.nix hostname, and flakes.nix hostname (near the bottom of file) to whatever hostnames are being used
11. This now uses the hardware-configuration.nix file stored in /etc/nixos/ so it no longer needs to be copied to the .dotfiles directory

12. cd $HOME/.dotfiles
13. sudo nixos-rebuild switch --impure --flake .
