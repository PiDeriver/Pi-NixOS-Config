{ userSettings, systemSettings, pkgs, ... }: 
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    configType = "lua";
    settings = {
 #     mod = {_var = "SUPER";};
 #     terminal = {_var = "${userSettings.terminal}";};
 #     browser = {_var = "${userSettings.browser}";};
 #     menu = {_var = "rofi -show drun -show-icons";};
    };

#    extraConfig = builtins.readFile ./hyprland/settings.lua + builtins.readFile ./hyprland/${systemSettings.hostname}/autostart.lua + builtins.readFile ./hyprland/${systemSettings.hostname}/binds.lua + builtins.readFile ./hyprland/${systemSettings.hostname}/monitors.lua;

    extraConfig = ''
      local mod = "SUPER"
      local terminal = "${userSettings.terminal}"
      local browser = "${userSettings.browser}"
      local menu = "rofi -show drun -show-icons"
    '';

#      ${builtins.readFile ./hyprland/hyprLuaImports.lua}
#      ${builtins.readFile ./hyprland/settings.lua}
#      ${builtins.readFile ./hyprland/${systemSettings.hostname}/autostart.lua}
#      ${builtins.readFile ./hyprland/${systemSettings.hostname}/binds.lua}
#      ${builtins.readFile ./hyprland/${systemSettings.hostname}/monitors.lua}


    extraLuaFiles = {
      "settings" = {content = ./hyprland/settings.lua; autoLoad = true;};
      "autostart" = {content = ./hyprland/${systemSettings.hostname}/autostart.lua; autoLoad = true;};
      "binds" = {content = ./hyprland/${systemSettings.hostname}/binds.lua; autoLoad = true;};
      "monitors" = {content = ./hyprland/${systemSettings.hostname}/monitors.lua; autoLoad = true;};
    };
  };
}
