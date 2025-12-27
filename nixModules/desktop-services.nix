{ pkgs, ... }:
{
  xdg.autostart.enable = true;
  services.goxlr-utility.enable = true;
  services.goxlr-utility.autoStart.xdg = true;
}
