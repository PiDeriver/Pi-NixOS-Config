{ userSettings, systemSettings, ... }: 
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings =
      let
        isDesktop = (systemSettings.hostname == "pi-nixos-desktop");

        monitorConfig =
          if isDesktop then [
            ### Desktop Setup ###
            "HDMI-A-1, preferred, auto-left, 1" # Primary
            "DP-3, preferred, auto-right, 1"     # Secondary (if it exists)
          ] else [
            ### Laptop Setup ###
            "eDP-1, preferred, auto, 1"    # Primary
            "HDMI-A-4, preferred, auto, 1" # Secondary
          ];

        workspaceRules =
          if isDesktop then [
            ### Desktop Workspaces ###
            "1, monitor:HDMI-A-1, persistent:true"
            "2, monitor:HDMI-A-1, persistent:true"
            "3, monitor:HDMI-A-1, persistent:true"
            "4, monitor:HDMI-A-1, persistent:true"
            "5, monitor:HDMI-A-1, persistent:true"
            "6, monitor:DP-3, persistent:true"  # Workspaces 6-9 on the DP-1 monitor
            "7, monitor:DP-3, persistent:true"
            "8, monitor:DP-3, persistent:true"
            "9, monitor:DP-3, persistent:true"
          ] else [
            ### Laptop Workspaces ###
            "1, monitor:eDP-1, persistent:true"
            "2, monitor:eDP-1, persistent:true"
            "3, monitor:eDP-1, persistent:true"
            "4, monitor:eDP-1, persistent:true"
            "5, monitor:eDP-1, persistent:true"
            "6, monitor:HDMI-A-4, persistent:true" # Workspaces 6-9 on the HDMI-A-1 monitor
            "7, monitor:HDMI-A-4, persistent:true"
            "8, monitor:HDMI-A-4, persistent:true"
            "9, monitor:HDMI-A-4, persistent:true"
          ];
        in {
      monitor = monitorConfig;
      workspace = workspaceRules;
      # set variables and programs
      "$mod" = "SUPER";
      "$terminal" = "${userSettings.terminal}";
      "$browser" = "${userSettings.browser}";
      "$menu" = "rofi -show drun -show-icons";
	
      general = {
        # ...
      };

      input = {
        numlock_by_default = true;
      };

      ### startup ###


      exec-once = [
        "waybar &"
      ];

      ### hotkeys ###
      bind = [

	"$mod, RETURN, exec, $terminal"
	"$mod, C, killactive"
	"$mod, Escape, exit"
	"$mod, F, exec, $browser"
	"$mod, R, exec, $menu"
        
	# PrintScreen -> Capture area
	"$mod SHIFT, S, exec, hyprshot -m region"
	  
	# Shift + PrintScreen -> Capture current output (monitor)
	"SHIFT, Print, exec, hyprshot -m output"
	  
	# Ctrl + PrintScreen -> Capture active window
	"CTRL, Print, exec, hyprshot -m window"

	### workspaces ###

	# move focus within workspace
	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"
	
	# change workspace orientation
	"$mod, P, pseudo"
	"$mod, J, togglesplit"
	# Zero-in Workspace
	"$mod, KP_Insert, togglespecialworkspace, magic"
	"$mod SHIFT, KP_Insert, movetoworkspace, special:magic"
	# Scroll through workspaces
	"$mod, mouse_down, workspace, r+1"
	"$mod, mouse_up, workspace, r-1"
      ] ++ (
	# Map workspaces to numpad keycodes
	let
	  numpadCodes = [ "KP_End" "KP_Down" "KP_Next" "KP_Left" "KP_Begin" "KP_Right" "KP_Home" "KP_Up" "KP_Prior" ];
	  keybindings = builtins.concatMap (
	  i:
	    let
	      ws = builtins.toString (i + 1);
	      code = builtins.toString (builtins.elemAt numpadCodes i);
	    in [
              "$mod, ${code}, workspace, ${ws}"
              "$mod SHIFT, ${code}, movetoworkspace, ${ws}"
            ]
	  ) (builtins.genList(i: i) (builtins.length numpadCodes));
	in
	  keybindings
      ) ++ (
        # Map workspaces to top-row number keys
        builtins.concatMap (
          i:
          let
            ws = builtins.toString (i + 1);
            # The key code for top-row numbers is just the number itself
            code = builtins.toString (i + 1);
          in [
            "$mod, ${code}, workspace, ${ws}"
            "$mod SHIFT, ${code}, movetoworkspace, ${ws}"
          ]
        ) (builtins.genList(i: i) 9) # Generate for numbers 1-9
      );
    };
  };
}
