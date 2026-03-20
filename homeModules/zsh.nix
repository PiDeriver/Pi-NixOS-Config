{ config, ... }: 
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      update = "(cd $HOME/.dotfiles/; sudo nixos-rebuild switch --impure --flake . --option cores 8 --option max-jobs 6 2>&1 | grep -E -v 'Added input|follows|github:')";
      cfetch = "(cd $HOME/.dotfiles/cfetch-main/; ./cfetch)";
      disks = "sudo -E gparted";
      bms-init = "$HOME/.dotfiles/endlessDream/BMS-init.sh";
      bms = "lr2oraja-endlessdream;$HOME/.dotfiles/endlessDream/BMS-save.sh -pf";
      mountRemoteDrives = "bash $HOME/scripts/mountRemoteDrives.sh";
      umountRemoteDrives = "bash $HOME/scripts/umountRemoteDrives.sh";
    };
  }; 
}
