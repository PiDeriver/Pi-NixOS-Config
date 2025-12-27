--[[
	選曲表示部
	曲名、ジャンル名、BPM、パンくずリスト、ランダムセレクト、BGAありなし
	@author : KASAKO
--]]

local function bpmChange()
	return {MAIN.OP.SONGBAR, MAIN.OP.BPMCHANGE}
end
local function bpmNoChange()
	return {MAIN.OP.SONGBAR, MAIN.OP.NO_BPMCHANGE}
end

-- テキスト関連
local function textDisplay(parts)
	table.insert(parts.destination, {
		id = "directory",  dst = {
			{x = 990, y = 715, w = 890, h = 25, acc = MAIN.ACC.DECELERATE, r = 240, g = 240, b = 240}
		}
	})
	table.insert(parts.destination, {
		id = "genre", loop = 150, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = 980, y = 660, w = 920, h = 30, acc = MAIN.ACC.DECELERATE, r = 255, g = 255, b = 255},
			{time = 150, x = 1000}
		}
	})
	table.insert(parts.destination, {
		id = "title", loop = 150, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = 1000, y = 550, w = 920, h = 70, acc = MAIN.ACC.DECELERATE, r = 216, g = 255, b = 0},
			{time = 150, y = 570},
		}
	})
	table.insert(parts.destination, {
		id = "fullArtist", loop = 150, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = 980, y = 520, w = 920, h = 30, acc = MAIN.ACC.DECELERATE, r = 255, g = 255, b = 255},
			{time = 150, x = 1000}
		}
	})
end
-- インジケータ類
local function indicator(parts)
	-- オンライン状態
	table.insert(parts.image, {id = "offline-now", src = 5, x = 1570, y = 2150, w = 168, h = 40})
	table.insert(parts.image, {id = "online-now", src = 5, x = 1570, y = 2190, w = 168, h = 40})
	table.insert(parts.destination, {
		id = "offline-now", op = {MAIN.OP.OFFLINE}, dst = {
			{x = 486, y = 880, w = 168, h = 40},
		}
	})
	table.insert(parts.destination, {
		id = "online-now", op = {MAIN.OP.ONLINE}, dst = {
			{x = 486, y = 880, w = 168, h = 40},
		}
	})
	-- BGAありなし
	table.insert(parts.image, {id = "bga-notexist", src = 5, x = 1400, y = 2150, w = 168, h = 40})
	table.insert(parts.image, {id = "bga-exist", src = 5, x = 1400, y = 2190, w = 168, h = 40})
	table.insert(parts.destination, {
		id = "bga-notexist", op = {MAIN.OP.NO_BGA}, dst = {
			{x = 659, y = 880, w = 168, h = 40},
		}
	})
	table.insert(parts.destination, {
		id = "bga-exist", op = {MAIN.OP.BGA}, dst = {
			{x = 659, y = 880, w = 168, h = 40},
		}
	})
	-- お気に入り
	table.insert(parts.image, {id = "favinv", src = 5, x = 1232, y = 2150, w = 168, h = 120, divy = 3, len = 3, ref = MAIN.BUTTON.FAVORITTE_CHART, act = MAIN.BUTTON.FAVORITTE_CHART})
	table.insert(parts.destination, {
		id = "favinv", dst = {
			{x = 832, y = 880, w = 168, h = 40},
		}
	})
end
-- 譜面数表示
local function musicNumDisplay(parts)
	table.insert(parts.image, {id = "totalsongs-frame", src = 5, x = 2550, y = 1470, w = 240, h = 50})
	table.insert(parts.value, {id = "folder-totalsongs", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 4, ref = MAIN.NUM.FOLDER_TOTALSONGS})
	table.insert(parts.destination, {
		id = "totalsongs-frame", op = {MAIN.OP.FOLDERBAR}, dst = {
			{x = 630, y = 491, w = 240, h = 50}
		}
	})
	table.insert(parts.destination, {
		id = "folder-totalsongs", dst = {
			{x = 870, y = 498, w = 34, h = 42}
		}
	})
end
-- ランダムセレクト
local function randomSelect(parts)
	table.insert(parts.image, {id = "randomselect-frame", src = 5, x = 1500, y = 2000, w = 610, h = 120})
	table.insert(parts.destination, {
		id = "randomselect-frame", op = {MAIN.OP.RANDOMSELECTBAR}, dst = {
			{x = 400, y = 530, w = 610, h = 120}
		}
	})
end
-- フォルダ内状況
local function statusInTheFolder(parts)
	local posX = 83
	local posY = 240
	local folderStatusRef = {MAIN.NUM.FOLDER_NOPLAY, MAIN.NUM.FOLDER_FAILED, MAIN.NUM.FOLDER_ASSIST, MAIN.NUM.FOLDER_LASSIST, MAIN.NUM.FOLDER_EASY, MAIN.NUM.FOLDER_GROOOVE, MAIN.NUM.FOLDER_HARD, MAIN.NUM.FOLDER_EXHARD, MAIN.NUM.FOLDER_FULLCOMBO, MAIN.NUM.FOLDER_PERFECT, MAIN.NUM.FOLDER_MAX}
	local folderStatusWd = {"Noplay", "Failed", "Assist", "Lassist", "Easy", "Clear", "Hard", "Exhard", "Fullcombo", "Perfect", "Max"}
	local adjustX = {
		740, 525, 340, 155, 15,
		805, 670, 525, 340, 155, 15
	}
	local adjustY = {
		10, 10, 10, 10, 10,
		85, 85, 85, 85, 85, 85
	}
	local bgProperty = {
		x = {649, 487, 282, 120, 2, 779, 649, 487, 282, 120, 2},
		y = {2, 2, 2, 2, 2, 76, 76, 76, 76, 76, 76},
		w = {266, 160, 203, 160, 116, 136, 128, 160, 203, 160, 116},
		r = {120, 130, 200, 100, 100, 100, 200, 255, 160, 255, 255},
		g = {30,  22,  80,  120, 140, 200, 200, 110, 120, 150, 200},
		b = {120, 15,  200, 200, 10,  200, 200, 110, 0,   0,   0}
	}
	table.insert(parts.image, {id = "folderStatusFrame", src = 5, x = 2000, y = 2900, w = 917, h = 150})
	table.insert(parts.image, {id = "folderStatusFC", src = 5, x = 2920, y = 2900, w = 203, h = 105, divy = 3, cycle = 300})
	table.insert(parts.image, {id = "folderStatusEXH", src = 5, x = 2920, y = 3005, w = 160, h = 70, divy = 2, cycle = 200})
	table.insert(parts.destination, {
		id = "folderStatusFrame", op = {MAIN.OP.FOLDERBAR}, dst = {
			{x = posX, y = posY, w = 917, h = 150},
		}
	})
	for i = 1, 11, 1 do
		table.insert(parts.value, {
			id = "folderStatus" ..folderStatusWd[i], src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = folderStatusRef[i]
		})
		table.insert(parts.destination, {
			id = MAIN.IMAGE.WHITE, draw = function()
				return main_state.option(MAIN.OP.FOLDERBAR) and (main_state.number(folderStatusRef[i]) ~= 0)
			end, dst = {
				{x = posX + bgProperty.x[i], y = posY + bgProperty.y[i], w = bgProperty.w[i], h = 35, a = 150, r = bgProperty.r[i], g = bgProperty.g[i], b = bgProperty.b[i]},
			}
		})
		table.insert(parts.destination, {
			id = "folderStatus" ..folderStatusWd[i], draw = function()
				return main_state.option(MAIN.OP.FOLDERBAR) and (main_state.number(folderStatusRef[i]) ~= 0)
			end, dst = {
				{x = posX + adjustX[i], y = posY + adjustY[i], w = 22, h = 15},
			}
		})
	end
	table.insert(parts.destination, {
		id = "folderStatusFC", op = {MAIN.OP.FOLDERBAR}, dst = {
			{x = posX + 282, y = posY + 113, w = 203, h = 35},
		}
	})
	table.insert(parts.destination, {
		id = "folderStatusEXH", op = {MAIN.OP.FOLDERBAR}, dst = {
			{x = posX + 487, y = posY + 113, w = 160, h = 35},
		}
	})
end

-- bpm変化時の表示
local function bpmDisplay1(parts)
	local minPosX = 380
	local whilePosX = 575
	local maxPosX = 650
	-- BPM表示部
	table.insert(parts.destination, {
		id = "bpm-frame", op = bpmChange(), dst = {
			{x = 835, y = 442, w = 180, h = 50},
		}
	})
	table.insert(parts.destination, {
		id = "bpm-while", op = bpmChange(), dst = {
			{x = whilePosX, y = 442, w = 60, h = 50},
		}
	})
	table.insert(parts.destination, {
		id = "minbpm", op = bpmChange(), loop = 200, dst = {
			{time = 200, x = minPosX, y = 442, w = 60, h = 50},
		}
	})
	-- bpmぐるぐる3桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-3", op = bpmChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = minPosX, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
	-- bpmぐるぐる2桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-2", op = bpmChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = minPosX + 60, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
	-- bpmぐるぐる1桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-1", op = bpmChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = minPosX + 120, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
	table.insert(parts.destination, {
		id = "maxbpm", op = bpmChange(), loop = 200, dst = {
			{time = 200, x = maxPosX, y = 442, w = 60, h = 50},
		}
	})
	-- bpmぐるぐる3桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-3", op = bpmChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = maxPosX, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
	-- bpmぐるぐる2桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-2", op = bpmChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = maxPosX + 60, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
	-- bpmぐるぐる1桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-1", op = bpmChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = maxPosX + 120, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
end

-- bpm変化がない場合の表示
local function bpmDisplay2(parts)
	local numPosX = 650
	-- BPM変化無し
	table.insert(parts.destination, {
		id = "bpm-frame", op = bpmNoChange(), dst = {
			{x = 835, y = 442, w = 180, h = 50},
		}
	})
	table.insert(parts.destination, {
		id = "maxbpm", op = bpmNoChange(), loop = 200, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 200, x = numPosX, y = 442, w = 60, h = 50}
		}
	})
	-- bpmぐるぐる3桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-3", op = bpmNoChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = numPosX, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
	-- bpmぐるぐる2桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-2", op = bpmNoChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = numPosX + 60, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
	-- bpmぐるぐる1桁目
	table.insert(parts.destination, {
		id = "bpm-roulette-1", op = bpmNoChange(), loop = -1, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
			{time = 0, x = numPosX + 120, y = 442, w = 60, h = 50},
			{time = 199}
		}
	})
end

local function load()
	local parts = {}
	
	parts.image = {
		{id = "bpm-while", src = 5, x = 1860, y = 1240, w = 60, h = 50},
		{id = "bpm-frame", src = 5, x = 1500, y = 1240, w = 180, h = 50},
		{id = "bpm-roulette-1", src = 5, x = 1500, y = 1290, w = 600, h = 40, divx = 10, cycle = 50},
		{id = "bpm-roulette-2", src = 5, x = 1500, y = 1290, w = 600, h = 40, divx = 10, cycle = 100},
		{id = "bpm-roulette-3", src = 5, x = 1500, y = 1290, w = 600, h = 40, divx = 10, cycle = 150},
		{id = "bpm-roulette-4", src = 5, x = 1500, y = 1290, w = 600, h = 40, divx = 10, cycle = 200},
		-- 判定レベル
		{id = "md-judge-veryeasy", src = 5, x = 1740, y = 2150, w = 168, h = 40},
		{id = "md-judge-easy", src = 5, x = 1740, y = 2190, w = 168, h = 40},
		{id = "md-judge-normal", src = 5, x = 1740, y = 2230, w = 168, h = 40},
		{id = "md-judge-hard", src = 5, x = 1740, y = 2270, w = 168, h = 40},
		{id = "md-judge-veryhard", src = 5, x = 1740, y = 2310, w = 168, h = 40},
	}
	
	parts.value = {
		-- MAXBPM
		{id = "maxbpm", src = 5, x = 1500, y = 1290, w = 600, h = 40, divx = 10, digit = 3, ref = MAIN.NUM.MAXBPM},
		-- MINBPM
		{id = "minbpm", src = 5, x = 1500, y = 1290, w = 600, h = 40, divx = 10, digit = 3, ref = MAIN.NUM.MINBPM, align = 0},
	}

	parts.destination = {}
	textDisplay(parts)
	bpmDisplay1(parts)
	bpmDisplay2(parts)
	musicNumDisplay(parts)
	statusInTheFolder(parts)
	randomSelect(parts)
	indicator(parts)
	return parts
end

return {
	load = load
}