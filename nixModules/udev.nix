{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.dolphin-emu ];
}
