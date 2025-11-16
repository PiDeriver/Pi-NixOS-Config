{ ... }: 
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      update = "sudo nixos-rebuild switch --impure --flake . 2>&1 | grep -E -v 'Added input|follows|github:'";
      cfetch= "(cd /home/pideriver/.dotfiles/cfetch-main/; ./cfetch)";
    };
  }; 
}
