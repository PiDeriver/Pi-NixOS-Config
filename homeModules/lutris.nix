{pkgs, ... }: 
{
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [mangohud winetricks gamemode umu-launcher libadwaita];
    #protonPackages = [ pkgs.proton-ge-bin ];
  };
}
