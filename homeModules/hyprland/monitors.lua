--***Monitors***

-- Primary Monitor
hl.monitor({
  output = "HDMI-A-1",
  mode = "2560x1440@120Hz",
  position = "auto-left",
  scale = 1
})
-- Secondary Monitor
hl.monitor({
  output = "DP-3",
  mode = "2560x1440@120Hz",
  position = "auto-right",
  scale = 1
})

--***Workspace Rules***

-- Primary Workspace
hl.workspace_rule({
  workspace = "1",
  monitor = "HDMI-A-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "2",
  monitor = "HDMI-A-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "3",
  monitor = "HDMI-A-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "4",
  monitor = "HDMI-A-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "5",
  monitor = "HDMI-A-1",
  persistent = true
})

-- Secondary Workspace
hl.workspace_rule({
  workspace = "6",
  monitor = "DP-3",
  persistent = true
})
hl.workspace_rule({
  workspace = "7",
  monitor = "DP-3",
  persistent = true
})
hl.workspace_rule({
  workspace = "8",
  monitor = "DP-3",
  persistent = true
})
hl.workspace_rule({
  workspace = "9",
  monitor = "DP-3",
  persistent = true
})
