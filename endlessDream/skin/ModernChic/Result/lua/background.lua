--[[
	背景表示
	@author : KASAKO
]]
local CHOICEFUNC = require("Result.lua.require.listchoice")

local function createColorNum()
	local red
	local green
	local blue
	if main_state.option(MAIN.OP.RESULT_CLEAR) then
		-- clear
		red = math.random(50, 100)
		green = math.random(50, 100)
		blue = math.random(150, 255)
	elseif main_state.option(MAIN.OP.RESULT_FAIL) then
		-- failed
		red = math.random(150, 255)
		green = math.random(50, 100)
		blue = math.random(50, 100)
	end
	return {red, green, blue}
end

local function backgroundClearFailed(parts)
	local wd = {"bgClear", "bgFailed"}
	local info = {
		partsFolder = {
			"Result/parts/bg/isclear/clear/",
			"Result/parts/bg/isclear/failed/"
		},
		logFolder = "io/Result/bg/isclear/",
		path = {"clear","failed"},
		op = {MAIN.OP.RESULT_CLEAR, MAIN.OP.RESULT_FAIL}
	}
	for i = 1, #wd, 1 do
		if PROPERTY.isbgRotationSwitchOff() then
			table.insert(parts.source, {id = wd[i], path = info.partsFolder[i] .."*.png"})
		elseif PROPERTY.isbgRotationSwitchOn() then
			table.insert(parts.source, {id = wd[i], path = CHOICEFUNC.backgroundRandomChoice(info, i)})
		end
		table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
		table.insert(parts.destination, {
			id = wd[i], op = {info.op[i]}, dst = {
				{x = 0, y = 0, w = 1920, h = 1080},
			}
		})
	end
end
local function backgroundAll(parts)
	local info = {
		partsFolder = {"Result/parts/bg/all/"},
		logFolder = "io/Result/bg/all/",
		path = {"all"},
		op = {0}
	}
	if PROPERTY.isbgRotationSwitchOff() then
		table.insert(parts.source, {id = 10, path = "Result/parts/bg/all/*.png"})
	elseif PROPERTY.isbgRotationSwitchOn() then
		table.insert(parts.source, {id = 10, path = CHOICEFUNC.backgroundRandomChoice(info, 1)})
	end
	table.insert(parts.image, {id = "bgAll", src = 10, x = 0, y = 0, w = 1920, h = 1080})
	table.insert(parts.destination, {
		id = "bgAll", dst = {
			{x = 0, y = 0, w = 1920, h = 1080},
		}
	})
end
local function backgroundRank(parts)
	local wd = {"bgRankAAA", "bgRankAA", "bgRankA", "bgRankB", "bgRankC", "bgRankD", "bgRankE", "bgRankF"}
	local info = {
		partsFolder = {
			"Result/parts/bg/rank/AAA/",
			"Result/parts/bg/rank/AA/",
			"Result/parts/bg/rank/A/",
			"Result/parts/bg/rank/B/",
			"Result/parts/bg/rank/C/",
			"Result/parts/bg/rank/D/",
			"Result/parts/bg/rank/E/",
			"Result/parts/bg/rank/F/",
		},
		logFolder = "io/Result/bg/rank/",
		path = {"AAA", "AA", "A", "B", "C", "D", "E", "F"},
		op = {MAIN.OP.RESULT_AAA_1P,MAIN.OP.RESULT_AA_1P, MAIN.OP.RESULT_A_1P, MAIN.OP.RESULT_B_1P, MAIN.OP.RESULT_C_1P, MAIN.OP.RESULT_D_1P, MAIN.OP.RESULT_E_1P, MAIN.OP.RESULT_F_1P}
	}
	for i = 1, #wd, 1 do
		if PROPERTY.isbgRotationSwitchOff() then
			table.insert(parts.source, {id = wd[i], path = info.partsFolder[i] .."*.png"})
		elseif PROPERTY.isbgRotationSwitchOn() then
			table.insert(parts.source, {id = wd[i], path = CHOICEFUNC.backgroundRandomChoice(info, i)})
		end
		table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
		table.insert(parts.destination, {
			id = wd[i], op = {info.op[i]}, dst = {
				{x = 0, y = 0, w = 1920, h = 1080},
			}
		})
	end
end
local function backgroundClearType(parts)
	local wd = {"bgFailed2", "bgAssist", "bgLaAssist", "bgEasy", "bgNormal", "bgHard", "bgExhard", "bgFullCombo", "bgPerfect", "bgMax"}
	local info = {
		partsFolder = {
			"Result/parts/bg/clearType/failed/",
			"Result/parts/bg/clearType/assist/",
			"Result/parts/bg/clearType/laassist/",
			"Result/parts/bg/clearType/easy/",
			"Result/parts/bg/clearType/normal/",
			"Result/parts/bg/clearType/hard/",
			"Result/parts/bg/clearType/exhard/",
			"Result/parts/bg/clearType/fullcombo/",
			"Result/parts/bg/clearType/perfect/",
			"Result/parts/bg/clearType/max/"
		},
		logFolder = "io/Result/bg/clearType/",
		path = {"failed", "assist", "laassist", "easy", "normal", "hard", "exhard", "fullcombo", "perfect", "max"},
		op = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	}
	for i = 1, #wd, 1 do
		if PROPERTY.isbgRotationSwitchOff() then
			table.insert(parts.source, {id = wd[i], path = info.partsFolder[i] .."*.png"})
		elseif PROPERTY.isbgRotationSwitchOn() then
			table.insert(parts.source, {id = wd[i], path = CHOICEFUNC.backgroundRandomChoice(info, i)})
		end
		table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
	end
	table.insert(parts.imageset,{
		id = "bgClearType", ref = MAIN.NUM.CLEAR, images = {"bgNormal", "bgFailed2", "bgAssist", "bgLaAssist", "bgEasy", "bgNormal", "bgHard", "bgExhard", "bgFullCombo", "bgPerfect", "bgMax"}
	})
	table.insert(parts.destination, {
		id = "bgClearType", dst = {
			{x = 0, y = 0, w = 1920, h = 1080},
		}
	})
end
-- 背景
local function background(parts)
	if PROPERTY.isBackgroundClearFailed() then
		backgroundClearFailed(parts)
	elseif PROPERTY.isBackgroundAll() then
		backgroundAll(parts)
	elseif PROPERTY.isBackgroundRank() then
		backgroundRank(parts)
	elseif PROPERTY.isBackgroundClearType() then
		-- コース通過時のリザルトでClearTypeにしていた場合はisBackgroundClearFailedの挙動に
		if CUSTOM.OP.isCourse() then
			backgroundClearFailed(parts)
		else
			backgroundClearType(parts)
		end
	end
	-- 背景用明るさ調整
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, offsets = {PROPERTY.offsetBgBrightness.num}, dst = {
			{x = 0, y = 0, w = 1920, h = 1080, a = 0},
		}
	})
end

local function charClearFailed(parts, animationTime)
	local wd = {"charClear", "charFailed"}
	local info = {
		partsFolder = {
			"Result/parts/char/isclear/clear/",
			"Result/parts/char/isclear/failed/"
		},
		logFolder = "io/Result/char/isclear/",
		path = {"clear","failed"},
		op = {MAIN.OP.RESULT_CLEAR, MAIN.OP.RESULT_FAIL}
	}
	for i = 1, #wd, 1 do
		if PROPERTY.ischarRotationSwitchOff() then
			table.insert(parts.source, {id = wd[i], path = info.partsFolder[i] .."*.png"})
		elseif PROPERTY.ischarRotationSwitchOn() then
			-- パーツ場所、ログ出力先、識別文字、オプション、番号
			table.insert(parts.source, {id = wd[i], path = CHOICEFUNC.charctorRandomChoice(info, i)})
		end
		table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
		table.insert(parts.destination, {
			id = wd[i], draw = function()
				return main_state.option(info.op[i]) and CUSTOM.OP.isCharDisplayOn
			end, loop = animationTime, offsets = {PROPERTY.offsetCharPosition.num}, dst = {
				{time = 0, x = - (1920 / 2), y = - (1080 / 2), w = 1920 * 2, h = 1080 * 2},
				{time = animationTime, x = 0, y = 0, w = 1920, h = 1080}
			}
		})
	end
end
local function charAll(parts, animationTime)
	local info = {
		partsFolder = {"Result/parts/char/all/"},
		logFolder = "io/Result/char/all/",
		path = {"all"},
		op = {0}
	}
	if PROPERTY.ischarRotationSwitchOff() then
		table.insert(parts.source, {id = "charAll", path = "Result/parts/char/all/*.png"})
	elseif PROPERTY.ischarRotationSwitchOn() then
		-- パーツ場所、オプション、番号
		table.insert(parts.source, {id = "charAll", path = CHOICEFUNC.charctorRandomChoice(info, 1)})
	end
	table.insert(parts.image, {id = "charAll", src = "charAll", x = 0, y = 0, w = 1920, h = 1080})
	table.insert(parts.destination, {
		id = "charAll", loop = animationTime, offsets = {PROPERTY.offsetCharPosition.num}, draw = function()
			return CUSTOM.OP.isCharDisplayOn
		end, dst = {
			{time = 0, x = - (1920 / 2), y = - (1080 / 2), w = 1920 * 2, h = 1080 * 2},
			{time = animationTime, x = 0, y = 0, w = 1920, h = 1080}
		}
	})
end
local function charRank(parts, animationTime)
	local wd = {"charRankAAA", "charRankAA", "charRankA", "charRankB", "charRankC", "charRankD", "charRankE", "charRankF"}
	local info = {
		partsFolder = {
			"Result/parts/char/rank/AAA/",
			"Result/parts/char/rank/AA/",
			"Result/parts/char/rank/A/",
			"Result/parts/char/rank/B/",
			"Result/parts/char/rank/C/",
			"Result/parts/char/rank/D/",
			"Result/parts/char/rank/E/",
			"Result/parts/char/rank/F/",
		},
		logFolder = "io/Result/char/rank/",
		path = {"AAA", "AA", "A", "B", "C", "D", "E", "F"},
		op = {MAIN.OP.RESULT_AAA_1P,MAIN.OP.RESULT_AA_1P, MAIN.OP.RESULT_A_1P, MAIN.OP.RESULT_B_1P, MAIN.OP.RESULT_C_1P, MAIN.OP.RESULT_D_1P, MAIN.OP.RESULT_E_1P, MAIN.OP.RESULT_F_1P}
	}
	for i = 1, #wd, 1 do
		if PROPERTY.ischarRotationSwitchOff() then
			table.insert(parts.source, {id = wd[i], path = info.partsFolder[i] .."*.png"})
		elseif PROPERTY.ischarRotationSwitchOn() then
			-- パーツ場所、オプション、番号
			table.insert(parts.source, {id = wd[i], path = CHOICEFUNC.charctorRandomChoice(info, i)})
		end
		table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
		table.insert(parts.destination, {
			id = wd[i], draw = function()
				return main_state.option(info.op[i]) and CUSTOM.OP.isCharDisplayOn
			end, loop = animationTime, offsets = {PROPERTY.offsetCharPosition.num}, dst = {
				{time = 0, x = - (1920 / 2), y = - (1080 / 2), w = 1920 * 2, h = 1080 * 2},
				{time = animationTime, x = 0, y = 0, w = 1920, h = 1080}
			}
		})
	end
end
local function charClearType(parts, animationTime)
	local wd = {"charFailed2", "charAssist", "charLaAssist", "charEasy", "charNormal", "charHard", "charExhard", "charFullCombo", "charPerfect", "charMax"}
	local info = {
		partsFolder = {
			"Result/parts/char/clearType/failed/",
			"Result/parts/char/clearType/assist/",
			"Result/parts/char/clearType/laassist/",
			"Result/parts/char/clearType/easy/",
			"Result/parts/char/clearType/normal/",
			"Result/parts/char/clearType/hard/",
			"Result/parts/char/clearType/exhard/",
			"Result/parts/char/clearType/fullcombo/",
			"Result/parts/char/clearType/perfect/",
			"Result/parts/char/clearType/max/"
		},
		logFolder = "io/Result/char/clearType/",
		path = {"failed", "assist", "laassist", "easy", "normal", "hard", "exhard", "fullcombo", "perfect", "max"},
		op = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	}
	for i = 1, #wd, 1 do
		if PROPERTY.ischarRotationSwitchOff() then
			table.insert(parts.source, {id = wd[i], path = info.partsFolder[i] .."*.png"})
		elseif PROPERTY.ischarRotationSwitchOn() then
			-- パーツ場所、オプション、番号
			table.insert(parts.source, {id = wd[i], path = CHOICEFUNC.charctorRandomChoice(info, i)})
		end
		table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
	end
	table.insert(parts.imageset,{
		id = "charClearType", ref = MAIN.NUM.CLEAR, images = {"charNormal", "charFailed2", "charAssist", "charLaAssist", "charEasy", "charNormal", "charHard", "charExhard", "charFullCombo", "charPerfect", "charMax"}
	})
	table.insert(parts.destination, {
		id = "charClearType", loop = animationTime, offsets = {PROPERTY.offsetCharPosition.num}, draw = function()
			return CUSTOM.OP.isCharDisplayOn
		end, dst = {
			{time = 0, x = - (1920 / 2), y = - (1080 / 2), w = 1920 * 2, h = 1080 * 2},
			{time = animationTime, x = 0, y = 0, w = 1920, h = 1080}
		}
	})
end
-- 重ね絵機能
local function layerdPicture(parts)
	if PROPERTY.isCharOn() then
		local animationTime = 200
		if PROPERTY.isCharClearFailed() then
			charClearFailed(parts, animationTime)
		elseif PROPERTY.isCharAll() then
			charAll(parts, animationTime)
		elseif PROPERTY.isCharRank() then
			charRank(parts, animationTime)
		elseif PROPERTY.isCharClearType() then
			-- コース通過時のリザルトでClearTypeにしていた場合はisBackgroundClearFailedの挙動に
			if CUSTOM.OP.isCourse() then
				charClearFailed(parts, animationTime)
			else
				charClearType(parts, animationTime)
			end
		end
	end
end
-- 修飾
local function modification(parts)
	table.insert(parts.image, {id = "ring", src = 0, x = 0, y = 0, w = 1920, h = 1080})
	table.insert(parts.image, {id = "beam", src = 2, x = 0, y = 1778, w = 960, h = 30})
	if PROPERTY.isRingOn() then
		table.insert(parts.destination, {
			id = "ring", blend = MAIN.BLEND.ADDITION, dst = {
				{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 30},
				{time = 20000, angle = 360},
			}
		})
	end
	if PROPERTY.isBeamOn() then
		local rgb = createColorNum()
		table.insert(parts.destination, {
			id = "beam", blend = MAIN.BLEND.ADDITION, dst = {
				{time = 0, x = 0, y = 0, w = 1920, h = 30, r = rgb[1], g = rgb[2], b = rgb[3], a = 200},
				{time = 5000, y = 1080 / 2, a = 0},
				{time = 6500}
			}
		})
	end
end

local function load()
	local parts = {}
	parts.source = {}
	parts.image = {}
	parts.imageset = {}
	parts.destination = {}
	background(parts)
	modification(parts)
	layerdPicture(parts)
	return parts
end

return {
	load = load
}