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
11. Copy the hardware file from /etc/nixos and replace the one in the .dotfiles directory with desired hostname (do NOT add it to gitignore otherwise flake will prevent the file from being used)

12. cd $HOME/.dotfiles
13. sudo nixos-rebuild switch --flake .
