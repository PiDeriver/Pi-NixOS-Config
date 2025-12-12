{ ... }: 
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      update = "(cd $HOME/.dotfiles/; sudo nixos-rebuild switch --impure --flake . 2>&1 | grep -E -v 'Added input|follows|github:')";
      cfetch = "(cd $HOME/.dotfiles/cfetch-main/; ./cfetch)";
      disks = "sudo -E gparted";
      bms-init = "$HOME/.dotfiles/beatorajaInitialSetup/BMS-init.sh";
      bms = "beatoraja;$HOME/.dotfiles/beatorajaInitialSetup/BMS-save.sh -pf";
    };
  }; 
}
