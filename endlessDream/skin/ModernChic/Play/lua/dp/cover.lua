--[[
	レーンカバー、リフト、hiddenカバー
	@author : KASAKO
]]
local isLiftDisplay = CONFIG.play.liftDisplay
local side = {wd = {"Left", "Right"}, posx = {BASE.laneLeftPosX, BASE.laneRightPosX}}

-- リフト画像切替
local function changeLiftDisplay()
	isLiftDisplay = not isLiftDisplay
	return isLiftDisplay
end

local function cover(parts)
	-- disapearline : lift開始地点(判定位置)
	table.insert(parts.liftCover, {id = "liftCoverLeft", src = 19, x = 0, y = 0, w = 513, h = 853, disapearLine = 227})
	table.insert(parts.liftCover, {id = "liftCoverRight", src = 19, x = 0, y = 0, w = 513, h = 853, disapearLine = 227})
	-- disapearline : hidden開始地点(判定位置)
	-- hiddenは黒のドットで
	table.insert(parts.hiddenCover, {id = "hiddenCoverLeft", src = 1, x = 0, y = 0, w = 1, h = 1, disapearLine = 227})
	table.insert(parts.hiddenCover, {id = "hiddenCoverRight", src = 1, x = 0, y = 0, w = 1, h = 1, disapearLine = 227})
	if PROPERTY.islanecoverRotationSwitchOff() then
		table.insert(parts.image, {id = "laneCoverLeft2", src = 17, x = 0, y = 0, w = 513, h = 853})
		table.insert(parts.image, {id = "laneCoverRight2", src = 17, x = 0, y = 0, w = 513, h = 853})
		table.insert(parts.slider, {id = "laneCoverLeft", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , type = MAIN.SLIDER.LANECOVER})
		table.insert(parts.slider, {id = "laneCoverRight", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , type = MAIN.SLIDER.LANECOVER})
	elseif PROPERTY.islanecoverRotationSwitchOn() then
		table.insert(parts.image, {id = "laneCoverLeft2", src = 17, x = 0, y = 0, w = 513, h = 853})
		table.insert(parts.image, {id = "laneCoverRight2", src = 18, x = 0, y = 0, w = 513, h = 853})
		table.insert(parts.slider, {id = "laneCoverLeft", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , type = MAIN.SLIDER.LANECOVER})
		table.insert(parts.slider, {id = "laneCoverRight", src = 18, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , type = MAIN.SLIDER.LANECOVER})
	end
	for i = 1, 2, 1 do
		-- hidden y : disapearLine（lift開始点）- h
		table.insert(parts.destination, {id = "hiddenCover"..side.wd[i], dst = {{x = side.posx[i] + 3, y = -626, w = 513, h = 853}}})
		-- リフト y : disapearLine（lift開始点）- h
		table.insert(parts.destination, {id = "liftCover"..side.wd[i], draw = function() return isLiftDisplay end, dst = {{x = side.posx[i] + 3, y = -626, w = 513, h = 853}}})
		-- レーンカバー
		table.insert(parts.destination,	{id = "laneCover"..side.wd[i], loop = 1000, op = {-MAIN.OP.CONSTANT}, dst = {
			{time = 500, x = side.posx[i] + 3, y = 1080 + 853, w = 513, h = 853, acc = MAIN.ACC.DECELERATE},
			{time = 1000, y = 1080}
		}})
	end
end

local function adjustedCover(parts)
	if PROPERTY.islanecoverRotationSwitchOff() then
		table.insert(parts.slider, {id = "laneCoverLeftAdjusted", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , value = function() return CUSTOM.SLIDER.adjustedCover() end})
		table.insert(parts.slider, {id = "laneCoverRightAdjusted", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , value = function() return CUSTOM.SLIDER.adjustedCover() end})
	elseif PROPERTY.islanecoverRotationSwitchOn() then
		table.insert(parts.slider, {id = "laneCoverLeftAdjusted", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , value = function() return CUSTOM.SLIDER.adjustedCover() end})
		table.insert(parts.slider, {id = "laneCoverRightAdjusted", src = 18, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , value = function() return CUSTOM.SLIDER.adjustedCover() end})
	end
	table.insert(parts.slider, {id = "adjusted_min", src = "adjusted", x = 0, y = 0, w = 541, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , value = function() return CUSTOM.SLIDER.adjustedMinCover() end})
	table.insert(parts.slider, {id = "adjusted_max", src = "adjusted", x = 541, y = 0, w = 541, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH , value = function() return CUSTOM.SLIDER.adjustedMaxCover() end})
	for i = 1, 2, 1 do
		-- adjustedCover
		if CONFIG.play.valiableSUD.sw then
			table.insert(parts.destination,	{id = "laneCover"..side.wd[i] .."Adjusted", offset = MAIN.OFFSET.LIFT, loop = 1000, op = {MAIN.OP.CONSTANT, MAIN.OP.LANECOVER1_ON}, dst = {
				{time = 500, x = side.posx[i] + 3, y = 1080 + 853, w = 513, h = 853, acc = MAIN.ACC.DECELERATE, a = CONFIG.play.valiableSUD.alfa},
				{time = 1000, y = 1080}
			}})
		end
		table.insert(parts.destination,	{id = "adjusted_min", offset = MAIN.OFFSET.LIFT, loop = 1000, op = {MAIN.OP.CONSTANT, MAIN.OP.BPMCHANGE}, dst = {
			{time = 1000, x = side.posx[i] - 11, y = 1075, w = 541, h = 853}
		}})
		table.insert(parts.destination,	{id = "adjusted_max", offset = MAIN.OFFSET.LIFT, loop = 1000, op = {MAIN.OP.CONSTANT, MAIN.OP.BPMCHANGE}, dst = {
			{time = 1000, x = side.posx[i] - 11, y = 1075, w = 541, h = 853}
		}})
	end
end

-- 曲終了時にレーンカバーを下ろす
local function finishCover(parts)
	for i = 1, 2, 1 do
		if PROPERTY.isFinishCoverOn() then
			table.insert(parts.destination,	{
				id = "laneCover"..side.wd[i].."2", timer = MAIN.TIMER.ENDOFNOTE_1P, loop = 1000, dst = {
					{time = 0, x = side.posx[i] + 3, y = 1080, w = 513, h = 853},
					{time = 1000, y = 1080 - 853, acc = MAIN.ACC.DECELERATE}
				}
			})
		end
	end
end

local function number(parts)
	-- 緑数字
	table.insert(parts.value, {id = "greennumber", src = 1, x = 720, y = 1160, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_GREEN})
	table.insert(parts.value, {id = "greennumberLanecoverOn", src = 1, x = 720, y = 1160, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_GREEN_LANECOVER_ON})
	table.insert(parts.value, {id = "greennumberLanecoverOff", src = 1, x = 720, y = 1160, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_GREEN_LANECOVER_OFF})
	table.insert(parts.value, {id = "greennumberMainbpmLanecoverOn", src = 1, x = 720, y = 1160, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_GREEN_LANECOVER_ON})
	table.insert(parts.value, {id = "greennumberMainbpmLanecoverOff", src = 1, x = 720, y = 1160, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_GREEN_LANECOVER_OFF})
	-- 最低bpm時の緑数字
	table.insert(parts.value, {id = "greennumberMinbpmLanecoverOn", src = 1, x = 720, y = 1160, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM_DURATION_GREEN_LANECOVER_ON, align = 0})
	-- 最高bpm時の緑数字
	table.insert(parts.value, {id = "greennumberMaxbpmLanecoverOn", src = 1, x = 720, y = 1160, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM_DURATION_GREEN_LANECOVER_ON, align = 1})
	-- 白数字
	table.insert(parts.value, {id = "duration", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION})
	table.insert(parts.value, {id = "durationLanecoverOn", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_LANECOVER_ON})
	table.insert(parts.value, {id = "durationLanecoverOff", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_LANECOVER_OFF})
	table.insert(parts.value, {id = "durationMainbpmLanecoverOn", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_LANECOVER_ON})
	table.insert(parts.value, {id = "durationMainbpmLanecoverOff", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_LANECOVER_OFF})
	table.insert(parts.value, {id = "durationMinbpmLanecoverOn", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM_DURATION_LANECOVER_ON})
	table.insert(parts.value, {id = "durationMinbpmLanecoverOff", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM_DURATION_LANECOVER_OFF})
	table.insert(parts.value, {id = "durationMaxbpmLanecoverOn", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM_DURATION_LANECOVER_ON})
	table.insert(parts.value, {id = "durationMaxbpmLanecoverOff", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM_DURATION_LANECOVER_OFF})
	-- レーンカバー下げ量（白数字）
	table.insert(parts.value, {id = "lanecoverNumber", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.LANECOVER1})
	-- リフト数値
	table.insert(parts.value, {id = "liftNumber", src = 1, x = 720, y = 1040, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.LIFT1})
	for i = 1, 2, 1 do
		-- レーンカバー白数字
		table.insert(parts.destination,	{id = "lanecoverNumber", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {{x = side.posx[i] + 100, y = 1090, w = 24, h = 20}}})
		-- レーンカバー緑数字
		table.insert(parts.destination,	{id = "greennumber", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {{x = side.posx[i] + 270, y = 1090, w = 24, h = 20}}})
		-- レーンカバー緑数字最大・最小
		table.insert(parts.destination,	{id = "greennumberMinbpmLanecoverOn", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.BPMCHANGE}, dst = {{x = side.posx[i] + 225, y = 1120, w = 24, h = 20}}})
		table.insert(parts.destination,	{id = "from", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.BPMCHANGE}, dst = {{x = side.posx[i] + 335, y = 1117, w = 24, h = 20, r = 84,  g = 255, b = 0}}})
		table.insert(parts.destination,	{id = "greennumberMaxbpmLanecoverOn", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.BPMCHANGE}, dst = {{x = side.posx[i] + 355, y = 1120, w = 24, h = 20}}})
		-- リフト白数字
		table.insert(parts.destination,	{id = "liftNumber", offset = MAIN.OFFSET.LIFT, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {{x = side.posx[i] + 100, y = BASE.NOTES_JUDGE_Y - 30, w = 24, h = 20}}})
		-- リフト緑数字
		table.insert(parts.destination,	{id = "greennumber", offset = MAIN.OFFSET.LIFT, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {{x = side.posx[i] + 270, y = BASE.NOTES_JUDGE_Y - 30, w = 24, h = 20}}})
	end
end

local function liftDisplaySwitch(parts)
	table.insert(parts.image, {id = "liftDisplaySwitch", src = 1, x = 0, y = 900, w = 1, h = 1, act = function() changeLiftDisplay() end})
	-- リフト表示切替用
	table.insert(parts.destination, {
		id = "liftDisplaySwitch", dst = {
			{x = BASE.laneLeftPosX, y = BASE.NOTES_JUDGE_Y, w = 1164, h = 856}
		}
	})
end

local function exceptLanecover(parts)
	-- レーンカバーローテーション機能有効時は現在のレーンカバーを除外する処理
	if PROPERTY.islanecoverRotationSwitchOn() then
		local once = 1
		table.insert(parts.destination, {
			id = MAIN.IMAGE.BLACK, timer = function()
				if CUSTOM.OP.isTimerOn(MAIN.TIMER.ENDOFNOTE_1P) and once then
                    once = nil
					CUSTOM.FUNC.randomChoiceStep2("io/Play/dp/lanecover/")
				end
			end, dst = {{x = 1, y = 1, w = 1, h = 1, a = 0},}
		})
		table.insert(parts.value, {id = "usedLaneCoverCount", src = 1, x = 720, y = 1160, w = 264, h = 20, divx = 11, divy = 1, digit = 4, value = function() return CUSTOM.NUM.usedLaneCoverCountDP end})
		table.insert(parts.value, {id = "allLaneCoverCount", src = 1, x = 720, y = 1160, w = 264, h = 20, divx = 11, divy = 1, digit = 4, value = function() return CUSTOM.NUM.allLaneCoverCountDP end})
		table.insert(parts.destination,	{
			id = "laneCoverCount", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.laneRightPosX + 453, y = BASE.NOTES_JUDGE_Y + 30, w = 21, h = 18, r = 84,  g = 255, b = 0},
			}
		})
		table.insert(parts.destination, {
			id = "usedLaneCoverCount", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.laneRightPosX + 270, y = BASE.NOTES_JUDGE_Y + 5, w = 27, h = 20}
			}
		})
		table.insert(parts.destination,	{
			id = "slash", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.laneRightPosX + 390, y = BASE.NOTES_JUDGE_Y + 5, w = 21, h = 18, r = 84,  g = 255, b = 0},
			}
		})
		table.insert(parts.destination, {
			id = "allLaneCoverCount", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.laneRightPosX + 400, y = BASE.NOTES_JUDGE_Y + 5, w = 27, h = 20}
			}
		})
	end
end

local function load()
	local parts = {}
	parts.image = {}
	parts.slider = {}
	parts.liftCover = {}
	parts.hiddenCover = {}
	parts.value = {}
	parts.destination = {}
	cover(parts)
	adjustedCover(parts)
	finishCover(parts)
	number(parts)
	liftDisplaySwitch(parts)
	exceptLanecover(parts)
	return parts
end

return {
	load = load
}