--[[
	進捗バー
	@author : KASAKO
--]]

local function load()
	local parts = {}
	
	parts.image = {
		{id = "progress_frame", src = 1, x = 10, y = 20, w = 16, h = 807},
	}
	
	parts.slider = {
		{id = "progress", src = 10, x = 0, y = 0, w = 24, h = 37, angle = MAIN.S_ANGLE.DOWN, range = 773, type = MAIN.SLIDER.MUSIC_PROGRESS},
		{id = "progress2", src = 10, x = 0, y = 0, w = 24, h = 37, angle = MAIN.S_ANGLE.RIGHT, range = 486, type = MAIN.SLIDER.MUSIC_PROGRESS},
	}
	
	parts.destination = {}

	-- 縦プログレスの配置
	local posx = {BASE.laneLeftPosX - 28, BASE.laneLeftPosX + 1176}
	for i = 1, 2, 1 do
		table.insert(parts.destination, {
			-- フレーム部
			id = "progress_frame", dst = {
				{x = posx[i], y = 247, w = 16, h = 807},
			}
		})
		table.insert(parts.destination, {
			-- スタート処理（下から上に）
			id = "progress", loop = 1500, op = {MAIN.OP.NOW_LOADING, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
				{time = 0, x = posx[i] - 4, y = 247, w = 24, h = 37, a = 0, acc = MAIN.ACC.DECELERATE},
				{time = 500},
				{time = 1500, y = 1020, a = 255}
			}
		})
		table.insert(parts.destination, {
			-- パーフェクト状態(ロード完了→スタート)
			id = "progress",timer = MAIN.TIMER.READY, loop = -1, op = {MAIN.OP.LOADED, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
				{time = 0, x = posx[i] - 4, y = 1020, w = 24, h = 37},
				{time = 1200}
			}
		})
		table.insert(parts.destination, {
			-- パーフェクト状態
			id = "progress", op = {MAIN.OP.LOADED, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
				{x = posx[i] - 4, y = 1020, w = 24, h = 37}
			}
		})
		table.insert(parts.destination, {
			-- フルコンボ状態
			-- timer:140 RHYHM（1000を一拍とする）
			id = "progress", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.LOADED, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, MAIN.OP.GOOD_EXIST}, dst = {
				{time = 0, x = posx[i] - 4, y = 1020, w = 24, h = 37},
				{time = 1000, a = 120}
			}
		})
		table.insert(parts.destination, {
			-- 通常
			id = "progress", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.LOADED, MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST}, dst = {
				{time = 0, x = posx[i] - 4, y = 1020, w = 24, h = 37},
				{time = 1000, a = 100}
			}
		})
		table.insert(parts.destination, {
			-- 通常
			id = "progress", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.LOADED, MAIN.OP.BAD_EXIST}, dst = {
				{time = 0, x = posx[i] - 4, y = 1020, w = 24, h = 37},
				{time = 1000, a = 100}
			}
		})
	end

	-- 横プログレス
	table.insert(parts.destination, {
		-- スタート処理（下から上に）
		id = "progress2", loop = 1500, op = {MAIN.OP.NOW_LOADING, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{time = 0, x = BASE.laneLeftPosX + 808, y = 148, w = 24, h = 37, a = 0, acc = MAIN.ACC.DECELERATE},
			{time = 500},
			{time = 1500, x = BASE.laneLeftPosX + 322, a = 255}
		}
	})
	table.insert(parts.destination, {
		-- パーフェクト状態(ロード完了→スタート)
		id = "progress2", timer = MAIN.TIMER.READY, loop = -1, op = {MAIN.OP.LOADED, -MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{time = 0, x = BASE.laneLeftPosX + 322, y = 148, w = 24, h = 37},
			{time = 1200}
		}
	})
	table.insert(parts.destination, {
		id = "progress2", timer = MAIN.TIMER.RHYTHM, dst = {
			{time = 0, x = BASE.laneLeftPosX + 322, y = 148, w = 24, h = 37},
			{time = 1000, a = 100}
		}
	})

	return parts
end

return {
	load = load
}