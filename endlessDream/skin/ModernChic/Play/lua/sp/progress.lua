--[[
	進捗バー
	@author : KASAKO
--]]

local function load()
	local parts = {}
	
	parts.image = {
		{id = "progress_frame", src = 1, x = 1880, y = 0, w = 16, h = 807},
	}
	
	parts.slider = {
		{id = "progress", src = 10, x = 0, y = 0, w = 24, h = 37, angle = MAIN.S_ANGLE.DOWN, range = 773, type = MAIN.SLIDER.MUSIC_PROGRESS},
	}
	
	parts.destination = {
		-- フレーム部
		{id = "progress_frame", dst = {
			{x = BASE.progressbarPositionX, y = 247, w = 16, h = 807},
		}},
		-- スタート処理（下から上に）
		{id = "progress", loop = 1500, op = {MAIN.OP.NOW_LOADING, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{time = 0, x = BASE.progressbarPositionX - 4, y = 247, w = 24, h = 37, a = 0, acc = MAIN.ACC.DECELERATE},
			{time = 500},
			{time = 1500, y = 1020, a = 255}
		}},
		
		-- パーフェクト状態(ロード完了→スタート)
		{id = "progress",timer = MAIN.TIMER.READY, loop = -1, op = {MAIN.OP.LOADED, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{time = 0, x = BASE.progressbarPositionX - 4, y = 1020, w = 24, h = 37},
			{time = 1200}
		}},
		-- パーフェクト状態
		{id = "progress", op = {MAIN.OP.LOADED, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{x = BASE.progressbarPositionX - 4, y = 1020, w = 24, h = 37}
		}},
		-- フルコンボ状態
		{id = "progress", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.LOADED, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, MAIN.OP.GOOD_EXIST}, dst = {
			{time = 0, x = BASE.progressbarPositionX - 4, y = 1020, w = 24, h = 37},
			{time = 1000, a = 120}
		}},
		-- 通常
		{id = "progress", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.LOADED, MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST}, dst = {
			{time = 0, x = BASE.progressbarPositionX - 4, y = 1020, w = 24, h = 37},
			{time = 1000, a = 100}
		}},
		-- 通常
		{id = "progress", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.LOADED, MAIN.OP.BAD_EXIST}, dst = {
			{time = 0, x = BASE.progressbarPositionX - 4, y = 1020, w = 24, h = 37},
			{time = 1000, a = 100}
		}},
	}
	
	return parts
end

return {
	load = load
}