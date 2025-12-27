--[[
	サブオプション（数字キー5）を表示
	@author : KASAKO
--]]
local openTime = 100
local function o_open()
	return {MAIN.OP.PANEL3}
end
local function judgeTimingAdjust(parts)
	table.insert(parts.image, {id = "timingAdjustBtn", src = 4, x = 1920, y = 0, w = 1, h = 1, divy = 2, act = MAIN.BUTTON.JUDGE_TIMING})
	table.insert(parts.destination, {
		id = "timingAdjustBtn", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 964, y = 216, w = 306, h = 128},
		}
	})
end
-- 背景
local function background(parts)
	table.insert(parts.image, {id = "subop-top", src = 4, x = 0, y = 0, w = 1920, h = 565})
	table.insert(parts.image, {id = "subop-bottom", src = 4, x = 0, y = 571, w = 1920, h = 565})
	table.insert(parts.image, {id = "subop-dia", src = 4, x = 0, y = 1220, w = 1950, h = 50})
	table.insert(parts.image, {id = "subop-title", src = 4, x = 0, y = 1150, w = 1200, h = 71})
	table.insert(parts.image, {id = "subop-menu", src = 4, x = 0, y = 1280, w = 619, h = 632})
	table.insert(parts.image, {id = "subop-info", src = 4, x = 630, y = 1280, w = 628, h = 83})

	table.insert(parts.destination, {
		id = "subop-top", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = 0, x = 0, y = 1080, w = 1920, h = 565},
			{time = openTime, y = 515, acc = MAIN.ACC.DECELERATE}
		}
	})
	table.insert(parts.destination, {
		id = "subop-bottom", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = 0, x = 0, y = -565, w = 1920, h = 565},
			{time = openTime, y = 0, acc = MAIN.ACC.DECELERATE}
		}
	})
	-- ウィンドウ閉じる
	table.insert(parts.destination, {
		id = "subop-top", loop = openTime, timer = MAIN.TIMER.PANEL3_OFF, dst = {
			{time = 0, x = 0, y = 515, w = 1920, h = 565},
			{time = openTime, y = 1080, acc = MAIN.ACC.DECELERATE}
		}
	})
	table.insert(parts.destination, {
		id = "subop-bottom", loop = openTime, timer = MAIN.TIMER.PANEL3_OFF, dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 565},
			{time = openTime, y = -565, acc = MAIN.ACC.DECELERATE}
		}
	})
	-- 左に流れる
	table.insert(parts.destination, {
		id = "subop-dia", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 0, y = 58, w = 1950, h = 50},
			{time = 50000, x = -1950}
		}
	})
	table.insert(parts.destination, {
		id = "subop-dia", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 1950, y = 58, w = 1950, h = 50},
			{time = 50000, x = 0}
		}
	})
	-- 右に流れる
	table.insert(parts.destination, {
		id = "subop-dia", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 0, y = 970, w = 1950, h = 50},
			{time = 50000, x = 1950}
		}
	})
	table.insert(parts.destination, {
		id = "subop-dia", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = -1950, y = 970, w = 1950, h = 50},
			{time = 50000, x = 0}
		}
	})
	table.insert(parts.destination, {
		id = "subop-title", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = (1920 - 1200) / 2, y = 55, w = 1200, h = 71}
		}
	})
	table.insert(parts.destination, {
		id = "subop-menu", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 651, y = 216, w = 619, h = 632}
		}
	})
	table.insert(parts.destination, {
		id = "subop-info", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 646, y = 915, w = 628, h = 83}
		}
	})
end
-- 数値関連
local function displayNumber(parts)
	-- 判定タイミング（+-あり3桁）
	table.insert(parts.value, {id = "judgetiming", src = 4, x = 143, y = 1948, w = 108, h = 28, divx = 12, divy = 2, digit = 3, ref = MAIN.NUM.JUDGETIMING})
	-- 緑数字（SP）
	table.insert(parts.value, {id = "duration-green", src = 4, x = 143, y = 1920, w = 90, h = 14, divx = 10, digit = 4, ref = MAIN.NUM.DURATION_GREEN})
	-- ノーツ表示時間
	table.insert(parts.value, {id = "duration", src = 4, x = 143, y = 1934, w = 90, h = 14, divx = 10, digit = 4, ref = MAIN.NUM.DURATION})

	table.insert(parts.destination, {
		id = "judgetiming", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 1087, y = 272, w = 9, h = 14}
		}
	})
	table.insert(parts.destination, {
		id = "duration-green", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 1130, y = 775, w = 9, h = 14}
		}
	})
	table.insert(parts.destination, {
		id = "duration", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 1060, y = 775, w = 9, h = 14}
		}
	})
end
-- 説明用メニュー
local function informationMenu(parts)
	table.insert(parts.image, {id = "subop-info-l", src = 4, x = 630, y = 1370, w = 558, h = 86})
	table.insert(parts.image, {id = "subop-menu-l", src = 4, x = 630, y = 1550, w = 550, h = 732})
	-- 配置
	local posX = 1311
	table.insert(parts.destination, {
		id = "subop-info-l", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = posX, y = 915, w = 558, h = 86}
		}
	})
	table.insert(parts.destination, {
		id = "subop-menu-l", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = posX + 4, y = 162, w = 550, h = 732}
		}
	})
end
-- ON,OFF切り替えセレクター
local function selector(parts)
	table.insert(parts.image, {id = "subop-selector5-1", src = 4, x = 0, y = 2024, w = 143, h = 120})
	table.insert(parts.image, {id = "subop-selector5-2", src = 4, x = 0, y = 2000, w = 143, h = 120})
	table.insert(parts.image, {id = "subop-selector5-3", src = 4, x = 0, y = 1976, w = 143, h = 120})
	table.insert(parts.image, {id = "subop-selector5-4", src = 4, x = 0, y = 1952, w = 143, h = 120})
	table.insert(parts.image, {id = "subop-selector5-5", src = 4, x = 0, y = 1928, w = 143, h = 120})
	table.insert(parts.image, {id = "subop-selector3-1", src = 4, x = 0, y = 2024, w = 143, h = 72})
	table.insert(parts.image, {id = "subop-selector3-2", src = 4, x = 0, y = 2000, w = 143, h = 72})
	table.insert(parts.image, {id = "subop-selector3-3", src = 4, x = 0, y = 1976, w = 143, h = 72})
	table.insert(parts.image, {id = "subop-selector2-1", src = 4, x = 0, y = 2024, w = 143, h = 48})
	table.insert(parts.image, {id = "subop-selector2-2", src = 4, x = 0, y = 2000, w = 143, h = 48})
	table.insert(parts.imageset, {id = "option-gas", ref = MAIN.BUTTON.GAUGEAUTOSHIFT, images = {"subop-selector5-1", "subop-selector5-2", "subop-selector5-3", "subop-selector5-4", "subop-selector5-5"}})
	table.insert(parts.imageset, {id = "option-bga", ref = MAIN.BUTTON.BGA, images = {"subop-selector3-1", "subop-selector3-2", "subop-selector3-3"}})
	table.insert(parts.imageset, {id = "option-NDTA", ref = MAIN.BUTTON.JUDGE_TIMING_AUTO_ADJUST, images = {"subop-selector2-1", "subop-selector2-2"}})
	table.insert(parts.destination, {
		id = "option-gas", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 653, y = 676, w = 143, h = 120}
		}
	})
	table.insert(parts.destination, {
		id = "option-bga", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 653, y = 220, w = 143, h = 72}
		}
	})
	table.insert(parts.destination, {
		id = "option-NDTA", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, blend = MAIN.BLEND.ADDITION, dst = {
			{time = openTime, x = 810, y = 244, w = 143, h = 48}
		}
	})
end
local function blink(parts)
	table.insert(parts.image, {id = "subop-up", src = 6, x = 900, y = 1210, w = 34, h = 13})
	table.insert(parts.image, {id = "subop-down", src = 6, x = 900, y = 1230, w = 65, h = 13})
	-- 上段
	table.insert(parts.destination, {
		id = "subop-down", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 820, y = 624, w = 65, h = 13, a = 100},
			{time = 1100, a = 255},
			{time = 2100, a = 100}
		}
	})
	table.insert(parts.destination, {
		id = "subop-down", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 927, y = 624, w = 65, h = 13, a = 100},
			{time = 1100, a = 255},
			{time = 2100, a = 100}
		}
	})
	table.insert(parts.destination, {
		id = "subop-up", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 1050, y = 624, w = 34, h = 13},
			{time = 1100, a = 100},
			{time = 2100, a = 255}
		}
	})
	-- 下段
	table.insert(parts.destination, {
		id = "subop-down", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 770, y = 443, w = 65, h = 13, a = 100},
			{time = 1100, a = 255},
			{time = 2100, a = 100}
		}
	})
	table.insert(parts.destination, {
		id = "subop-down", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 875, y = 443, w = 65, h = 13, a = 100},
			{time = 1100, a = 255},
			{time = 2100, a = 100}
		}
	})
	table.insert(parts.destination, {
		id = "subop-down", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 980, y = 443, w = 65, h = 13, a = 100},
			{time = 1100, a = 255},
			{time = 2100, a = 100}
		}
	})
	table.insert(parts.destination, {
		id = "subop-up", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = 1103, y = 443, w = 34, h = 13},
			{time = 1100, a = 100},
			{time = 2100, a = 255}
		}
	})
end
-- システムメニュー
local function systemMenu(parts)
	table.insert(parts.image, {id = "subop-info-r", src = 4, x = 630, y = 1460, w = 558, h = 86})
	table.insert(parts.image, {id = "subop-menu-r", src = 4, x = 1200, y = 1550, w = 550, h = 744})
	-- ボタン
	table.insert(parts.image, {id = "subop-btn", src = 4, x = 1960, y = 0, w = 230, h = 60})
	table.insert(parts.image, {id = "subop-btnRect", src = 4, x = 1960, y = 0 + 60, w = 230, h = 60})
	table.insert(parts.image, {id = "subop-off", src = 4, x = 1960 + 230, y = 0, w = 230, h = 60})
	table.insert(parts.image, {id = "subop-on", src = 4, x = 1960 + 230, y = 0 + 60, w = 230, h = 60})
	-- GAS下限
	table.insert(parts.image, {id = "subop-aEasy", src = 4, x = 1960 + 230 + 230, y = 0, w = 230, h = 60})
	table.insert(parts.image, {id = "subop-easy", src = 4, x = 1960 + 230 + 230, y = 0 + 60, w = 230, h = 60})
	table.insert(parts.image, {id = "subop-normal", src = 4, x = 1960 + 230 + 230, y = 0 + 60 + 60, w = 230, h = 60})
	-- 判定アルゴリズム
	table.insert(parts.image, {id = "subop-combo", src = 4, x = 1960 + 230 + 230 + 230, y = 0, w = 230, h = 60})
	table.insert(parts.image, {id = "subop-score", src = 4, x = 1960 + 230 + 230 + 230, y = 0 + 60, w = 230, h = 60})
	table.insert(parts.image, {id = "subop-bottomNote", src = 4, x = 1960 + 230 + 230 + 230, y = 0 + 60 + 60, w = 230, h = 60})

	table.insert(parts.imageset, {id = "option-VS", act = MAIN.BUTTON.CONSTANT, ref = MAIN.BUTTON.CONSTANT, images = {"subop-off", "subop-on"}})
	table.insert(parts.imageset, {id = "option-LLOG", act = MAIN.BUTTON.BOTTOMSIFTABLEFGAUGE, ref = MAIN.BUTTON.BOTTOMSIFTABLEFGAUGE, images = {"subop-aEasy", "subop-easy", "subop-normal"}})
	table.insert(parts.imageset, {id = "option-laneCover", act = MAIN.BUTTON.LANECOVER, ref = MAIN.BUTTON.LANECOVER, images = {"subop-off","subop-on"}})
	table.insert(parts.imageset, {id = "option-liftCover", act = MAIN.BUTTON.LIFT, ref = MAIN.BUTTON.LIFT, images = {"subop-off","subop-on"}})
	table.insert(parts.imageset, {id = "option-hidden", act = MAIN.BUTTON.HIDDEN, ref = MAIN.BUTTON.HIDDEN, images = {"subop-off","subop-on"}})
	table.insert(parts.imageset, {id = "option-HAA", act = MAIN.BUTTON.HISPEEDAUTOADJUST, ref = MAIN.BUTTON.HISPEEDAUTOADJUST, images = {"subop-off","subop-on"}})
	table.insert(parts.imageset, {id = "option-judgeAlgorithm", act = MAIN.BUTTON.JUDGEALGORITHM, ref = MAIN.BUTTON.JUDGEALGORITHM, images = {"subop-combo","subop-score", "subop-bottomNote"}})
	-- 配置
	local posX = 52
	table.insert(parts.destination, {
		id = "subop-info-r", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = posX, y = 915, w = 558, h = 86}
		}
	})
	table.insert(parts.destination, {
		id = "subop-menu-r", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
			{time = openTime, x = posX + 4, y = 150, w = 550, h = 744}
		}
	})
	-- ボタン配置
	local posY = 492
	local wd = {"VS", "judgeAlgorithm", "HAA", "hidden", "liftCover", "laneCover", "LLOG"}
	for i = 1, 7, 1 do
		-- 本体
		table.insert(parts.destination, {
			id = "subop-btn", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
				{time = openTime, x = posX + 311, y = posY, w = 230, h = 60},
			}
		})
		-- ボタン
		table.insert(parts.destination, {
			id = "option-" ..wd[i], loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
				{time = openTime, x = posX + 311, y = posY, w = 230, h = 60},
			}
		})
		-- マウスを合わせたときの処理
		table.insert(parts.destination, {
			id = "subop-btnRect", loop = openTime, op = o_open(), timer = MAIN.TIMER.PANEL3_ON, dst = {
				{time = openTime, x = posX + 311, y = posY, w = 230, h = 60, a = 255},
				{time = 350, a = 100},
				{time = 600, a = 255}
			}, mouseRect = {x = 0, y = 0, w = 230, h = 60}
		})
		posY = posY + 57
	end
end

local function load()
	local parts = {}
	parts.image = {}
	parts.value = {}
	parts.imageset = {}
	parts.destination = {}
	background(parts)
	displayNumber(parts)
	selector(parts)
	blink(parts)
	systemMenu(parts)
	informationMenu(parts)
	judgeTimingAdjust(parts)
	
	return parts
end

return {
	load = load
}