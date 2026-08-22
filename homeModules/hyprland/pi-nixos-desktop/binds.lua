--***Keybinds***

--**Long Press (Rotating monitors and shutdown)**
--Rotate Primary Monitor
hl.bind("CTRL + ALT + down",function() return hl.monitor({output = "HDMI-A-1", mode = "2560x1440@120Hz", position = "auto-left", scale = 1, transform = 0}) end,{long_press = true})
hl.bind("CTRL + ALT + left",function() return hl.monitor({output = "HDMI-A-1", mode = "2560x1440@120Hz", position = "auto-left", scale = 1, transform = 1}) end,{long_press = true})
hl.bind("CTRL + ALT + up",function() return hl.monitor({output = "HDMI-A-1", mode = "2560x1440@120Hz", position = "auto-left", scale = 1, transform = 2}) end,{long_press = true})
hl.bind("CTRL + ALT + right",function() return hl.monitor({output = "HDMI-A-1", mode = "2560x1440@120Hz", position = "auto-left", scale = 1, transform = 3}) end,{long_press = true})
--Rotate Secondary Monitor
hl.bind("CTRL + ALT + SHIFT + down",function() return hl.monitor({output = "DP-3", mode = "2560x1440@120Hz", position = "auto-right", scale = 1, transform = 0}) end,{long_press = true})
hl.bind("CTRL + ALT + SHIFT + left",function() return hl.monitor({output = "DP-3", mode = "2560x1440@120Hz", position = "auto-right", scale = 1, transform = 1}) end,{long_press = true})
hl.bind("CTRL + ALT + SHIFT + up",function() return hl.monitor({output = "DP-3", mode = "2560x1440@120Hz", position = "auto-right", scale = 1, transform = 2}) end,{long_press = true})
hl.bind("CTRL + ALT + SHIFT + right",function() return hl.monitor({output = "DP-3", mode = "2560x1440@120Hz", position = "auto-right", scale = 1, transform = 3}) end,{long_press = true})
--if above doesn't work, refactor to version below
--hl.bind(mod .. " + CTRL + ALT + down",hl.dsp.exec_cmd("hyprctl keyword monitor HDMI-A-1, 2560x1440@120Hz, auto-left, 1, transform, 0"),{long_press = true})


--shutdown now
hl.bind(mod .. "+ Escape",hl.dsp.exec_cmd("shutdown now"),{long_press = true})


--**Mouse Binds**
hl.bind(mod .. "+ mouse:272",hl.dsp.window.drag(),{mouse = true})
hl.bind(mod .. "+ mouse:273",hl.dsp.window.resize(),{mouse = true})


--**Terminal and Programs**
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + KP_ENTER", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))

--PrintScreen (Capture area, window, or monitor)
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))


--**Window**
--Close and Kill Window
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + C", hl.dsp.window.kill())

--Window Manipulation
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + Y", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))


--**Workspaces**
--Move Focus
hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

--Scroll Through Workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

--Special Workspaces
hl.bind(mod .. " + KP_Insert", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + KP_Insert", hl.dsp.window.move({ workspace = "special:magic" }))

--*Map Workspaces*
for i = 1, 9 do
    --Map 1-9
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    --Map Numpad 1-9
    local numpadkey = { "KP_End", "KP_Down", "KP_Next", "KP_Left", "KP_Begin", "KP_Right", "KP_Home", "KP_Up", "KP_Prior" }
    hl.bind("SUPER + " .. numpadkey[i],hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. numpadkey[i], hl.dsp.window.move({ workspace = i }))
end
