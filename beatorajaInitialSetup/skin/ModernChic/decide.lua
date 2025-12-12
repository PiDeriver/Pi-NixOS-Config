--[[
	曲決定画面
	@author : KASAKO
	blog: https://www.kasacontent.com/tag/modernchic/
]]
-- DEBUG = true
-- モジュール読み込み
main_state = require("main_state")
PROPERTY = require("Decide.lua.require.property")
local header = require("Decide.lua.require.header")

-- 背景
local function background(skin)
	if PROPERTY.isBgImage() then
		table.insert(skin.image, {id = "bg", src = 1, x = 0, y = 0, w = 1920, h = 1080})
	else
		table.insert(skin.image, {id = "bg", src = 2, x = 0, y = 0, w = 1920, h = 1080})
	end
	-- 背景配置
	table.insert(skin.destination,{
		id = "bg", dst = {
			{x = 0, y = 0, w = 1920, h = 1080}
		}
	})
	-- ステージファイル
	if PROPERTY.isStagefileOn() then
		table.insert(skin.destination,	{
			id = MAIN.IMAGE.STAGEFILE, loop = 1500, dst = {
				{time = 500, x = 910, y = 490, w = 1, h = 1},
				{time = 1500, x = 640, y = 300, w = 640, h = 480},
			}
		})
	end
	-- 表示用背景
	table.insert(skin.destination,	{
		id = MAIN.IMAGE.BLACK, loop = 500, dst = {
			{time = 0, x = 960, y = 585, w = 1, h = 1, a = 200},
			{time = 500, x = 0, y = 200, w = 1920, h = 680}
		}
	})
end

local function lockonAnimation(skin)
	local num1 = CUSTOM.NUM.randNum(0, 255)
	local num2 = CUSTOM.NUM.randNum(0, 255)
	local num3 = CUSTOM.NUM.randNum(0, 255)
	local preWH = 500
	local startTime = 0
	local loopTime = 1000
	local alphaNum = 30
	local accNum = MAIN.ACC.ACCELERATION
	local RGB = CUSTOM.NUM.diffRGB()
	table.insert(skin.image, {id = "lockon-lu", src = 4, x = 0, y = 50, w = 50, h = 50})
	table.insert(skin.image, {id = "lockon-ru", src = 4, x = 60, y = 50, w = 50, h = 50})
	table.insert(skin.image, {id = "lockon-ld", src = 4, x = 120, y = 50, w = 50, h = 50})
	table.insert(skin.image, {id = "lockon-rd", src = 4, x = 180, y = 50, w = 50, h = 50})
	for i = 1, 5, 1 do
		table.insert(skin.destination, {
			id = "lockon-lu", loop = loopTime, dst = {
				{time = startTime, x = 0, y = 1080 - preWH, w = preWH, h = preWH, acc = accNum, a = alphaNum, r = num1, g = num2, b = num3},
				{time = loopTime, x = 627, y = 743, w = 50, h = 50, a = 255, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = loopTime + 100, a = 0}
			}
		})
		table.insert(skin.destination, {
			id = "lockon-ru", loop = loopTime, dst = {
				{time = startTime, x = 1920 - preWH, y = 1080 - preWH, w = preWH, h = preWH, acc = accNum, a = alphaNum, r = num1, g = num2, b = num3},
				{time = loopTime, x = 1243, y = 743, w = 50, h = 50, a = 255, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = loopTime + 100, a = 0}
			}
		})
		table.insert(skin.destination, {
			id = "lockon-ld", loop = loopTime, dst = {
				{time = startTime, x = 0, y = 0, w = preWH, h = preWH, acc = accNum, a = alphaNum, r = num1, g = num2, b = num3},
				{time = loopTime, x = 627, y = 288, w = 50, h = 50, a = 255, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = loopTime + 100, a = 0}
			}
		})
		table.insert(skin.destination, {
			id = "lockon-rd", loop = loopTime, dst = {
				{time = startTime, x = 1920 - preWH, y = 0, w = preWH, h = preWH, acc = accNum, a = alphaNum, r = num1, g = num2, b = num3},
				{time = loopTime, x = 1243, y = 288, w = 50, h = 50, a = 255, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = loopTime + 100, a = 0}
			}
		})
		startTime = startTime + 200
		loopTime = loopTime + 100
	end
end
-- ノート分布グラフ
local function notesGraph(skin)
	if PROPERTY.isNotesGraphOn() then
		local graphWidth = 1000
		local graphHeight = 150
		table.insert(skin.judgegraph, {id = "notes-graph", noGap = 0, type = 0})
		table.insert(skin.bpmgraph, {id = "bpmgraph"})
		table.insert(skin.destination, {
			id = "notes-graph", dst = {
				{x = (1920 / 2) - (graphWidth / 2), y = 30, w = graphWidth, h = graphHeight},
			}
		})
		table.insert(skin.destination, {
			id = "bpmgraph", dst = {
				{x = (1920 / 2) - (graphWidth / 2), y = 30, w = graphWidth, h = graphHeight},
			}
		})
	end
end
-- 黒背景でフェードアウト
local function fadeout(skin)
	table.insert(skin.image, {id = "getready", src = 4, x = 0, y = 0, w = 730, h = 50})
	table.insert(skin.destination, {
		id = MAIN.IMAGE.BLACK, loop = 1000, timer = MAIN.TIMER.FADEOUT, dst = {
			{time = 0, x = 0, y = 540, w = 1920, h = 0},
			{time = 500},
			{time = 1000, y = 0, h = 1080},
		}
	})
	table.insert(skin.destination, {
		id = "getready", loop = 1000, timer = MAIN.TIMER.FADEOUT, dst = {
			{time = 500, x = 598, y = 514, w = 730, h = 50},
			{time = 600, a = 0},
			{time = 700, a = 255},
			{time = 800, a = 0},
			{time = 850, a = 255},
			{time = 900, a = 0},
			{time = 950, a = 255},
		}
	})
end
-- テキスト関連
local function text(skin)
	local tableName = {posX = 960, posY = 815}
	local stage = {posX = 960, posY = 700}
	local genre = {posX = 960, posY = 610}
	local title = {posX = 960, posY = 490}
	local artist = {posX = 960, posY = 430}
	local category = {posX = 840, posY = 370}
	local level = {posX = 890, posY = 270}
	local tips = {posX = 960, posY = 220}
	local pt = {loopTime = 500, initAlfa = 0, afterAlfa = 255}
	local option = {MAIN.OP.DIFFICULTY1, MAIN.OP.DIFFICULTY2, MAIN.OP.DIFFICULTY3, MAIN.OP.DIFFICULTY4, MAIN.OP.DIFFICULTY5, MAIN.OP.DIFFICULTY0}
	local cat = {"beginner", "normal", "hyper", "another", "insane", "unknown"}
	local lev = {"levelBeginner", "levelNormal", "levelHyper", "levelAnother", "levelInsane", "levelUnknown"}
	local RGB = CUSTOM.NUM.diffRGB()

	table.insert(skin.image, {id = "beginner", src = 3, x = 0, y = 558, w = 240, h = 45})
	table.insert(skin.image, {id = "normal", src = 3, x = 0, y = 603, w = 240, h = 45})
	table.insert(skin.image, {id = "hyper", src = 3, x = 0, y = 648, w = 240, h = 45})
	table.insert(skin.image, {id = "another", src = 3, x = 0, y = 693, w = 240, h = 45})
	table.insert(skin.image, {id = "insane", src = 3, x = 0, y = 738, w = 240, h = 45})
	table.insert(skin.image, {id = "unknown", src = 3, x = 0, y = 783, w = 240, h = 45})

	table.insert(skin.value, {id = "levelBeginner", src = 3, x = 0, y = 0, w = 710, h = 93, divx = 10, digit = 2, align = MAIN.N_ALIGN.CENTER, ref = MAIN.NUM.PLAYLEVEL})
	table.insert(skin.value, {id = "levelNormal", src = 3, x = 0, y = 93, w = 710, h = 93, divx = 10, digit = 2, align = MAIN.N_ALIGN.CENTER, ref = MAIN.NUM.PLAYLEVEL})
	table.insert(skin.value, {id = "levelHyper", src = 3, x = 0, y = 186, w = 710, h = 93, divx = 10, digit = 2, align = MAIN.N_ALIGN.CENTER, ref = MAIN.NUM.PLAYLEVEL})
	table.insert(skin.value, {id = "levelAnother", src = 3, x = 0, y = 279, w = 710, h = 93, divx = 10, digit = 2, align = MAIN.N_ALIGN.CENTER, ref = MAIN.NUM.PLAYLEVEL})
	table.insert(skin.value, {id = "levelInsane", src = 3, x = 0, y = 372, w = 710, h = 93, divx = 10, digit = 2, align = MAIN.N_ALIGN.CENTER, ref = MAIN.NUM.PLAYLEVEL})
	table.insert(skin.value, {id = "levelUnknown", src = 3, x = 0, y = 465, w = 710, h = 93, divx = 10, digit = 2, align = MAIN.N_ALIGN.CENTER,ref = MAIN.NUM.PLAYLEVEL})

	for i = 1, 6, 1 do
		-- ステージ数
		if PROPERTY.isviewStageOn() then
			table.insert(skin.destination, {
				id = "stage", op = {option[i]}, loop = pt.loopTime, dst = {
					{time = 0, a = pt.initAlfa, x = stage.posX, y = stage.posY + 10, w = 1720, h = 50, r = RGB[1], g = RGB[2], b = RGB[3]},
					{time = pt.loopTime, a = pt.afterAlfa, y = stage.posY}
				}
			})
		end
		-- テーブル名
		table.insert(skin.destination, {
			id = "tablename&tablelevel", op = {option[i]}, loop = pt.loopTime, dst = {
				{time = 0, a = pt.initAlfa, x = tableName.posX, y = tableName.posY, w = 1720, h = 35, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = pt.loopTime, a = pt.afterAlfa}
			}
		})
		-- ジャンル名
		table.insert(skin.destination, {
			id = "genre", op = {option[i]}, loop = pt.loopTime, dst = {
				{time = 0, a = pt.initAlfa, x = genre.posX, y = genre.posY, w = 1720, h = 40},
				{time = pt.loopTime, a = pt.afterAlfa}
			}
		})
		-- タイトル
		table.insert(skin.destination, {
			id = "title", op = {option[i]}, loop = pt.loopTime, dst = {
				{time = 0, a = pt.initAlfa, x = title.posX, y = title.posY, w = 1720, h = 90, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = pt.loopTime, a = pt.afterAlfa}
			}
		})
		-- アーティスト
		table.insert(skin.destination, {
			id = "artist", op = {option[i]}, loop = pt.loopTime, dst = {
				{time = 0, a = pt.initAlfa, x = artist.posX, y = artist.posY, w = 1720, h = 40},
				{time = pt.loopTime, a = pt.afterAlfa}
			}
		})
		-- カテゴリ
		table.insert(skin.destination, {
			id = cat[i], op = {option[i]}, loop = pt.loopTime, dst = {
				{time = 0, a = pt.initAlfa, x = category.posX, y = category.posY, w = 240, h = 45},
				{time = pt.loopTime, a = pt.afterAlfa}
			}
		})
		-- レベル
		table.insert(skin.destination, {
			id = lev[i], op = {option[i]}, loop = pt.loopTime, dst = {
				{time = 0, a = pt.initAlfa, x = level.posX, y = level.posY, w = 71, h = 93},
				{time = pt.loopTime, a = pt.afterAlfa}
			}
		})
		-- お役立ち情報
		if PROPERTY.isviewTipsOn() then
			table.insert(skin.destination, {
				id = "tips", op = {option[i]}, loop = pt.loopTime, dst = {
					{time = 0, a = pt.initAlfa, x = tips.posX, y = tips.posY, w = 1720, h = 25, r = 150, g = 150, b = 150},
					{time = pt.loopTime, a = pt.afterAlfa}
				}
			})
		end
	end
end

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	CONFIG = require("config")
	-- テキスト関連
	local textProperty = require("Decide.lua.require.textproperty")
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)
	skin.source =  {
		{id = 1, path = "Decide/bg/image/*.png"},
		{id = 2, path = "Decide/bg/movie/*.mp4"},
		{id = 3, path = "Decide/parts/parts.png"},
		{id = 4, path = "Decide/parts/parts2.png"},
	}
	-- フォント
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.image = {}
	skin.value = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.destination = {}
	background(skin)
	lockonAnimation(skin)
	text(skin)
	notesGraph(skin)
	fadeout(skin)
	return skin
end

return{
	header = header,
	main = main
}