{ config, ... }: 
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      update = "(cd $HOME/.dotfiles/; sudo nixos-rebuild switch --impure --flake . --option cores 8 --option max-jobs 6 2>&1 | grep -E -v 'Added input|follows|github:')";
      updateReboot = "(cd $HOME/.dotfiles/; sudo nixos-rebuild boot --impure --flake . --option cores 8 --option max-jobs 6 2>&1 | grep -E -v 'Added input|follows|github:')";
      updateRollback = "(cd $HOME/.dotfiles/; sudo nixos-rebuild switch --rollback)";
      cfetch = "(cd $HOME/.dotfiles/cfetch-main/; ./cfetch)";
      disks = "sudo -E gparted";
      bms-init = "$HOME/.dotfiles/endlessDream/BMS-init.sh";
      bms = "lr2oraja-endlessdream;$HOME/.dotfiles/endlessDream/BMS-save.sh -pf";
      collectGarbage = "sudo nix-collect-garbage --delete-older-than 7d";
    };
  }; 
}
