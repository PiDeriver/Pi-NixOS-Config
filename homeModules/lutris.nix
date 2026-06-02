{pkgs-stable, ... }: 
{
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs-stable; [mangohud winetricks gamemode umu-launcher libadwaita];
    protonPackages = [ pkgs-stable.proton-ge-bin ];
  };
}
