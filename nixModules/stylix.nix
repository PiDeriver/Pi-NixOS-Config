{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = ../theme/chiharutheme.yaml;
    image = ../theme/wallpaper.png;
    #targets.vesktop.enable = false;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
	name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
	name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
	name = "DejaVu Serif";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };
  };
}
