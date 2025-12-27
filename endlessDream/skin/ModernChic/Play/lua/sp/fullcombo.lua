--[[
	フルコンボ演出
	@author : KASAKO
--]]
local function load()
	local parts = {}
	
	parts.image = {
		-- フルコン
		{id = "fc", src = 13, x = 0, y = 0, w = 5190, h = 2571, divx = 10, divy = 3, cycle = 1500, timer = MAIN.TIMER.FULLCOMBO_1P},
		-- FULL
		{id = "wd_full", src = 1, x = 1200, y = 1050, w = 400, h = 90},
		-- COMBO
		{id = "wd_combo", src = 1, x = 1200, y = 1140, w = 400, h = 90},
	}
	
	parts.destination = {
		-- フルコン演出
		{id = "fc", loop = -1, timer = MAIN.TIMER.FULLCOMBO_1P, blend = MAIN.BLEND.ADDITION, dst = {
			{time = 0,x = BASE.playsidePositionX, y = BASE.NOTES_JUDGE_Y, w = 519, h = 857},
			{time = 1000},
			{time = 1500, a = 0}
		}},
		{id = "wd_full", offset = MAIN.OFFSET.LIFT, loop = -1, timer = MAIN.TIMER.FULLCOMBO_1P, dst = {
			{time = 500,x = BASE.playsidePositionX + 519, y = BASE.NOTES_JUDGE_Y + 230, w = 400, h = 90, a = 0},
			{time = 600, x = BASE.playsidePositionX + 100, a = 255},
			{time = 1900, x = BASE.playsidePositionX},
			{time = 2000, x = BASE.playsidePositionX - 519, a = 0}
		}},
		{id = "wd_combo", offset = MAIN.OFFSET.LIFT, loop = -1, timer = MAIN.TIMER.FULLCOMBO_1P, dst = {
			{time = 500,x = BASE.playsidePositionX - 519, y = BASE.NOTES_JUDGE_Y + 150, w = 400, h = 90, a = 0},
			{time = 600, x = BASE.playsidePositionX, a = 255},
			{time = 1900, x = BASE.playsidePositionX + 100},
			{time = 2000, x = BASE.playsidePositionX + 519, a = 0}
		}},
	}
	
	return parts
end

return {
	load = load
}