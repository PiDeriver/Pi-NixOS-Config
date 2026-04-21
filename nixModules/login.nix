{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd \"start-hyprland > /dev/null\""; # Or your preferred shell
      };
    };
  };
}
