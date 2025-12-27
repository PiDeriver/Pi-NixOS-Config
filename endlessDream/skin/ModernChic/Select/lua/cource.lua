--[[
	コース・段位認定・制限表示
	@author : KASAKO
--]]

local function load()
	local parts = {}
	
	parts.image = {
		-- コース情報
		{id = "course-frame", src = 5, x = 1500, y = 1470, w = 1005, h = 345},
		{id = "course-op-random", src = 5, x = 1519, y = 1816, w = 192, h = 28},
		{id = "course-op-mirror", src = 5, x = 1519, y = 1845, w = 192, h = 28},
		{id = "course-op-nospeed", src = 5, x = 1713, y = 1816, w = 192, h = 28},
		{id = "course-op-nogood", src = 5, x = 1907, y = 1816, w = 192, h = 28},
		{id = "course-op-nogreat", src = 5, x = 1907, y = 1845, w = 192, h = 28},
		{id = "course-gauge-lr2", src = 5, x = 2101, y = 1816, w = 192, h = 28},
		{id = "course-gauge-5", src = 5, x = 2101, y = 1845, w = 192, h = 28},
		{id = "course-gauge-7", src = 5, x = 2101, y = 1874, w = 192, h = 28},
		{id = "course-gauge-9", src = 5, x = 2101, y = 1903, w = 192, h = 28},
		{id = "course-gauge-24", src = 5, x = 2101, y = 1932, w = 192, h = 28},
		{id = "course-op-ln", src = 5, x = 2295, y = 1816, w = 192, h = 28},
		{id = "course-op-cn", src = 5, x = 2295, y = 1845, w = 192, h = 28},
		{id = "course-op-hcn", src = 5, x = 2295, y = 1874, w = 192, h = 28},
		{id = "course-1-5", src = 5, x = 3000, y = 1400, w = 87, h = 258},
		{id = "course-6-10", src = 5, x = 3087, y = 1400, w = 87, h = 258},
		{id = "course-indicator", src = 9, x = 980, y = 80, w = 57, h = 57, timer = MAIN.TIMER.SONGBAR_CHANGE, divy = 3, cycle = 3000},
	}

	local posX = 30

	parts.destination = {}

	table.insert(parts.destination, {
		id = "course-frame", op = {MAIN.OP.GRADEBAR}, dst = {
			{x = posX, y = 410, w = 1005, h = 345}
		}
	})
	do
		-- 使用可能オプション
		local wd = {"random", "mirror"}
		local op = {MAIN.OP.GRADEBAR_RANDOM, MAIN.OP.GRADEBAR_MIRROR}
		for i = 1, 2, 1 do
			table.insert(parts.destination, {
				id = "course-op-" ..wd[i], op = {MAIN.OP.GRADEBAR, op[i]}, dst = {
					{x = posX + 19, y = 417, w = 192, h = 28}
				}
			})
		end
	end
	-- ハイスピ制限
	table.insert(parts.destination, {
		id = "course-op-nospeed", op = {MAIN.OP.GRADEBAR, MAIN.OP.GRADEBAR_NOSPEED}, dst = {
			{x = posX + 213, y = 417, w = 192, h = 28}
		}
	})
	do
		-- 判定制限
		local wd = {"nogood", "nogreat"}
		local op = {1006, 1007}
		for i = 1, 2, 1 do
			table.insert(parts.destination, {
				id = "course-op-" ..wd[i], op = {MAIN.OP.GRADEBAR, op[i]}, dst = {
					{x = posX + 407, y = 417, w = 192, h = 28}
				}
			})
		end
	end
	do
		-- ゲージの種類
		local wd = {"lr2", "5", "7", "9", "24"}
		local op = {MAIN.OP.GRADEBAR_GAUGE_LR2, MAIN.OP.GRADEBAR_GAUGE_5KEYS, MAIN.OP.GRADEBAR_GAUGE_7KEYS, MAIN.OP.GRADEBAR_GAUGE_9KEYS, MAIN.OP.GRADEBAR_GAUGE_24KEYS}
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "course-gauge-" ..wd[i], op = {MAIN.OP.GRADEBAR, op[i]}, dst = {
					{x = posX + 601, y = 417, w = 192, h = 28}
				}
			})
		end
	end
	do
		-- ln,cn,hcn
		local wd = {"ln", "cn", "hcn"}
		local op = {MAIN.OP.GRADEBAR_LN, MAIN.OP.GRADEBAR_CN, MAIN.OP.GRADEBAR_HCN}
		for i = 1, 3, 1 do
			table.insert(parts.destination, {
				id = "course-op-" ..wd[i], op = {MAIN.OP.GRADEBAR, op[i]}, dst = {
					{x = posX + 795, y = 417, w = 192, h = 28}
				}
			})
		end
	end
	do
		local posY = {685, 633, 581, 529, 477}
		-- 5曲以内の場合
		table.insert(parts.destination, {
			id = "course-1-5", draw = function()
				return CUSTOM.OP.isCounseWithin5()
			end, dst = {
				{x = posX + 38, y = 470, w = 87, h = 258}
			}
		})
		-- 曲名(1-5)
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "course" ..i, draw = function()
					return CUSTOM.OP.isCounseWithin5()
				end, dst = {
					{x = posX + 554, y = posY[i], w = 850, h = 30}
				}
			})
		end
		-- 6曲以上ある場合
		table.insert(parts.destination, {
			id = "course-1-5", timer = MAIN.TIMER.SONGBAR_CHANGE, draw = function()
				return CUSTOM.OP.isCounseOver6()
			end, dst = {
				{time = 0, x = posX + 38, y = 470, w = 87, h = 258},
				{time = 2999},
				{time = 3000, a = 0},
				{time = 6000}
			}
		})
		table.insert(parts.destination, {
			id = "course-6-10", timer = MAIN.TIMER.SONGBAR_CHANGE, draw = function()
				return CUSTOM.OP.isCounseOver6()
			end, dst = {
				{time = 0, x = posX + 38, y = 470, w = 87, h = 258, a = 0},
				{time = 2999},
				{time = 3000, a = 255},
				{time = 6000}
			}
		})
		-- 曲名(1-5)
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "course" ..i, timer = MAIN.TIMER.SONGBAR_CHANGE, draw = function()
					return CUSTOM.OP.isCounseOver6()
				end, dst = {
					{time = 0, x = posX + 554, y = posY[i], w = 850, h = 30, b = 230},
					{time = 2999},
					{time = 3000, a = 0},
					{time = 6000}
				}
			})
		end
		-- 曲名(6-10)
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "course" ..5 + i, timer = MAIN.TIMER.SONGBAR_CHANGE, draw = function()
					return CUSTOM.OP.isCounseOver6()
				end, dst = {
					{time = 0, x = posX + 554, y = posY[i], w = 850, h = 30, a = 0},
					{time = 2999},
					{time = 3000, a = 255},
					{time = 6000}
				}
			})
		end
		-- コースインジケータ
		table.insert(parts.destination, {
			id = "course-indicator", timer = MAIN.TIMER.SONGBAR_CHANGE, draw = function()
				return CUSTOM.OP.isCounseOver6()
			end, dst = {
				{time = 0, x = posX + 920, y = 731, w = 57, h = 19},
			}
		})
	end
	
	return parts
end

return {
	load = load
}