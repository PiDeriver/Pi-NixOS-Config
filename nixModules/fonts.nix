{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
#    ipafont
#    kochi-substitute
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "JetBrainsMono Ner Font Mono"
      "Noto Sans CJK"
    ];
    sansSerif = [
      "DejaVu Sans"
      "Noto Sans CJK"
    ];
    serif = [
      "DejaVu Serif"
      "Noto Serif CJK"
    ];
  };
}
