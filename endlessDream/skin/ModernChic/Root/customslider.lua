--[[
    カスタムスライダーを定義する場合はここに記述
    @author : KASAKO
]]
local m = {}
-- サドプラ自動調節(HSFIX MAX MAIN時以外動作しない)
m.adjustedCover = function()
    -- BUTTON_HSFIX = 55;	0:OFF, 1:START, 2:MAX, 3:MAIN, 4:MIN
    -- レーンカバー量
    local lanecover_area = main_state.number(MAIN.NUM.LANECOVER1) / 1000
    -- リフト量
    local liftcover_area
    if main_state.option(MAIN.OP.LIFT1_ON) then
        liftcover_area = main_state.number(MAIN.NUM.LIFT1) / 1000
    else
        liftcover_area = 0
    end
    -- リフト量を除いたレーン幅
    local exceptLift = 1 - liftcover_area
    -- リフトを考慮したレーンカバー量
    local lanecover_fix = exceptLift * lanecover_area
    -- 隙間
    local space = (1 - lanecover_fix - liftcover_area)

    local event = main_state.event_index(MAIN.BUTTON.HSFIX)
    if event == 2 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.NOWBPM) / main_state.number(MAIN.NUM.MAXBPM)))
    elseif event == 3 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.NOWBPM) / main_state.number(MAIN.NUM.MAINBPM)))
    elseif event == 4 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.NOWBPM) / main_state.number(MAIN.NUM.MINBPM)))
    end
end

m.adjustedMinCover = function()
    -- BUTTON_HSFIX = 55;	0:OFF, 1:START, 2:MAX, 3:MAIN, 4:MIN
    -- BUTTON_HSFIX = 55;	0:OFF, 1:START, 2:MAX, 3:MAIN, 4:MIN
    -- レーンカバー量
    local lanecover_area = main_state.number(MAIN.NUM.LANECOVER1) / 1000
    -- リフト量
    local liftcover_area
    if main_state.option(MAIN.OP.LIFT1_ON) then
        liftcover_area = main_state.number(MAIN.NUM.LIFT1) / 1000
    else
        liftcover_area = 0
    end
    -- リフト量を除いたレーン幅
    local exceptLift = 1 - liftcover_area
    -- リフトを考慮したレーンカバー量
    local lanecover_fix = exceptLift * lanecover_area
    -- 隙間
    local space = (1 - lanecover_fix - liftcover_area)
    
    local event = main_state.event_index(MAIN.BUTTON.HSFIX)
    if event == 2 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.MINBPM) / main_state.number(MAIN.NUM.MAXBPM)))
    elseif event == 3 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.MINBPM) / main_state.number(MAIN.NUM.MAINBPM)))
    elseif event == 4 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.MINBPM) / main_state.number(MAIN.NUM.MINBPM)))
    end
end

m.adjustedMaxCover = function()
    -- BUTTON_HSFIX = 55;	0:OFF, 1:START, 2:MAX, 3:MAIN, 4:MIN
    -- BUTTON_HSFIX = 55;	0:OFF, 1:START, 2:MAX, 3:MAIN, 4:MIN
    -- レーンカバー量
    local lanecover_area = main_state.number(MAIN.NUM.LANECOVER1) / 1000
    -- リフト量
    local liftcover_area
    if main_state.option(MAIN.OP.LIFT1_ON) then
        liftcover_area = main_state.number(MAIN.NUM.LIFT1) / 1000
    else
        liftcover_area = 0
    end
    -- リフト量を除いたレーン幅
    local exceptLift = 1 - liftcover_area
    -- リフトを考慮したレーンカバー量
    local lanecover_fix = exceptLift * lanecover_area
    -- 隙間
    local space = (1 - lanecover_fix - liftcover_area)
    
    local event = main_state.event_index(MAIN.BUTTON.HSFIX)
    if event == 2 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.MAXBPM) / main_state.number(MAIN.NUM.MAXBPM)))
    elseif event == 3 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.MAXBPM) / main_state.number(MAIN.NUM.MAINBPM)))
    elseif event == 4 then
        return lanecover_fix + liftcover_area + (space - (space * main_state.number(MAIN.NUM.MAXBPM) / main_state.number(MAIN.NUM.MINBPM)))
    end
end

return m