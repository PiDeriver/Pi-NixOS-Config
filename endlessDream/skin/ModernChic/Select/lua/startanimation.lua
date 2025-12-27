--[[
	開始アニメーション
	@author : KASAKO
--]]

local function background(parts)
	table.insert(parts.image, {id = "shutter-l", src = 5, x = 0, y = 0, w = 1004, h = 1080})
	table.insert(parts.image, {id = "shutter-r", src = 5, x = 1020, y = 0, w = 1003, h = 1080})
	table.insert(parts.image, {id = "fade-bg", src = 5, x = 2200, y = 0, w = 1, h = 1})
	table.insert(parts.image, {id = "fade-tex", src = 5, x = 0, y = 2900, w = 1250, h = 50})

	-- 背景に静止画を選択している場合はアニメーション
	if PROPERTY.isBgImage() then
		table.insert(parts.destination, {
			id = "background", loop = -1, dst = {
				{time = 1000, x = -960, y = -540, w = 3840, h = 2160, a = 100},
				{time = 1250, x = 0, y = 0, w = 1920, h = 1080, a = 0}
			}
		})
		table.insert(parts.destination, {
			id = "background", loop = -1, dst = {
				{time = 1000, x = -960, y = -540, w = 3840, h = 2160, a = 100},
				{time = 1500, x = 0, y = 0, w = 1920, h = 1080, a = 0}
			}
		})
		table.insert(parts.destination, {
			id = "background", loop = -1, dst = {
				{time = 1000, x = -9600, y = -5400, w = 21120, h = 11880, a = 100},
				{time = 2000, x = 0, y = 0, w = 1920, h = 1080, a = 0}
			}
		})
	end
	-- 開始パターン（フェードイン）
	if PROPERTY.isStartFadein() then
		table.insert(parts.destination, {
			id = "fade-bg", loop = -1, dst = {
				{time = 0, x = 0, y = 0, w = 1920, h = 1080},
				{time = 800},
				{time = 1000, y = 540 , h = 0}
			}
		})
		table.insert(parts.destination, {
			id = "fade-tex", loop = -1, dst = {
				{time = 0, x = 325, y = 513, w = 1250, h = 50, a = 0},
				{time = 300, a = 255},
				{time = 800}
			}
		})
	end
	-- 開始パターン（シャッター）
	if PROPERTY.isStartShutter() then
		table.insert(parts.destination, {
			id = "shutter-l", loop = -1, dst = {
				{time = 0, x = 0, y = 0, w = 1004, h = 1080, acc = MAIN.ACC.DECELERATE},
				{time = 800},
				{time = 1000, x = -1004}
			}
		})
		table.insert(parts.destination, {
			id = "shutter-r", loop = -1, dst = {
				{time = 0, x = 915, y = 0, w = 1003, h = 1080, acc = MAIN.ACC.DECELERATE},
				{time = 800},
				{time = 1000, x = 1919}
			}
		})
	end
end

local function playCounter(parts)
	table.insert(parts.image, {
        id = "todayPlayCountFrame2", src = 5, x = 0, y = 3012, w = 250, h = 31
    })
    table.insert(parts.value, {
        id = "todayPlayCount2", src = 5, x = 0, y = 3050, w = 520 + 52, h = 31, divx = 11, digit = 3, value = function()
            return CUSTOM.NUM.todaySongUpdateCount + 1
        end
    })
	-- 本日のプレイ数
	if PROPERTY.isviewHistoryOn() then
		local baseX = 750
		local baseY = 420
		table.insert(parts.destination, {
			id = "todayPlayCountFrame2", loop = -1, dst = {
				{time = 0, x = baseX, y = baseY, w = 250, h = 31, a = 0},
				{time = 300, a = 255},
				{time = 800}
			}
		})
		table.insert(parts.destination, {
			id = "todayPlayCount2", loop = -1, dst = {
				{time = 0, x = baseX + 250 + 30, y = baseY, w = 52, h = 31, a = 0},
				{time = 300, a = 255},
				{time = 800}
			}
		})
	end
end

local function load()
	local parts = {}
	parts.image = {}
	parts.value = {}
	parts.destination = {}
	background(parts)
	playCounter(parts)
	return parts
end

return {
	load = load
}