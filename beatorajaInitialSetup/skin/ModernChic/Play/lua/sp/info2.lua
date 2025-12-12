--[[
	レベルと判定カウンター
	@author : KASAKO
--]]
local function load()
	local parts = {}
	
	parts.image = {
		-- レベル表示部分
		{id = "info_level_frame", src = 1, x = 1575, y = 300, w = 175, h = 91},
		-- カウント部分
		{id = "info_count_frame", src = 1, x = 1200, y = 300, w = 371, h = 103},
		
		-- 難易度画像
		{id = "lev_beginner", src = 1, x = 1200, y = 101, w = 160, h = 20},
		{id = "lev_normal", src = 1, x = 1200, y = 121, w = 160, h = 20},
		{id = "lev_hyper", src = 1, x = 1200, y = 141, w = 160, h = 20},
		{id = "lev_another", src = 1, x = 1200, y = 161, w = 160, h = 20},
		{id = "lev_insame", src = 1, x = 1200, y = 181, w = 160, h = 20},
		{id = "lev_unknown", src = 1, x = 1200, y = 201, w = 160, h = 20},
	}
	
	parts.value = {
		-- 譜面レベル
		{id = "playlevel", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 10, divy = 1, digit = 2, ref = MAIN.NUM.PLAYLEVEL},
		-- PG数
		{id = "count_pg", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.PERFECT},
		{id = "count_pg-early", src = 1, x = 1400, y = 121, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_PERFECT},
		{id = "count_pg-late", src = 1, x = 1400, y = 141, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_PERFECT},
		-- great数
		{id = "count_gr", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.GREAT},
		{id = "count_gr-early", src = 1, x = 1400, y = 121, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_GREAT},
		{id = "count_gr-late", src = 1, x = 1400, y = 141, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_GREAT},
		-- good数
		{id = "count_gd", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.GOOD},
		{id = "count_gd-early", src = 1, x = 1400, y = 121, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_GOOD},
		{id = "count_gd-late", src = 1, x = 1400, y = 141, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_GOOD},
		-- bad数
		{id = "count_bd", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.BAD},
		{id = "count_bd-early", src = 1, x = 1400, y = 121, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_BAD},
		{id = "count_bd-late", src = 1, x = 1400, y = 141, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_BAD},
		-- poor数
		{id = "count_pr", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.POOR},
		{id = "count_pr-early", src = 1, x = 1400, y = 121, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_POOR},
		{id = "count_pr-late", src = 1, x = 1400, y = 141, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_POOR},
	}

	parts.destination = {}

	-- フレーム部
	table.insert(parts.destination, {
		id = "info_level_frame", dst = {
			{x = BASE.gaugePositionX, y = 8, w = 175, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "info_count_frame", dst = {
			{x = BASE.gaugePositionX + 185, y = 4, w = 371, h = 103},
		}
	})
	do
		-- 判定カウンター
		local wd = {"pg", "gr", "gd", "bd", "pr"}
		local posY = 85
		for i = 1, #wd, 1 do
			table.insert(parts.destination, {
				id = "count_" ..wd[i], dst = {
					{x = BASE.gaugePositionX + 260, y = posY, w = 22, h = 20},
				}
			})
			table.insert(parts.destination, {
				id = "count_" ..wd[i] .."-early", dst = {
					{x = BASE.gaugePositionX + 360, y = posY, w = 22, h = 20},
				}
			})
			table.insert(parts.destination, {
				id = "count_" ..wd[i] .."-late", dst = {
					{x = BASE.gaugePositionX + 460, y = posY, w = 22, h = 20},
				}
			})
			posY = posY - 20
		end
	end
	do
		-- 難易度
		local wd = {"beginner", "normal", "hyper", "another", "insame", "unknown"}
		local op = {MAIN.OP.DIFFICULTY1, MAIN.OP.DIFFICULTY2, MAIN.OP.DIFFICULTY3, MAIN.OP.DIFFICULTY4, MAIN.OP.DIFFICULTY5, MAIN.OP.DIFFICULTY0}
		for i = 1, #wd, 1 do
			table.insert(parts.destination, {
				id = "lev_" ..wd[i], op = {op[i]}, dst = {
					{x = BASE.gaugePositionX + 10, y = 64, w = 160, h = 20}
				}
			})
		end
	end
	-- レベル数
	table.insert(parts.destination, {
		id = "playlevel", dst = {
			{x = BASE.gaugePositionX + 95, y = 27, w = 27, h = 20}
		}
	})
	
	return parts
end

return {
	load = load
}