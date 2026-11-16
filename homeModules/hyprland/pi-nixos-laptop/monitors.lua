--***Monitors***

-- Primary Monitor
hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto",
  scale = 1
})
-- Secondary Monitor
hl.monitor({
  output = "HDMI-A-4",
  mode = "preferred",
  position = "auto",
  scale = 1
})

--***Workspace Rules***

-- Primary Workspace
hl.workspace_rule({
  workspace = "1",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "2",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "3",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "4",
  monitor = "eDP-1",
  persistent = true
})
hl.workspace_rule({
  workspace = "5",
  monitor = "eDP-1",
  persistent = true
})

-- Secondary Workspace
hl.workspace_rule({
  workspace = "6",
  monitor = "HDMI-A-4",
  persistent = true
})
hl.workspace_rule({
  workspace = "7",
  monitor = "HDMI-A-4",
  persistent = true
})
hl.workspace_rule({
  workspace = "8",
  monitor = "HDMI-A-4",
  persistent = true
})
hl.workspace_rule({
  workspace = "9",
  monitor = "HDMI-A-4",
  persistent = true
})
