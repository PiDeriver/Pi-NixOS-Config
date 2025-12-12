--[[
	メインフレームパーツ
	@author : KASAKO
--]]

-- アシストオプションを有効にしている場合は警告を表示
local function showAssistInfo(parts)
	table.insert(parts.image, {id = "mainAssistinfo", src = 5, x = 2800, y = 80, w = 400, h = 100})
	table.insert(parts.destination, {
		id = "mainAssistinfo", draw = function()
			return CUSTOM.OP.isAssistOn()
		end, dst = {
			{time = 0, x = 600, y = 773, w = 400, h = 100},
			{time = 500, a = 220},
			{time = 1000, a = 255}
		}
	})
end
-- 選曲スクロール
local function scrollBar(parts)
	table.insert(parts.image, {id = "scroll-frame", src = 7, x = 980, y = 0, w = 28, h = 636})
	table.insert(parts.slider, {id = "scroll-lamp", src = 7, x = 1010, y = 0, w = 35, h = 45, type = 1, range = 600, angle = 2, changeable = true})
	table.insert(parts.destination, {
		id = "scroll-frame", loop = 1000, dst = {
			{time = 0, x = 2000, y = 278, w = 28, h = 636},
			{time = 1000, x = 1860, acc = MAIN.ACC.DECELERATE}
		}
	})
	table.insert(parts.destination, {
		id = "scroll-lamp", loop = 1000, dst = {
			{time = 1000, x = 1857, y = 873, w = 35, h = 45},
			{time = 2000, a = 150},
			{time = 3000, a = 255},
		}
	})
end
-- 修飾パーツ
local function illumination(parts)
	table.insert(parts.image, {id = "beam-guide", src = 5, x = 2250, y = 1300, w = 57, h = 19, divx = 3, cycle = 100})
	-- 上
	table.insert(parts.destination, {
		id = "beam-guide", loop = 0, dst = {
			{time = 0, x = 1920, y = 920, w = 19, h = 19},
			{time = 10000, x = 466},
			{time = 10500, y = 869},
			{time = 15000, x = 0},
		}
	})
	table.insert(parts.destination, {
		id = "beam-guide", loop = 0, dst = {
			{time = 0, x = 1920, y = 920, w = 19, h = 19},
			{time = 6000, x = 466},
			{time = 6250, y = 869},
			{time = 8500, x = 0},
		}
	})
	-- 下
	table.insert(parts.destination, {
		id = "beam-guide", loop = 0, dst = {
			{time = 0, x = 0, y = 206, w = 19, h = 19},
			{time = 10000, x = 1434},
			{time = 10500, y = 258},
			{time = 15000, x = 1920},
		}
	})
	table.insert(parts.destination, {
		id = "beam-guide", loop = 0, dst = {
			{time = 0, x = 0, y = 206, w = 19, h = 19},
			{time = 6000, x = 1434},
			{time = 6250, y = 258},
			{time = 8500, x = 1920},
		}
	})
end
-- メインフレーム
local function mainFrame(parts)
	table.insert(parts.image, {id = "beamBottom", src = 5, x = 0, y = 2950, w = 960, h = 30})
	table.insert(parts.image, {id = "main-top", src = 5, x = 0, y = 2400, w = 1920, h = 207})
	table.insert(parts.image, {id = "main-dia", src = 5, x = 0, y = 1160, w = 2200, h = 75})
	table.insert(parts.image, {id = "main-title", src = 5, x = 0, y = 1290, w = 540, h = 30})
	table.insert(parts.image, {id = "skinname", src = 5, x = 0, y = 1329, w = 396, h = 18})
	table.insert(parts.image, {id = "keyinfo", src = 5, x = 0, y = 1350, w = 350, h = 113})
	table.insert(parts.image, {id = "main-bottom", src = 5, x = 0, y = 2616, w = 1920, h = 270})
	-- 下からのビーム
	table.insert(parts.destination, {
		id = "beamBottom", blend = MAIN.BLEND.ADDITION, dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 30, a = 150, r = CUSTOM.NUM.randNum(100,255), g = CUSTOM.NUM.randNum(100,255), b = CUSTOM.NUM.randNum(100,255)},
			{time = 5000, y = 1080 / 2, a = 0}
		}
	})
	-- メインフレーム上
	table.insert(parts.destination, {id = "main-top", dst = {{x = 0, y = 874, w = 1920, h = 207}}})
	table.insert(parts.destination, {
		id = "main-dia", loop = 0, dst = {
			{time = 0, x = 0, y = 964, w = 2200, h = 75, a = 150},
			{time = 50000, x = -2200},
		}
	})
	table.insert(parts.destination, {
		id = "main-dia", loop = 0, dst = {
			{time = 0, x = 2200, y = 964, w = 2200, h = 75, a = 150},
			{time = 50000, x = 0},
		}
	})
	table.insert(parts.destination, {id = "main-title", dst = {{x = 40, y = 987, w = 540, h = 30}}})
	table.insert(parts.destination, {id = "skinname", dst = {{x = 1430, y = 1057, w = 396, h = 18}}})
	table.insert(parts.destination, {id = "version", filter = MAIN.FILTER.OFF, dst = {{x = 1840, y = 1055, w = 80, h = 16}}})
	if PROPERTY.iskeymapOn() then table.insert(parts.destination, {id = "keyinfo", dst = {{x = 680, y = 963, w = 350, h = 113}}}) end
	-- メインフレーム下
	table.insert(parts.destination, {id = "main-bottom", dst = {{x = 0, y = 0, w = 1920, h = 270}}})
end
-- 検索エリア
local function searchArea(parts)
	table.insert(parts.image, {id = "main-search", src = 5, x = 0, y = 1240, w = 463, h = 45})
	table.insert(parts.destination, {
		id = "main-search", dst = {
			{x = 5, y = 885, w = 463, h = 45},
		}
	})
	table.insert(parts.destination, {
		id = "search" , dst = {
			{x = 50, y = 895, w = 418, h = 30},
		}
	})
end
-- プレイモード
local function playMode(parts)
	local wd = {"5", "7", "10", "14", "9", "24", "48"}
	local op = {MAIN.OP.SONG5KEY, MAIN.OP.SONG7KEY, MAIN.OP.SONG10KEY, MAIN.OP.SONG14KEY, MAIN.OP.SONG9KEY, MAIN.OP.SONG24KEY, MAIN.OP.SONG24KEYDP}
	table.insert(parts.image, {id = "allkeys", src = 5, x = 2401, y = 0, w = 306, h = 39})
	table.insert(parts.image, {id = "5keys", src = 5, x = 2401, y = 39, w = 306, h = 39})
	table.insert(parts.image, {id = "7keys", src = 5, x = 2401, y = 78, w = 306, h = 39})
	table.insert(parts.image, {id = "10keys", src = 5, x = 2401, y = 117, w = 306, h = 39})
	table.insert(parts.image, {id = "14keys", src = 5, x = 2401, y = 156, w = 306, h = 39})
	table.insert(parts.image, {id = "9keys", src = 5, x = 2401, y = 195, w = 306, h = 39})
	table.insert(parts.image, {id = "24keys", src = 5, x = 2401, y = 234, w = 306, h = 39})
	table.insert(parts.image, {id = "48keys", src = 5, x = 2401, y = 273, w = 306, h = 39})
	table.insert(parts.imageset, {id = "btn-modeset", ref = 11, images = {"allkeys", "5keys", "7keys", "10keys", "14keys", "9keys", "24keys", "48keys"}})
	for i = 1, 7, 1 do
		table.insert(parts.destination, {
			id = wd[i] .."keys", op = {op[i]}, dst = {
				{x = 1527, y = 213, w = 306, h = 39},
			}
		})
	end
end
-- キーコマンド説明
local function keyCommand(parts)
	table.insert(parts.image, {id = "info", src = 5, x = 900, y = 1470, w = 500, h = 630, divy = 7, cycle = 14000})
	table.insert(parts.destination, {
		id = "info", dst = {
			{x = 90, y = 777, w = 500, h = 90},
		}
	})
end
-- キャラクターアニメーション
local function animationChar(parts)
	local switchTime = 30
	local magnification = 1.3
	local animation = {
		body = {x = 1700, w = 200 / magnification},
		pre = {y = 265, h = 305 / magnification},
		post = {y = 270, h = (305 / magnification) + 3}
	}
	table.insert(parts.source, {id = "char", path = "Root/image/*.png"})
	table.insert(parts.image, {id = "char_wait", src = "char", x = 400, y = 0, w = 200, h = 305})

	-- 通常待機モーション
	table.insert(parts.image, {id = "char_normal", src = "char", x = 0, y = 0, w = 200, h = 305})
	table.insert(parts.destination, {
		id = "char_normal", filter = MAIN.FILTER.OFF, op = {-MAIN.OP.SONGBAR}, dst = {
			{time = 0, x = animation.body.x, y = animation.pre.y, w = animation.body.w, h = animation.pre.h, acc = MAIN.ACC.DECELERATE},
			{time = 4800},
			{time = 5000, y = animation.post.y, h = animation.post.h},
			{time = 5200, y = animation.pre.y, h = animation.pre.h},
		}
	})
	-- bpm1-1000まで作ってみる
	for i = 1, 1000, 1 do
		table.insert(parts.image, {id = "char" ..i, src = "char", timer = MAIN.TIMER.SONGBAR_CHANGE, x = 0, y = 0, w = 400, h = 610, divx = 2, divy = 2, cycle = CUSTOM.NUM.oneBeat2(4, i)})
		table.insert(parts.destination, {
			id = "char" ..i, timer = MAIN.TIMER.SONGBAR_CHANGE, filter = MAIN.FILTER.OFF, draw = function()
				return i == main_state.number(MAIN.NUM.MAINBPM) and not CUSTOM.OP.isNeglect(switchTime)
			end, dst = {
				{time = 0, x = animation.body.x, y = animation.pre.y, w = animation.body.w, h = animation.pre.h, acc = MAIN.ACC.DECELERATE},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 1, y = animation.post.y, h = animation.post.h},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 2, y = animation.pre.y, h = animation.pre.h},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 3, y = animation.post.y, h = animation.post.h},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 4, y = animation.pre.y, h = animation.pre.h},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 5, y = animation.post.y, h = animation.post.h},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 6, y = animation.pre.y, h = animation.pre.h},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 7, y = animation.post.y, h = animation.post.h},
				{time = (CUSTOM.NUM.oneBeat2(4, i) / 8) * 8, y = animation.pre.y, h = animation.pre.h},
			}
		})
	end
	table.insert(parts.destination, {
		id = "char_wait", filter = MAIN.FILTER.OFF, timer = timer_util.timer_observe_boolean(function() return CUSTOM.OP.isNeglect(switchTime) and main_state.option(MAIN.OP.SONGBAR) end), dst = {
			{time = 0, x = animation.body.x, y = animation.pre.y, w = animation.body.w, h = animation.pre.h},
			{time = 4750, x = animation.body.x - 300},
			{time = 4850, y = animation.post.y},
			{time = 5000, x = animation.body.x + animation.body.w - 300, y = animation.pre.y, w = -animation.body.w},
			{time = 9750, x = animation.body.x + 150},
			{time = 9850, y = animation.post.y},
			{time = 10000, x = animation.body.x, y = animation.pre.y, w = animation.body.w}
		}
	})
end

local function load()
	local parts = {}
	parts.source = {}
	parts.image = {}
	parts.slider = {}
	parts.imageset = {}
	parts.destination = {}
	mainFrame(parts)
	if PROPERTY.isCharAnimationOn() then animationChar(parts) end
	searchArea(parts)
	playMode(parts)
	if PROPERTY.isIlluminationOn() then illumination(parts) end
	keyCommand(parts)
	scrollBar(parts)
	showAssistInfo(parts)
	return parts
end

return {
	load = load
}