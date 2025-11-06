{ pkgs, ... }:
{
  users.users.pideriver = {
    isNormalUser = true;
    description = "PiDeriver";
    extraGroups = [ 
      "networkmanager" # network managing privileges
      "wheel" # sudouser
      "scanner" # SANE scanner privileges
      "lp" # CUPS printing privileges
      "video" # allows backlight control with light
    ];
  };
}
