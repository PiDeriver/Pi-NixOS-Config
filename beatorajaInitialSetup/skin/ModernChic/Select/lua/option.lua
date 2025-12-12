--[[
	オプションメニュー表示用
	@author : KASAKO
--]]
local openTime = 100

local function menuOpen()
	return {MAIN.OP.PANEL1}
end

local function background(parts)
	table.insert(parts.image, {id = "op-top", src = 6, x = 0, y = 0, w = 1920, h = 565})
	table.insert(parts.image, {id = "op-bottom", src = 6, x = 0, y = 570, w = 1920, h = 565})
	table.insert(parts.image, {id = "op-dia", src = 6, x = 0, y = 1150, w = 1950, h = 50})
	table.insert(parts.image, {id = "op-title", src = 6, x = 0, y = 1210, w = 853, h = 50})
	table.insert(parts.image, {id = "op-menu", src = 6, x = 0, y = 2050, w = 1273, h = 680})
	table.insert(parts.image, {id = "op-info", src = 6, x = 900, y = 1730, w = 1001, h = 91})
	-- ウィンドウ開く
	table.insert(parts.destination, {
		id = "op-top", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = 0, x = 0, y = 1080, w = 1920, h = 565},
			{time = openTime, y = 515, acc = MAIN.ACC.DECELERATE}
		}
	})
	table.insert(parts.destination, {
		id = "op-bottom", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = 0, x = 0, y = -565, w = 1920, h = 565},
			{time = openTime, y = 0, acc = MAIN.ACC.DECELERATE}
		}
	})
	-- ウィンドウ閉じる
	table.insert(parts.destination, {
		id = "op-top", loop = openTime, timer = MAIN.TIMER.PANEL1_OFF, dst = {
			{time = 0, x = 0, y = 515, w = 1920, h = 565},
			{time = openTime, y = 1080, acc = MAIN.ACC.DECELERATE}
		}
	})
	table.insert(parts.destination, {
		id = "op-bottom", loop = openTime, timer = MAIN.TIMER.PANEL1_OFF, dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 565},
			{time = openTime, y = -565, acc = MAIN.ACC.DECELERATE}
		}
	})
	-- 左に流れる
	table.insert(parts.destination, {
		id = "op-dia", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 0, y = 58, w = 1950, h = 50},
			{time = 50000, x = -1950}
		}
	})
	table.insert(parts.destination, {
		id = "op-dia", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 1950, y = 58, w = 1950, h = 50},
			{time = 50000, x = 0}
		}
	})
	-- 右に流れる
	table.insert(parts.destination, {
		id = "op-dia", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 0, y = 970, w = 1950, h = 50},
			{time = 50000, x = 1950}
		}
	})
	table.insert(parts.destination, {
		id = "op-dia", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = -1950, y = 970, w = 1950, h = 50},
			{time = 50000, x = 0}
		}
	})
	table.insert(parts.destination, {
		id = "op-title", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 533, y = 58, w = 853, h = 50}
		}
	})
	table.insert(parts.destination, {
		id = "op-menu", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 351, y = 156, w = 1273, h = 680}
		}
	})
	table.insert(parts.destination, {
		id = "op-info", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 487, y = 866, w = 1001, h = 91}
		}
	})
end

local function brightInfo(parts)
	table.insert(parts.image, {id = "op-up", src = 6, x = 900, y = 1210, w = 34, h = 13})
	table.insert(parts.image, {id = "op-down", src = 6, x = 900, y = 1230, w = 65, h = 13})
	local upPos = {{850, 781}, {1062, 781}}
	local downPos = {{940, 781}, {780, 665}, {887, 665}, {994, 665}, {1101, 665}}
	-- up
	for i = 1, 2, 1 do
		table.insert(parts.destination, {
			id = "op-up", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
				{time = openTime, x = upPos[i][1], y = upPos[i][2], w = 34, h = 13},
				{time = 1100, a = 100},
				{time = 2100, a = 255}
			}
		})
	end
	-- down
	for i = 1, 5, 1 do
		table.insert(parts.destination, {
			id = "op-down", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
				{time = openTime, x = downPos[i][1], y = downPos[i][2], w = 65, h = 13, a = 100},
				{time = 1100, a = 255},
				{time = 2100, a = 100}
			}
		})
	end
end

-- オプション部分
local function option(parts)
	do
		local posY = 2964
		for i = 1, 10, 1 do
			table.insert(parts.image, {id = "op-selector10-" ..i, src = 6, x = 0, y = posY, w = 143, h = 240})
			posY = posY - 24
		end
	end
	do
		local posY = 2860
		for i = 1 , 6, 1 do
			table.insert(parts.image, {id = "op-selector6-" ..i, src = 6, x = 143, y = posY, w = 143, h = 144})
			posY = posY - 24
		end
	end
	do
		local posY = 2834
		for i = 1, 5, 1 do
			table.insert(parts.image, {id = "op-selector5-" ..i, src = 6, x = 286, y = posY, w = 143, h = 120})
			posY = posY - 24
		end
	end
	do
		local posY = 2809
		for i = 1, 4, 1 do
			table.insert(parts.image, {id = "op-selector4-" ..i, src = 6, x = 429, y = posY, w = 143, h = 96})
			posY = posY - 24
		end
	end
	do
		local posX = 0
		for i = 1, 10, 1 do
			table.insert(parts.image, {id = "op-random-selector10-" ..i, src = 6, x = posX, y = 1270, w = 156, h = 273})
			posX = posX + 156
		end
	end
	do
		local posX = 0
		for i = 1, 6, 1 do
			table.insert(parts.image, {id = "op-gauge-selector6-" ..i, src = 6, x = posX, y = 1550, w = 196, h = 178})
			posX = posX + 196
		end
	end
	do
		local posX = 0
		for i = 1, 4, 1 do
			table.insert(parts.image, {id = "op-dp-selector4-" ..i, src = 6, x = posX, y = 1730, w = 196, h = 130})
			posX = posX + 196
		end
	end
	do
		local posX = 0
		for i = 1, 5, 1 do
			table.insert(parts.image, {id = "op-hsfix-selector5-" ..i, src = 6, x = posX, y = 1860, w = 171, h = 154})
			posX = posX + 171
		end
	end
	table.insert(parts.imageset, {id = "option-random-1p-info", ref = MAIN.BUTTON.RANDOM_1P, images = {"op-random-selector10-1", "op-random-selector10-2", "op-random-selector10-3", "op-random-selector10-4", "op-random-selector10-5", "op-random-selector10-6", "op-random-selector10-7", "op-random-selector10-8", "op-random-selector10-9", "op-random-selector10-10"}})
	table.insert(parts.imageset, {id = "option-random-2p-info", ref = MAIN.BUTTON.RANDOM_2P, images = {"op-random-selector10-1", "op-random-selector10-2", "op-random-selector10-3", "op-random-selector10-4", "op-random-selector10-5", "op-random-selector10-6", "op-random-selector10-7", "op-random-selector10-8", "op-random-selector10-9", "op-random-selector10-10"}})
	table.insert(parts.imageset, {id = "option-random-1p", ref = MAIN.BUTTON.RANDOM_1P, images = {"op-selector10-1", "op-selector10-2", "op-selector10-3", "op-selector10-4", "op-selector10-5", "op-selector10-6", "op-selector10-7", "op-selector10-8", "op-selector10-9", "op-selector10-10"}})
	table.insert(parts.imageset, {id = "option-random-2p", ref = MAIN.BUTTON.RANDOM_2P, images = {"op-selector10-1", "op-selector10-2", "op-selector10-3", "op-selector10-4", "op-selector10-5", "op-selector10-6", "op-selector10-7", "op-selector10-8", "op-selector10-9", "op-selector10-10"}})
	table.insert(parts.imageset, {id = "option-gauge-info", ref = MAIN.BUTTON.GAUGE_1P, images = {"op-gauge-selector6-1", "op-gauge-selector6-2", "op-gauge-selector6-3", "op-gauge-selector6-4", "op-gauge-selector6-5", "op-gauge-selector6-6"}})
	table.insert(parts.imageset, {id = "option-gauge", ref = MAIN.BUTTON.GAUGE_1P, images = {"op-selector6-1", "op-selector6-2", "op-selector6-3", "op-selector6-4", "op-selector6-5", "op-selector6-6"}})
	table.insert(parts.imageset, {id = "option-dp-info", ref = MAIN.BUTTON.DPOPTION, images = {"op-dp-selector4-1", "op-dp-selector4-2", "op-dp-selector4-3", "op-dp-selector4-4"}})
	table.insert(parts.imageset, {id = "option-dp", ref = MAIN.BUTTON.DPOPTION, images = {"op-selector4-1", "op-selector4-2", "op-selector4-3", "op-selector4-4"}})
	table.insert(parts.imageset, {id = "option-hsfix-info", ref = MAIN.BUTTON.HSFIX, images = {"op-hsfix-selector5-1", "op-hsfix-selector5-2", "op-hsfix-selector5-3", "op-hsfix-selector5-4", "op-hsfix-selector5-5"}})
	table.insert(parts.imageset, {id = "option-hsfix", ref = MAIN.BUTTON.HSFIX, images = {"op-selector5-1", "op-selector5-2", "op-selector5-3", "op-selector5-4", "op-selector5-5"}})

	table.insert(parts.destination, {
		id = "option-random-1p-info", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 495, y = 198, w = 156, h = 273}
		}
	})
	table.insert(parts.destination, {
		id = "option-random-1p", loop = openTime, op = menuOpen(), blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 353, y = 204, w = 143, h = 240}
		}
	})
	table.insert(parts.destination, {
		id = "option-random-2p-info", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 1468, y = 198, w = 156, h = 273}
		}
	})
	table.insert(parts.destination, {
		id = "option-random-2p", loop = openTime, op = menuOpen(), blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 1326, y = 204, w = 143, h = 240}
		}
	})
	table.insert(parts.destination, {
		id = "option-gauge-info", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 801, y = 293, w = 196, h = 178}
		}
	})
	table.insert(parts.destination, {
		id = "option-gauge", loop = openTime, op = menuOpen(), blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 659, y = 299, w = 143, h = 144}
		}
	})
	table.insert(parts.destination, {
		id = "option-dp-info", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 961, y = 157, w = 196, h = 130}
		}
	})
	table.insert(parts.destination, {
		id = "option-dp", loop = openTime, op = menuOpen(), blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 819, y = 162, w = 143, h = 96}
		}
	})
	table.insert(parts.destination, {
		id = "option-hsfix-info", loop = openTime, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 1147, y = 317, w = 171, h = 154}
		}
	})
	table.insert(parts.destination, {
		id = "option-hsfix", loop = openTime, op = menuOpen(), blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 1006, y = 323, w = 143, h = 120}
		}
	})
end

-- ターゲット選択
local function targetSelect(parts)
	local pos = {x = 40, y = 770}
	local color = {r = 125, g = 81, b = 0}
	table.insert(parts.image, {id = "op-target-info", src = 6, x = 900, y = 1860, w = 303, h = 86})
	table.insert(parts.destination, {id = "op-target-info", op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {{time = openTime, x = pos.x - 5, y = pos.y + 35, w = 303, h = 86}}})
	-- 前半
	table.insert(parts.image, {id = "s_rivalFrame", src = 6, x = 1600, y = 1210, w = 295, h = 30})
	table.insert(parts.image, {id = "s_rivalFlash", src = 6, x = 1600, y = 1240, w = 295, h = 30})
	for i = 1, 10, 1 do
		table.insert(parts.image, {id = "f_rivalFrame" ..i, src = 6, x = 1600, y = 1210, w = 295, h = 30})
		table.insert(parts.destination, {id = "f_rivalFrame" ..i, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {{time = openTime, x = pos.x, y = pos.y, w = 295, h = 30}}})
		table.insert(parts.destination, {id = "f_rival" ..i, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {{time = openTime, x = pos.x + 15, y = pos.y + 2, w = 280, h = 20, r = color.r, g = color.g, b = 0}}})
		color.r = color.r + 13
		color.g = color.g + 8
		pos.y = pos.y - 27
	end
	-- 選択部分
	table.insert(parts.image, {id = "s_rivalFrame", src = 6, x = 1600, y = 1210, w = 295, h = 30})
	table.insert(parts.image, {id = "s_rivalFlash", src = 6, x = 1600, y = 1240, w = 295, h = 30})
	table.insert(parts.destination, {id = "s_rivalFrame", op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {{time = openTime, x = pos.x - 20, y = pos.y, w = 295, h = 30}}})
	table.insert(parts.destination, {id = "s_rival", op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {{time = openTime, x = pos.x + 5, y = pos.y + 2, w = 280, h = 20, r = 255, g = 162, b = 0}}})
	table.insert(parts.destination, {
		id = "s_rivalFlash", op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {
			{time = openTime, x = pos.x - 20, y = pos.y, w = 295, h = 30},
			{time = openTime + 250, a = 220},
			{time = openTime + 500, a = 255}
		}
	})
	pos.y = pos.y - 27
	-- 後半
	table.insert(parts.image, {id = "s_rivalFrame", src = 6, x = 1600, y = 1210, w = 295, h = 30})
	table.insert(parts.image, {id = "s_rivalFlash", src = 6, x = 1600, y = 1240, w = 295, h = 30})
	for i = 1, 10, 1 do
		table.insert(parts.image, {id = "b_rivalFrame" ..i, src = 6, x = 1600, y = 1210, w = 295, h = 30})
		table.insert(parts.destination, {id = "b_rivalFrame" ..i, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {{time = openTime, x = pos.x, y = pos.y, w = 295, h = 30}}})
		table.insert(parts.destination, {id = "b_rival" ..i, op = menuOpen(), timer = MAIN.TIMER.PANEL1_ON, loop = openTime, dst = {{time = openTime, x = pos.x + 15, y = pos.y + 2, w = 280, h = 20, r = color.r, g = color.g, b = 0}}})
		color.r = color.r - 13
		color.g = color.g - 8
		pos.y = pos.y - 27
	end
end

local function dpOnly(parts)
	-- DPでない時に表示
	table.insert(parts.image, {id = "op-dponly", src = 6, x = 1300, y = 1860, w = 627, h = 698})
	table.insert(parts.destination, {
		id = "op-dponly", loop = openTime, op = {MAIN.OP.PANEL1, -MAIN.OP.SONG14KEY, MAIN.OP.SONGBAR}, timer = MAIN.TIMER.PANEL1_ON, dst = {
			{time = openTime, x = 1013, y = 157, w = 627, h = 698}
		}
	})
end

local function load()
	local parts = {}
	parts.image = {}
	parts.imageset = {}
	parts.destination = {}
	background(parts)
	brightInfo(parts)
	option(parts)
	targetSelect(parts)
	dpOnly(parts)
	return parts
end

return {
	load = load
}