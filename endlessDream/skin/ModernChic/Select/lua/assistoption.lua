--[[
	アシストオプションを表示
	@author : KASAKO
--]]
local openTime = 100
local function o_menuOpen()
	return {MAIN.OP.PANEL2}
end
local function switch(parts)
	table.insert(parts.image, {id = "assist-switch", src = 3, x = 1260, y = 1260, w = 70, h = 18})
	local posX = {820, 926, 1032, 767, 873, 979, 1085}
	local posY = {623, 623, 623, 440, 440, 440, 440}
	for i = 1, 7, 1 do
		table.insert(parts.destination, {
			id = "assist-switch", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
				{time = openTime, x = posX[i], y = posY[i], w = 70, h = 18},
				{time = openTime + 1000, a = 100},
				{time = openTime + 2000, a = 255}
			}
		})
	end
end
local function window(parts)
	table.insert(parts.image, {id = "assist-top", src = 3, x = 0, y = 0, w = 1920, h = 565})
	table.insert(parts.image, {id = "assist-bottom", src = 3, x = 0, y = 570, w = 1920, h = 565})
	table.insert(parts.destination, {
		id = "assist-top", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = 0, x = 0, y = 1080, w = 1920, h = 565},
			{time = openTime, y = 515, acc = MAIN.ACC.DECELERATE}
		}
	})
	table.insert(parts.destination, {
		id = "assist-bottom", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = 0, x = 0, y = -565, w = 1920, h = 565},
			{time = openTime, y = 0, acc = MAIN.ACC.DECELERATE}
		}
	})
	-- ウィンドウ閉じる
	table.insert(parts.destination, {
		id = "assist-top", loop = openTime, timer = MAIN.TIMER.PANEL2_OFF, dst = {
			{time = 0, x = 0, y = 515, w = 1920, h = 565},
			{time = openTime, y = 1080, acc = MAIN.ACC.DECELERATE}
		}
	})
	table.insert(parts.destination, {
		id = "assist-bottom", loop = openTime, timer = MAIN.TIMER.PANEL2_OFF, dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 565},
			{time = openTime, y = -565, acc = MAIN.ACC.DECELERATE}
		}
	})
end
local function info(parts)
	table.insert(parts.image, {id = "assist-dia", src = 3, x = 0, y = 1150, w = 1950, h = 50})
	table.insert(parts.image, {id = "assist-title", src = 3, x = 0, y = 1200, w = 1521, h = 50})
	table.insert(parts.image, {id = "assist-menu", src = 3, x = 0, y = 1260, w = 618, h = 642})
	table.insert(parts.image, {id = "assist-info", src = 3, x = 630, y = 1260, w = 628, h = 83})
	table.insert(parts.image, {id = "assist-config", src = 3, x = 630, y = 1350, w = 558, h = 86})
	table.insert(parts.image, {id = "assist-info-l", src = 3, x = 630, y = 1450, w = 550, h = 732})
	table.insert(parts.image, {id = "assist-info-r", src = 3, x = 1260, y = 1450, w = 550, h = 732})
	-- 左に流れる
	table.insert(parts.destination, {
		id = "assist-dia", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 0, y = 58, w = 1950, h = 50},
			{time = 50000, x = -1950}
		}
	})
	table.insert(parts.destination, {
		id = "assist-dia", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 1950, y = 58, w = 1950, h = 50},
			{time = 50000, x = 0}
		}
	})
	-- 右に流れる
	table.insert(parts.destination, {
		id = "assist-dia", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 0, y = 970, w = 1950, h = 50},
			{time = 50000, x = 1950}
		}
	})
	table.insert(parts.destination, {
		id = "assist-dia", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = -1950, y = 970, w = 1950, h = 50},
			{time = 50000, x = 0}
		}
	})
	table.insert(parts.destination, {
		id = "assist-title", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 198, y = 58, w = 1521, h = 50}
		}
	})
	table.insert(parts.destination, {
		id = "assist-menu", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 651, y = 201, w = 618, h = 642}
		}
	})
	table.insert(parts.destination, {
		id = "assist-info", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 646, y = 915, w = 628, h = 83}
		}
	})
	table.insert(parts.destination, {
		id = "assist-config", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 52, y = 915, w = 558, h = 86}
		}
	})
	table.insert(parts.destination, {
		id = "assist-info-l", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 56, y = 162, w = 550, h = 732}
		}
	})
	table.insert(parts.destination, {
		id = "assist-info-r", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 1315, y = 162, w = 550, h = 732}
		}
	})
	table.insert(parts.destination, {
		id = "assist-config", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 1311, y = 915, w = 558, h = 86}
		}
	})
end
-- ON,OFF切り替え
local function btn(parts)
	table.insert(parts.imageset, {id = "option-exjudge", ref = MAIN.BUTTON.ASSIST_EXJUDGE, images = {"assist-selector2-1", "assist-selector2-2"}})
	table.insert(parts.imageset, {id = "option-judgearea", ref = MAIN.BUTTON.ASSIST_JUDGEAREA, images = {"assist-selector2-1", "assist-selector2-2"}})
	table.insert(parts.imageset, {id = "option-marknote", ref = MAIN.BUTTON.ASSIST_MARKNOTE, images = {"assist-selector2-1", "assist-selector2-2"}})
	table.insert(parts.imageset, {id = "option-nomine", ref = MAIN.BUTTON.ASSIST_NOMINE, images = {"assist-selector2-1", "assist-selector2-2"}})
	table.insert(parts.imageset, {id = "option-constant", ref = MAIN.BUTTON.ASSIST_CONSTANT, images = {"assist-selector2-1", "assist-selector2-2"}})
	table.insert(parts.imageset, {id = "option-legacy", ref = MAIN.BUTTON.ASSIST_LEGACY, images = {"assist-selector2-1", "assist-selector2-2"}})
	table.insert(parts.imageset, {id = "option-bpmguide", ref = MAIN.BUTTON.ASSIST_BPMGUIDE, images = {"assist-selector2-1", "assist-selector2-2"}})
	table.insert(parts.destination, {
		id = "option-exjudge", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 653, y = 204, w = 143, h = 48}
		}
	})
	table.insert(parts.destination, {
		id = "option-judgearea", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 810, y = 204, w = 143, h = 48}
		}
	})
	table.insert(parts.destination, {
		id = "option-marknote", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 967, y = 204, w = 143, h = 48}
		}
	})
	table.insert(parts.destination, {
		id = "option-nomine", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 1124, y = 204, w = 143, h = 48}
		}
	})
	table.insert(parts.destination, {
		id = "option-constant", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 673, y = 738, w = 143, h = 48}
		}
	})
	table.insert(parts.destination, {
		id = "option-legacy", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 889, y = 738, w = 143, h = 48}
		}
	})
	table.insert(parts.destination, {
		id = "option-bpmguide", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 1106, y = 738, w = 143, h = 48}
		}
	})
end
-- マウスクリック用エリア
-- アシスト用オプションボタンはactが反応しない？
local function clickSwitch(parts)
	-- exjudge
	table.insert(parts.image, {id = "assist-exjudgeSW", src = 3, x = 1920, y = 0, w = 1, h = 1, act = MAIN.BUTTON.ASSIST_EXJUDGE})
	table.insert(parts.destination, {
		id = "assist-exjudgeSW", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 651, y = 201, w = 147, h = 108},
		}
	})
	-- judgearea
	table.insert(parts.image, {id = "assist-judgeareaSW", src = 3, x = 1920, y = 0, w = 1, h = 1, act = MAIN.BUTTON.ASSIST_JUDGEAREA})
	table.insert(parts.destination, {
		id = "assist-judgeareaSW", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 808, y = 201, w = 147, h = 108},
		}
	})
	-- marknote
	table.insert(parts.image, {id = "assist-marknoteSW", src = 3, x = 1920, y = 0, w = 1, h = 1, act = MAIN.BUTTON.ASSIST_MARKNOTE})
	table.insert(parts.destination, {
		id = "assist-marknoteSW", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 965, y = 201, w = 147, h = 108},
		}
	})
	-- nomine
	table.insert(parts.image, {id = "assist-nomineSW", src = 3, x = 1920, y = 0, w = 1, h = 1, act = MAIN.BUTTON.ASSIST_NOMINE})
	table.insert(parts.destination, {
		id = "assist-nomineSW", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 1122, y = 201, w = 147, h = 108},
		}
	})
	-- constant
	table.insert(parts.image, {id = "assist-constantSW", src = 3, x = 1920, y = 0, w = 1, h = 1, act = MAIN.BUTTON.ASSIST_CONSTANT})
	table.insert(parts.destination, {
		id = "assist-constantSW", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 671, y = 735, w = 147, h = 108},
		}
	})
	-- legacy
	table.insert(parts.image, {id = "assist-legacySW", src = 3, x = 1920, y = 0, w = 1, h = 1, act = MAIN.BUTTON.ASSIST_LEGACY})
	table.insert(parts.destination, {
		id = "assist-legacySW", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 887, y = 735, w = 147, h = 108},
		}
	})
	-- bpmguide
	table.insert(parts.image, {id = "assist-bpmguideSW", src = 3, x = 1920, y = 0, w = 1, h = 1, act = MAIN.BUTTON.ASSIST_BPMGUIDE})
	table.insert(parts.destination, {
		id = "assist-bpmguideSW", loop = openTime, op = o_menuOpen(), timer = MAIN.TIMER.PANEL2_ON, dst = {
			{time = openTime, x = 1103, y = 735, w = 147, h = 108},
		}
	})
end

local function load()
	local parts = {}
	
	parts.image = {
		{id = "assist-selector2-1", src = 3, x = 0, y = 1937, w = 143, h = 48},
		{id = "assist-selector2-2", src = 3, x = 0, y = 1913, w = 143, h = 48},
		{id = "assist-keyflash", src = 3, x = 157, y = 1910, w = 43, h = 65},
	}
	parts.imageset = {}
	parts.destination = {
		-- TODO キーフラッシュが動かない
--[[
		{id = "assist-keyflash", timer = sw1, dst = {
			{time = 0, x = 780, y = 418, w = 43, h = 65}
		}},
]]
	}
	window(parts)
	info(parts)
	btn(parts)
	switch(parts)
	clickSwitch(parts)
	return parts
end

return {
	load = load
}