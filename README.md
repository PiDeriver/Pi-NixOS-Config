For first build:

cd /etc/nixos
sudo nano configuration.nix

Change hostname to desired build (pi-nixos-laoptop or pi-nixos-desktop)
And add line below:
nix.settings.experimental-features = [ "nix-command" "flakes" ];

sudo nixos-rebuild switch
reboot

copy everything to $HOME/.dotfiles

cd $HOME/.dotfiles
sudo nixos-rebuild switch --flake .
