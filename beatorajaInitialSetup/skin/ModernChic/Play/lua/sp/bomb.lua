--[[
	爆発エフェクト
	@author : KASAKO
]]
local bombCycle = 251
local lnbombCycle = 160
-- 基本情報設定
local function init(keyNum)
	local info = {}
	info.init = {}
	info.bombTimer = {}
	info.lnBombTimer = {}
	info.modernchicLnPosY = {}
	info.oadxLnPosY = {}
	info.bombPosX = {}
	if keyNum == 5 then
		info.init = {"1", "2", "3", "4", "5", "s"}
		info.bombTimer = {MAIN.TIMER.BOMB_1P_KEY1, MAIN.TIMER.BOMB_1P_KEY2, MAIN.TIMER.BOMB_1P_KEY3, MAIN.TIMER.BOMB_1P_KEY4, MAIN.TIMER.BOMB_1P_KEY5, MAIN.TIMER.BOMB_1P_SCRATCH}
		info.lnBombTimer = {MAIN.TIMER.HOLD_1P_KEY1, MAIN.TIMER.HOLD_1P_KEY2, MAIN.TIMER.HOLD_1P_KEY3, MAIN.TIMER.HOLD_1P_KEY4, MAIN.TIMER.HOLD_1P_KEY5, MAIN.TIMER.HOLD_1P_SCRATCH}
		if PROPERTY.isJudgeTimingBombOff() then
			info.modernchicLnPosY = {900, 300, 600, 300, 600, 300}
			info.oadxLnPosY = {576, 192, 384, 192, 384, 192}
		elseif PROPERTY.isJudgeTimingBombOn() then
			info.modernchicLnPosY = {0, 0, 0, 0, 0, 0}
			info.oadxLnPosY = {0, 0, 0, 0, 0, 0}
		end
		if PROPERTY.isModernChicBomb() then
			info.bombWidth, info.bombHeight, info.adjustPosY = COMMONFUNC.offsetBombSize(400, 300, 0, PROPERTY.offsetBombSize.width())
			if PROPERTY.isLeftScratch() then
				info.bombPosX = {144, 201, 258, 315, 372, 57}
			elseif PROPERTY.isRightScratch() then
				info.bombPosX = {147, 204, 261, 318, 375, 462}
			end
		elseif PROPERTY.isOADXBomb() then
			info.bombWidth, info.bombHeight, info.adjustPosY = COMMONFUNC.offsetBombSize(376, 300, 18, PROPERTY.offsetBombSize.width())
			if PROPERTY.isLeftScratch() then
				info.bombPosX = {167, 222, 282, 337, 397, 80}
			elseif PROPERTY.isRightScratch() then
				info.bombPosX = {169, 225, 285, 340, 400, 484}
			end
		end
	elseif keyNum == 7 then
		info.init = {"1", "2", "3", "4", "5", "6", "7", "s"}
		info.bombTimer = {MAIN.TIMER.BOMB_1P_KEY1, MAIN.TIMER.BOMB_1P_KEY2, MAIN.TIMER.BOMB_1P_KEY3, MAIN.TIMER.BOMB_1P_KEY4, MAIN.TIMER.BOMB_1P_KEY5, MAIN.TIMER.BOMB_1P_KEY6, MAIN.TIMER.BOMB_1P_KEY7, MAIN.TIMER.BOMB_1P_SCRATCH}
		info.lnBombTimer = {MAIN.TIMER.HOLD_1P_KEY1, MAIN.TIMER.HOLD_1P_KEY2, MAIN.TIMER.HOLD_1P_KEY3, MAIN.TIMER.HOLD_1P_KEY4, MAIN.TIMER.HOLD_1P_KEY5, MAIN.TIMER.HOLD_1P_KEY6, MAIN.TIMER.HOLD_1P_KEY7, MAIN.TIMER.HOLD_1P_SCRATCH}
		if PROPERTY.isJudgeTimingBombOff () then
			info.modernchicLnPosY = {300, 600, 300, 600, 300, 600, 300, 900}
			info.oadxLnPosY = {192, 384, 192, 384, 192, 384, 192, 576}
		elseif PROPERTY.isJudgeTimingBombOn() then
			info.modernchicLnPosY = {0, 0, 0, 0, 0, 0, 0, 0}
			info.oadxLnPosY = {0, 0, 0, 0, 0, 0, 0, 0}
		end
		if PROPERTY.isModernChicBomb() then
			-- ボムの大きさ調整
			info.bombWidth, info.bombHeight, info.adjustPosY = COMMONFUNC.offsetBombSize(400, 300, 0, PROPERTY.offsetBombSize.width())
			-- ボム中心点
			if PROPERTY.isLeftScratch() then
				info.bombPosX = {144, 201, 258, 315, 372, 429, 486, 57}
			elseif PROPERTY.isRightScratch() then
				info.bombPosX = {33, 90, 147, 204, 261, 318, 375, 462}
			end
		elseif PROPERTY.isOADXBomb() then
			-- ボムの大きさ調整
			info.bombWidth, info.bombHeight, info.adjustPosY = COMMONFUNC.offsetBombSize(376, 300, 18, PROPERTY.offsetBombSize.width())
			-- ボム中心点
			if PROPERTY.isLeftScratch() then
				info.bombPosX = {167, 222, 282, 337, 397, 452, 512, 80}
			elseif PROPERTY.isRightScratch() then
				info.bombPosX = {55, 110, 169, 225, 285, 340, 400, 484}
			end
		end
	end
	return info
end
local function addImage(parts, info)
	if PROPERTY.isModernChicBomb() then
		-- ModernChic規格ボム・通常
		table.insert(parts.image, {id = "bomb", src = 11, x = 0, y = 0, w = -1, h = -1})
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "bomb-"..info.init[i], src = 11, x = 0, y = 0, w = 6400, h = 300, divx = 16, divy = 1, cycle = bombCycle, timer = info.bombTimer[i]})
		end
		-- ModernChic規格ボム・LN
		table.insert(parts.image, {id = "lnbomb", src = 11, x = 0, y = 0, w = -1, h = -1})
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "lnbomb-"..info.init[i], src = 11, x = 0, y = info.modernchicLnPosY[i], w = 3200, h = 300, divx = 8, divy = 1, cycle = lnbombCycle, timer = info.lnBombTimer[i]})
		end
		-- ModernChic規格ボム・SLOW
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "slowbomb-"..info.init[i], src = 11, x = 0, y = 300, w = 6400, h = 300, divx = 16, divy = 1, cycle = bombCycle, timer = info.bombTimer[i]})
		end
		-- ModernChic規格ボム・FAST
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "fastbomb-"..info.init[i], src = 11, x = 0, y = 600, w = 6400, h = 300, divx = 16, divy = 1, cycle = bombCycle, timer = info.bombTimer[i]})
		end
	elseif PROPERTY.isOADXBomb() then
		-- OADX規格ボム・通常
		table.insert(parts.image, {id = "bomb", src = 28, x = 0, y = 0, w = -1, h = -1})
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "bomb-"..info.init[i], src = 28, x = 0, y = 0, w = 2896, h = 192, divx = 16, divy = 1, cycle = bombCycle, timer = info.bombTimer[i]})
		end
		-- OADX規格ボム・LN
		table.insert(parts.image, {id = "lnbomb", src = 28, x = 0, y = 0, w = -1, h = -1})
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "lnbomb-"..info.init[i], src = 28, x = 0, y = info.oadxLnPosY[i], w = 1448, h = 192, divx = 8, divy = 1, cycle = lnbombCycle, timer = info.lnBombTimer[i]})
		end
		-- OADX規格ボム・SLOW
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "slowbomb-"..info.init[i], src = 28, x = 0, y = 192, w = 2896, h = 192, divx = 16, divy = 1, cycle = bombCycle, timer = info.bombTimer[i]})
		end
		-- OADX規格ボム・FAST
		for i = 1, #info.init, 1 do
			table.insert(parts.image, {id = "fastbomb-"..info.init[i], src = 28, x = 0, y = 384, w = 2896, h = 192, divx = 16, divy = 1, cycle = bombCycle, timer = info.bombTimer[i]})
		end
	end
	-- HCN
	for i = 1, #info.init, 1 do
		table.insert(parts.image, {id = "hcnbomb-"..info.init[i], src = "hcnBomb", x = 0, y = 0, w = 1600, h = 1200, divx = 4, divy = 4, cycle = lnbombCycle * 4, timer = info.lnBombTimer[i]})
	end
end

local function addDestination(parts, info)
	-- ボム先読み
	table.insert(parts.destination,{id = "bomb", dst = {{x = 0, y = 0, w = 1, h = 1}}})
	table.insert(parts.destination,{id = "lnbomb", dst = {{x = 0, y = 0, w = 1, h = 1}}})
	-- 爆発エフェクト
	if PROPERTY.isJudgeTimingBombOff() then
		for i = 1, #info.init, 1 do
			table.insert(parts.destination, {
				id = "bomb-"..info.init[i], offset = MAIN.OFFSET.LIFT, loop = -1, filter = MAIN.FILTER.OFF, timer = info.bombTimer[i], blend = MAIN.BLEND.ADDITION, dst = {
					{time = 0, x = BASE.playsidePositionX + info.bombPosX[i] - info.bombWidth / 2, y = BASE.NOTES_JUDGE_Y - info.adjustPosY - (info.bombHeight / 2), w = info.bombWidth, h = info.bombHeight},
					{time = bombCycle - 1}
				}
			})
		end
	elseif PROPERTY.isJudgeTimingBombOn() then
		-- 通常ボム
		for i = 1, #info.init, 1 do
			table.insert(parts.destination, {
				id = "bomb-"..info.init[i], offset = MAIN.OFFSET.LIFT, loop = -1, filter = MAIN.FILTER.OFF, timer = info.bombTimer[i], blend = MAIN.BLEND.ADDITION, op = {-MAIN.OP.EARLY_1P, -MAIN.OP.LATE_1P}, dst = {
					{time = 0, x = BASE.playsidePositionX + info.bombPosX[i] - info.bombWidth / 2, y = BASE.NOTES_JUDGE_Y - info.adjustPosY - (info.bombHeight / 2), w = info.bombWidth, h = info.bombHeight},
					{time = bombCycle - 1}
				}
			})
		end
		-- fastボム
		for i = 1, #info.init, 1 do
			table.insert(parts.destination, {
				id = "fastbomb-"..info.init[i], offset = MAIN.OFFSET.LIFT, loop = -1, filter = MAIN.FILTER.OFF, timer = info.bombTimer[i], blend = MAIN.BLEND.ADDITION, op = {MAIN.OP.EARLY_1P}, dst = {
					{time = 0, x = BASE.playsidePositionX + info.bombPosX[i] - info.bombWidth / 2, y = BASE.NOTES_JUDGE_Y - info.adjustPosY - (info.bombHeight / 2), w = info.bombWidth, h = info.bombHeight},
					{time = bombCycle - 1}
				}
			})
		end
		-- slowボム
		for i = 1, #info.init, 1 do
			table.insert(parts.destination, {
				id = "slowbomb-"..info.init[i], offset = MAIN.OFFSET.LIFT, loop = -1, filter = MAIN.FILTER.OFF, timer = info.bombTimer[i], blend = MAIN.BLEND.ADDITION, op = {MAIN.OP.LATE_1P}, dst = {
					{time = 0, x = BASE.playsidePositionX + info.bombPosX[i] - info.bombWidth / 2, y = BASE.NOTES_JUDGE_Y - info.adjustPosY - (info.bombHeight / 2), w = info.bombWidth, h = info.bombHeight},
					{time = bombCycle - 1}
				}
			})
		end
	end
	if CONFIG.play.hcnBomb and PROPERTY.isModernChicBomb() then
		-- LN爆発エフェクトの配置
		for i = 1, #info.init, 1 do
			table.insert(parts.destination,	{
				id = "lnbomb-"..info.init[i], offset = MAIN.OFFSET.LIFT, filter = MAIN.FILTER.OFF, timer = info.lnBombTimer[i], blend = MAIN.BLEND.ADDITION, draw = function() return not CUSTOM.OP.isHcnPattern() end, dst = {
					{time = 0, x = BASE.playsidePositionX + info.bombPosX[i] - info.bombWidth / 2, y = BASE.NOTES_JUDGE_Y - info.adjustPosY - (info.bombHeight / 2), w = info.bombWidth, h = info.bombHeight},
					{time = lnbombCycle - 1}
				}
			})
		end
		-- HCNボム（テスト）
		for i = 1, #info.init, 1 do
			table.insert(parts.destination,	{
				id = "hcnbomb-"..info.init[i], offset = MAIN.OFFSET.LIFT, filter = MAIN.FILTER.OFF, timer = info.lnBombTimer[i], blend = MAIN.BLEND.ADDITION, draw = function() return CUSTOM.OP.isHcnPattern() end, dst = {
					{time = 0, x = BASE.playsidePositionX + info.bombPosX[i] - info.bombWidth / 2, y = BASE.NOTES_JUDGE_Y - info.adjustPosY - (info.bombHeight / 2) + 10, w = info.bombWidth, h = info.bombHeight},
					{time = lnbombCycle * 4 - 1}
				}
			})
		end
	else
		-- LN爆発エフェクトの配置
		for i = 1, #info.init, 1 do
			table.insert(parts.destination,	{
				id = "lnbomb-"..info.init[i], offset = MAIN.OFFSET.LIFT, filter = MAIN.FILTER.OFF, timer = info.lnBombTimer[i], blend = MAIN.BLEND.ADDITION, dst = {
					{time = 0, x = BASE.playsidePositionX + info.bombPosX[i] - info.bombWidth / 2, y = BASE.NOTES_JUDGE_Y - info.adjustPosY - (info.bombHeight / 2), w = info.bombWidth, h = info.bombHeight},
					{time = lnbombCycle - 1}
				}
			})
		end
	end
end

local function load(keyNum)
	local parts = {}
	parts.image = {}
	parts.destination = {}
	local info = init(keyNum)
	addImage(parts, info)
	addDestination(parts, info)
	return parts
end

return {
	load = load
}