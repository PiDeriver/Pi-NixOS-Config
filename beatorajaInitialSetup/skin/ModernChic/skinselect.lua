--[[
	スキン選択画面
	@author : KASAKO
	blog: https://www.kasacontent.com/tag/modernchic/
]]
-- DEBUG = true
-- モジュール読み込み
main_state = require("main_state")
PROPERTY = require("SkinSelect.lua.require.property")
local header = require("SkinSelect.lua.require.header")

-- 背景のセット
local function background(parts)
	table.insert(parts.image, {id = "bg", src = "background", x = 0, y = 0, w = 1920, h = 1080})
	table.insert(parts.destination, {id = "bg", dst = {{x = 0, y = 0, w = 1920, h = 1080}}})
end

local function skinMenu(parts)
	local wd = {"musicselect", "decide", "result", "courseresult", "soundset", "keyconfig", "skinselect", "theme"}
	local ref = {MAIN.BUTTON.SKINSELECT_MUSIC_SELECT, MAIN.BUTTON.SKINSELECT_DECIDE, MAIN.BUTTON.SKINSELECT_RESULT, MAIN.BUTTON.SKINSELECT_COURSE_RESULT, MAIN.BUTTON.SKINSELECT_SOUND_SET, MAIN.BUTTON.SKINSELECT_KEY_CONFIG, MAIN.BUTTON.SKINSELECT_SKIN_SELECT, MAIN.BUTTON.SKINSELECT_THEME}
	local pos = {
		x = {25, 25, 25, 25, 439, 439, 439, 439},
		y = {252, 174, 95, 17, 252, 174, 95, 17}
	}
	local ad = 0
	for i = 1, #wd, 1 do
		table.insert(parts.image, {id = wd[i] .."-off", src = "system", x = 0, y = ad, w = 395, h = 71})
		table.insert(parts.image, {id = wd[i] .."-on", src = "system", x = 395, y = ad, w = 395, h = 71})
		table.insert(parts.imageset, {id = wd[i], images = {wd[i] .."-off", wd[i] .."-on"}, act = ref[i], ref = ref[i]})
		-- 配置
		table.insert(parts.destination, {id = wd[i], dst = {{x = pos.x[i], y = pos.y[i], w = 395, h = 71}}})
		ad = ad + 71
	end
end

local function playSkin(parts)
	local wd = {"7", "7battle", "14", "5", "10", "9", "9battle", "24", "24battle", "48"}
	local ref = {MAIN.BUTTON.SKINSELECT_7KEY, MAIN.BUTTON.SKINSELECT_BATTLE7, MAIN.BUTTON.SKINSELECT_14KEY, MAIN.BUTTON.SKINSELECT_5KEY, MAIN.BUTTON.SKINSELECT_10KEY, MAIN.BUTTON.SKINSELECT_9KEY, MAIN.BUTTON.SKINSELECT_BATTLE9, MAIN.BUTTON.SKINSELECT_24KEY, MAIN.BUTTON.SKINSELECT_24KEY_BATTLE, MAIN.BUTTON.SKINSELECT_24KEY_DOUBLE}
	local pos = {
		x = {900, 900, 900, 900, 1240, 1240, 1240, 1240, 1575, 1575},
		y = {252, 174, 95, 17, 252, 174, 95, 17, 252, 174}
	}
	local ad = 0
	for i = 1, #wd, 1 do
		table.insert(parts.image, {id = wd[i] .."-off", src = "system", x = 790, y = ad, w = 325, h = 71})
		table.insert(parts.image, {id = wd[i] .."-on", src = "system", x = 1115, y = ad, w = 325, h = 71})
		table.insert(parts.imageset, {id = wd[i], images = {wd[i] .."-off", wd[i] .."-on"}, act = ref[i], ref = ref[i]})
		-- 配置
		table.insert(parts.destination, {id = wd[i], dst = {{x = pos.x[i], y = pos.y[i], w = 325, h = 71}}})
		ad = ad + 71
	end
end

-- 10番目のクリックエリアが反応しない？
local function setItems(parts)
	table.insert(parts.image, {id = "iFrame", src = "system", x = 0, y = 900, w = 920, h = 56})
	-- カーソル
	table.insert(parts.image, {id = "l_cursor", src = "system", x = 0, y = 877, w = 21, h = 23})
	table.insert(parts.image, {id = "l_cursor_hover", src = "system", x = 0, y = 854, w = 21, h = 23})
	table.insert(parts.image, {id = "r_cursor", src = "system", x = 21, y = 877, w = 21, h = 23})
	table.insert(parts.image, {id = "r_cursor_hover", src = "system", x = 21, y = 854, w = 21, h = 23})
	local btn = {MAIN.BUTTON.SKIN_CUSTOMIZE1, MAIN.BUTTON.SKIN_CUSTOMIZE2, MAIN.BUTTON.SKIN_CUSTOMIZE3, MAIN.BUTTON.SKIN_CUSTOMIZE4, MAIN.BUTTON.SKIN_CUSTOMIZE5, MAIN.BUTTON.SKIN_CUSTOMIZE6, MAIN.BUTTON.SKIN_CUSTOMIZE7, MAIN.BUTTON.SKIN_CUSTOMIZE8, MAIN.BUTTON.SKIN_CUSTOMIZE9, MAIN.BUTTON.SKIN_CUSTOMIZE10}
	local basePosY = 1012
	for i = 1, 10, 1 do
		table.insert(parts.destination, {id = "iFrame", dst = {{x = 900, y = basePosY, w = 920, h = 56}}})
		table.insert(parts.destination, {id = "t_category" ..i, dst = {{x = 1093, y = basePosY + 12, w = 360, h = 25}}})
		table.insert(parts.destination, {id = "t_item" ..i, dst = {{x = 1556, y = basePosY + 12, w = 426, h = 25}}})
		-- クリック部分
		table.insert(parts.image, {id = "clickArea" ..i, src = "system", x = 1440, y = 0, w = 1, h = 1, act = btn[i], click = MAIN.I_CLICK.SEPARATE})
		table.insert(parts.destination, {id = "clickArea" ..i, dst = {{x = 1343, y = basePosY + 3, w = 426, h = 50}}})
		-- カーソル
		table.insert(parts.destination, {id = "l_cursor", dst = {{x = 1312, y = basePosY + 16, w = 21, h = 23}}})
		table.insert(parts.destination, {id = "l_cursor_hover", dst = {{x = 1312, y = basePosY + 16, w = 21, h = 23}}, mouseRect = {x = 20, y = -13, w = 226, h = 50}})
		table.insert(parts.destination, {id = "r_cursor", dst = {{x = 1778, y = basePosY + 16, w = 21, h = 23}}})
		table.insert(parts.destination, {id = "r_cursor_hover", dst = {{x = 1778, y = basePosY + 16, w = 21, h = 23}}, mouseRect = {x = -220, y = -13, w = 226, h = 50}})
		basePosY = basePosY - 65
	end
	-- スライダー
	
end

-- スキン選択メニュー
local function skinSelector(parts)
	-- クリック部分
	table.insert(parts.image, {id = "skinChangeArea", src = "system", x = 0, y = 970, w = 687, h = 388, act = MAIN.BUTTON.CHANGE_SKIN, click = MAIN.I_CLICK.SEPARATE})
	table.insert(parts.destination, {id = "skinChangeArea", dst = {{x = 111, y = 523, w = 687, h = 388}}})
	-- カーソル
	table.insert(parts.image, {id = "skin_l_cursor", src = "system", x = 0, y = 877, w = 21, h = 23})
	table.insert(parts.image, {id = "skin_l_cursor_hover", src = "system", x = 0, y = 854, w = 21, h = 23})
	table.insert(parts.image, {id = "skin_r_cursor", src = "system", x = 21, y = 877, w = 21, h = 23})
	table.insert(parts.image, {id = "skin_r_cursor_hover", src = "system", x = 21, y = 854, w = 21, h = 23})
	table.insert(parts.destination, {id = "skin_l_cursor", dst = {{x = 72, y = 706, w = 21, h = 23}}})
	table.insert(parts.destination, {id = "skin_l_cursor_hover", dst = {{x = 72, y = 706, w = 21, h = 23}}, mouseRect = {x = 35, y = -183, w = 344, h = 388}})
	table.insert(parts.destination, {id = "skin_r_cursor", dst = {{x = 817, y = 706, w = 21, h = 23}}})
	table.insert(parts.destination, {id = "skin_r_cursor_hover", dst = {{x = 817, y = 706, w = 21, h = 23}}, mouseRect = {x = -367, y = -183, w = 344, h = 388}})
end

local function skinThumbnail(parts)
	table.insert(parts.image, {id = "skinThumbnail", src = MAIN.IMAGE.SKINTHUMBNAIL, x = 0, y = 970, w = 687, h = 388})
	table.insert(parts.destination, {id = "skinThumbnail", dst = {{x = 111, y = 523, w = 687, h = 388}}})
end

local function skinName(parts)
	table.insert(parts.destination, {
		id = "t_skinName", dst = {
			{x = 454, y = 460, w = 759, h = 35},
		}
	})
end

local function skinAuthor(parts)
	table.insert(parts.destination, {
		id = "t_skinAuthor", dst = {
			{x = 454, y = 425, w = 759, h = 22},
		}
	})
end

local function slider(parts)
	local base = {x = 1858, y = 423}
	table.insert(parts.image, {id = "slider_flame", src = "system", x = 1450, y = 0, w = 13, h = 644})
	table.insert(parts.slider, {id = "slider_body", src = "system", x = 1463, y = 0, w = 35, h = 72, type = MAIN.SLIDER.SKINSELECT_POSITION, range = 590, angle = 2, changeable = true})
	table.insert(parts.destination, {id = "slider_flame", op = {}, dst = {{x = base.x, y = base.y, w = 13, h = 644}}})
	table.insert(parts.destination, {
		id = "slider_body", dst = {
			{time = 0, x = base.x - 11, y = base.y + 580, w = 35, h = 72, a = 200},
			{time = 1500, a = 255},
			{time = 3000, a = 200}
		}
	})
end

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	CONFIG = require("config")
	-- テキスト関連
	local textProperty = require("SkinSelect.lua.require.textproperty")
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)
	skin.source =  {
		{id = "background", path = "SkinSelect/parts/bg.png"},
		{id = "system", path = "SkinSelect/parts/system.png"}
	}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.image = {}
	skin.imageset = {}
	skin.value = {}
	skin.slider = {}
	skin.destination = {}
--	skin.skinSelect = {}

	background(skin)
	skinMenu(skin)
	playSkin(skin)
	setItems(skin)
	skinSelector(skin)
--	skinThumbnail(skin)
	skinName(skin)
	skinAuthor(skin)
	slider(skin)
	return skin
end

return{
	header = header,
	main = main
}