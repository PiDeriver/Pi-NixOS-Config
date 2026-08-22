{ userSettings, systemSettings, pkgs, ... }: 
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    configType = "lua";
    settings = {
      mod = {_var = "SUPER";};
      terminal = {_var = "${userSettings.terminal}";};
      browser = {_var = "${userSettings.browser}";};
      menu = {_var = "rofi -show drun -show-icons";};
    };

    #Any lua file that needs access to the above variables should be put in the extraConfig section and read into the main config file using builtins.readFile. It might be possible to do another way but this works for now. (like having nixos write a file and having using require to pull in variables) 
    extraConfig = ''
      ${builtins.readFile ./hyprland/${systemSettings.hostname}/binds.lua}
    '';

    extraLuaFiles = {
      "settings" = {content = ./hyprland/settings.lua; autoLoad = true;};
      "autostart" = {content = ./hyprland/${systemSettings.hostname}/autostart.lua; autoLoad = true;};
      "monitors" = {content = ./hyprland/${systemSettings.hostname}/monitors.lua; autoLoad = true;};
    };
  };
}
