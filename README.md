For first build:

cd /etc/nixos
sudo nano configuration.nix

Change hostname to desired build (pi-nixos-laoptop or pi-nixos-desktop)
And add the lines below:
nix.settings.experimental-features = [ "nix-command" "flakes" ];
programs.git.enable = true;

sudo nixos-rebuild switch
reboot

copy everything to $HOME/.dotfiles
Make sure to change the home.nix hostname (for lib.optionals) and flakes.nix hostname (near the bottom of file) to whatever hostnames are being used
Replace the hardware file in .dotfiles with the one from /etc/nixos and make sure to rename it

cd $HOME/.dotfiles
sudo nixos-rebuild switch --flake .
