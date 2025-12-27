--[[
	レーンカバー、リフト、hiddenカバー
	@author : KASAKO
]]
local isLiftDisplay = CONFIG.play.liftDisplay

local function cover(parts)
	-- hiddenは黒のドットで
	-- disapearline : hidden開始地点(判定位置)
	table.insert(parts.hiddenCover, {id = "hidden_cover", src = 1, x = 0, y = 0, w = 1, h = 1, disapearLine = 227})
	-- disapearline : lift開始地点(判定位置)
	table.insert(parts.liftCover, {id = "lift_cover", src = 18, x = 0, y = 0, w = 513, h = 853, disapearLine = 227})
	-- レーンカバー
	table.insert(parts.slider, {id = "lane_cover", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH, type = MAIN.SLIDER.LANECOVER})
	-- hidden y : disapearLine（lift開始点）- h
	table.insert(parts.destination, {id = "hidden_cover", dst = {{x = BASE.playsidePositionX + 3, y = -626, w = 513, h = 853}}})
	-- リフト y : disapearLine（lift開始点）- h
	table.insert(parts.destination, {id = "lift_cover", draw = function() return isLiftDisplay end, dst = {{x = BASE.playsidePositionX + 3, y = -626, w = 513, h = 853}}})
	-- レーンカバー(サドプラ自動調節OFF時は常時表示)
	table.insert(parts.destination,	{id = "lane_cover", op = {-MAIN.OP.CONSTANT}, loop = 1000, dst = {
		{time = 500, x = BASE.playsidePositionX + 3, y = 1080 + 853, w = 513, h = 853, acc = MAIN.ACC.DECELERATE},
		{time = 1000, y = 1080}
	}})
end

-- レーンカバー自動調節
local function adjustedCover(parts)
	if CONFIG.play.valiableSUD.sw then
		table.insert(parts.slider, {id = "adjusted_cover", src = 17, x = 0, y = 0, w = 513, h = 853, angle = MAIN.S_ANGLE.DOWN, range = 853, value = function() return CUSTOM.SLIDER.adjustedCover() end})
		table.insert(parts.destination,	{id = "adjusted_cover", loop = 1000, offset = MAIN.OFFSET.LIFT, op = {MAIN.OP.CONSTANT, MAIN.OP.LANECOVER1_ON}, dst = {
			{time = 500, x = BASE.playsidePositionX + 3, y = 1080 + 853, w = 513, h = 853, acc = MAIN.ACC.DECELERATE, a = CONFIG.play.valiableSUD.alfa},
			{time = 1000, y = 1080}
		}})
	end
	table.insert(parts.slider, {id = "adjusted_min", src = "adjusted", x = 0, y = 0, w = 541, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH, value = function() return CUSTOM.SLIDER.adjustedMinCover() end})
	table.insert(parts.destination,	{id = "adjusted_min", offset = MAIN.OFFSET.LIFT, loop = 1000, op = {MAIN.OP.CONSTANT, MAIN.OP.BPMCHANGE}, dst = {
		{time = 1000, x = BASE.playsidePositionX - 11, y = 1075, w = 541, h = 853}
	}})
	table.insert(parts.slider, {id = "adjusted_max", src = "adjusted", x = 541, y = 0, w = 541, h = 853, angle = MAIN.S_ANGLE.DOWN, range = BASE.LANE_LENGTH, value = function() return CUSTOM.SLIDER.adjustedMaxCover() end})
	table.insert(parts.destination,	{id = "adjusted_max", offset = MAIN.OFFSET.LIFT, loop = 1000, op = {MAIN.OP.CONSTANT, MAIN.OP.BPMCHANGE}, dst = {
		{time = 1000, x = BASE.playsidePositionX - 11, y = 1075, w = 541, h = 853}
	}})
end

-- 曲終了時にレーンカバーを下ろす
local function finishCover(parts)
	table.insert(parts.image, {id = "lane_cover2", src = 17, x = 0, y = 0, w = 513, h = 853})
	if PROPERTY.isFinishCoverOn() then
		table.insert(parts.destination,	{
			id = "lane_cover2", timer = MAIN.TIMER.ENDOFNOTE_1P ,loop = 1000, dst = {
				{time = 0, x = BASE.playsidePositionX + 3, y = 1080, w = 513, h = 853},
				{time = 1000, y = 1080 - 853, acc = MAIN.ACC.DECELERATE}
			}
		})
	end
end

local function number(parts)
	-- 緑数字
	table.insert(parts.value,{id = "greennumber", src = 1, x = 1400, y = 161, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_GREEN})
	table.insert(parts.value,{id = "greennumberLanecoverOn", src = 1, x = 1400, y = 161, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_GREEN_LANECOVER_ON})
	table.insert(parts.value,{id = "greennumberLanecoverOff", src = 1, x = 1400, y = 161, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_GREEN_LANECOVER_OFF})
	table.insert(parts.value,{id = "greennumberMainbpmLanecoverOn", src = 1, x = 1400, y = 161, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_GREEN_LANECOVER_ON})
	table.insert(parts.value,{id = "greennumberMainbpmLanecoverOff", src = 1, x = 1400, y = 161, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_GREEN_LANECOVER_OFF})
	-- 最低bpm時の緑数字
	table.insert(parts.value,{id = "greennumberMinbpmLanecoverOn", src = 1, x = 1400, y = 161, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM_DURATION_GREEN_LANECOVER_ON, align = MAIN.N_ALIGN.RIGHT})
	-- 最高bpm時の緑数字
	table.insert(parts.value,{id = "greennumberMaxbpmLanecoverOn", src = 1, x = 1400, y = 161, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM_DURATION_GREEN_LANECOVER_ON, align = MAIN.N_ALIGN.LEFT})
	-- 白数字
	table.insert(parts.value,{id = "duration", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION})
	table.insert(parts.value,{id = "durationLanecoverOn", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_LANECOVER_ON})
	table.insert(parts.value,{id = "durationLanecoverOff", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.DURATION_LANECOVER_OFF})
	table.insert(parts.value,{id = "durationMainbpmLanecoverOn", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_LANECOVER_ON})
	table.insert(parts.value,{id = "durationMainbpmLanecoverOff", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAINBPM_DURATION_LANECOVER_OFF})
	table.insert(parts.value,{id = "durationMinbpmLanecoverOn", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM_DURATION_LANECOVER_ON})
	table.insert(parts.value,{id = "durationMinbpmLanecoverOff", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM_DURATION_LANECOVER_OFF})
	table.insert(parts.value,{id = "durationMaxbpmLanecoverOn", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM_DURATION_LANECOVER_ON})
	table.insert(parts.value,{id = "durationMaxbpmLanecoverOff", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM_DURATION_LANECOVER_OFF})
	-- レーンカバー下げ量（白数字）
	table.insert(parts.value,{id = "lanecoverNumber", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.LANECOVER1})
	-- リフト数値
	table.insert(parts.value,{id = "liftNumber", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.LIFT1})

	-- レーンカバー白数字
	table.insert(parts.destination,	{
		id = "lanecoverNumber", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {
			{x = BASE.playsidePositionX + 90, y = 1090, w = 27, h = 20}
		}
	})
	-- レーンカバー緑数字
	table.insert(parts.destination,	{
		id = "greennumber", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {
			{x = BASE.playsidePositionX + 260, y = 1090, w = 27, h = 20},
		}
	})
	-- レーンカバー緑数字最大・最小
	table.insert(parts.destination,	{
		id = "greennumberMinbpmLanecoverOn", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.BPMCHANGE}, dst = {
			{x = BASE.playsidePositionX + 220, y = 1120, w = 21, h = 18},
		}
	})
	table.insert(parts.destination,	{
		id = "from", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.BPMCHANGE}, dst = {
			{x = BASE.playsidePositionX + 320, y = 1117, w = 21, h = 18, r = 84,  g = 255, b = 0},
		}
	})
	table.insert(parts.destination,	{
		id = "greennumberMaxbpmLanecoverOn", offset = MAIN.OFFSET.LANECOVER, op = {MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.BPMCHANGE}, dst = {
			{x = BASE.playsidePositionX + 340, y = 1120, w = 21, h = 18},
		}
	})
	if PROPERTY.isDetailInfoSwitchOff() then
		-- リフト白数字
		table.insert(parts.destination,	{
			id = "liftNumber", offset = MAIN.OFFSET.LIFT, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {
				{x = BASE.playsidePositionX + 90, y = BASE.NOTES_JUDGE_Y - 30, w = 27, h = 20},
			}
		})
		-- リフト緑数字
		table.insert(parts.destination,	{
			id = "greennumber", offset = MAIN.OFFSET.LIFT, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {
				{x = BASE.playsidePositionX + 260, y = BASE.NOTES_JUDGE_Y - 30, w = 27, h = 20},
			}
		})
	elseif PROPERTY.isDetailInfoSwitchOn() then
		-- リフト白数字
		table.insert(parts.destination,	{
			id = "liftNumber", offset = MAIN.OFFSET.LIFT, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {
				{x = BASE.playsidePositionX + 90, y = BASE.NOTES_JUDGE_Y + 30, w = 27, h = 20},
			}
		})
		-- リフト緑数字
		table.insert(parts.destination,	{
			id = "greennumber", offset = MAIN.OFFSET.LIFT, op = {MAIN.OP.LANECOVER1_CHANGING}, dst = {
				{x = BASE.playsidePositionX + 260, y = BASE.NOTES_JUDGE_Y + 30, w = 27, h = 20},
			}
		})
	end
end

-- リフト画像切替
local function changeLiftDisplay()
	isLiftDisplay = not isLiftDisplay
	return isLiftDisplay
end
local function liftDisplaySwitch(parts)
	-- リフト表示切替用
	table.insert(parts.image, {id = "liftDisplaySwitch", src = 1, x = 2, y = 0, w = 1, h = 1, act = function() changeLiftDisplay() end})
	table.insert(parts.destination, {
		id = "liftDisplaySwitch", dst = {
			{x = BASE.playsidePositionX, y = BASE.NOTES_JUDGE_Y - 3, w = 519, h = 857}
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
					CUSTOM.FUNC.randomChoiceStep2("io/Play/sp/lanecover/")
				end
			end, dst = {{x = 1, y = 1, w = 1, h = 1, a = 0},}
		})
		table.insert(parts.value, {id = "usedLaneCoverCount", src = 1, x = 1400, y = 161, w = 297, h = 20, divx = 11, divy = 1, digit = 4, value = function() return CUSTOM.NUM.usedLaneCoverCountSP end})
		table.insert(parts.value, {id = "allLaneCoverCount", src = 1, x = 1400, y = 161, w = 297, h = 20, divx = 11, divy = 1, digit = 4, value = function() return CUSTOM.NUM.allLaneCoverCountSP end})
		table.insert(parts.destination,	{
			id = "laneCoverCount", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.playsidePositionX + 453, y = BASE.NOTES_JUDGE_Y + 30, w = 21, h = 18, r = 84,  g = 255, b = 0},
			}
		})
		table.insert(parts.destination, {
			id = "usedLaneCoverCount", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.playsidePositionX + 270, y = BASE.NOTES_JUDGE_Y + 5, w = 27, h = 20}
			}
		})
		table.insert(parts.destination,	{
			id = "slash", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.playsidePositionX + 390, y = BASE.NOTES_JUDGE_Y + 5, w = 21, h = 18, r = 84,  g = 255, b = 0},
			}
		})
		table.insert(parts.destination, {
			id = "allLaneCoverCount", timer = MAIN.TIMER.ENDOFNOTE_1P, dst = {
				{x = BASE.playsidePositionX + 400, y = BASE.NOTES_JUDGE_Y + 5, w = 27, h = 20}
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