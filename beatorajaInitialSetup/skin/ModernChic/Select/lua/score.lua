--[[
	選択した曲のスコアとランクを表示
	@author : KASAKO
--]]
local window = {posX = 454, posY = 10}

-- タイミンググラフ
local function timingGraph(parts)
	table.insert(parts.image, {id = "score-timingFrame", src = 8, x = 1200, y = 640, w = 186, h = 60})
	table.insert(parts.graph, {id = "bar-slowRate", src = 8, x = 1200, y = 734, w = 180, h = 34, angle = MAIN.G_ANGLE.RIGHT, value = function() return CUSTOM.GRAPH.SlowRate() end})
	table.insert(parts.graph, {id = "bar-fastRate", src = 8, x = 1200, y = 700, w = 180, h = 34, angle = MAIN.G_ANGLE.RIGHT, value = function() return CUSTOM.GRAPH.FastRate() end})
	table.insert(parts.value, {id = "fastcount", src = 8, x = 900, y = 640, w = 253, h = 30, divx = 11, digit = 4, ref = MAIN.NUM.TOTALEARLY})
	table.insert(parts.value, {id = "slowcount", src = 8, x = 900, y = 670, w = 253, h = 30, divx = 11, digit = 4, ref = MAIN.NUM.TOTALLATE})
	table.insert(parts.destination, {
		id = "score-timingFrame", dst = {
			{x = window.posX + 510, y = window.posY + 47, w = 186, h = 60},
		}
	})
	table.insert(parts.destination, {
		id = "bar-slowRate", blend = MAIN.BLEND.ADDITION, dst = {
			{x = window.posX + 513, y = window.posY + 70, w = 180, h = 34},
		}
	})
	table.insert(parts.destination, {
		id = "bar-fastRate", blend = MAIN.BLEND.ADDITION, dst = {
			{x = window.posX + 693, y = window.posY + 70, w = -180, h = 34},
		}
	})
	table.insert(parts.destination, {
		id = "fastcount", dst = {
			{x = window.posX + 615, y = window.posY + 72, w = 18, h = 30},
		}
	})
	table.insert(parts.destination, {
		id = "slowcount", dst = {
			{x = window.posX + 520, y = window.posY + 72, w = 18, h = 30},
		}
	})
end
-- ランク表示
local function displayRank(parts)
	local wd = {"aaa", "aa", "a", "b", "c", "d", "e", "f"}
	local op = {MAIN.OP.AAA_1P, MAIN.OP.AA_1P, MAIN.OP.A_1P, MAIN.OP.B_1P, MAIN.OP.C_1P, MAIN.OP.D_1P, MAIN.OP.E_1P, MAIN.OP.F_1P}
	local posY = 511
	for i = 1, 8, 1 do
		table.insert(parts.image, {id = "rank-" ..wd[i], src = 8, x = 1421, y = posY, w = 187, h = 73})
		posY = posY - 73
	end
	for i = 1, 8, 1 do
		table.insert(parts.destination, {
			id = "rank-" ..wd[i], op = {op[i], -MAIN.OP.SELECT_BAR_NOT_PLAYED}, loop = 300, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
				{time = 0, x = window.posX + 706, y = window.posY + 69, w = 187, h = 73, a = 0},
				{time = 300, y = window.posY + 59, a = 255}
			}
		})
	end
end
-- ランクバー
local function rankBar(parts)
	table.insert(parts.image, {id = "score-bar", src = 8, x = 0, y = 210, w = 696, h = 40})
	table.insert(parts.image, {id = "score-bar-info", src = 8, x = 0, y = 250, w = 696, h = 40})
	table.insert(parts.destination, {
		id = "score-bar", dst = {
			{x = window.posX + 6, y = window.posY + 7, w = 696, h = 40},
		}
	})
	local wd = {"failed", "laassist", "clear", "easy", "fullcombo", "hard", "exhard", "perfect", "max", "assist"}
	local op = {MAIN.OP.SELECT_BAR_FAILED, MAIN.OP.SELECT_BAR_LIGHT_ASSIST_EASY_CLEARED, MAIN.OP.SELECT_BAR_NORMAL_CLEARED, MAIN.OP.SELECT_BAR_EASY_CLEARED, MAIN.OP.SELECT_BAR_FULL_COMBO_CLEARED, MAIN.OP.SELECT_BAR_HARD_CLEARED, MAIN.OP.SELECT_BAR_EXHARD_CLEARED, MAIN.OP.SELECT_BAR_PERFECT_CLEARED, MAIN.OP.SELECT_BAR_MAX_CLEARED, MAIN.OP.SELECT_BAR_ASSIST_EASY_CLEARED}
	do
		local posY = 293
		for i = 1, 10, 1 do
			table.insert(parts.graph, {id = "bar-exscore-" ..wd[i], src = 8, x = 0, y = posY, w = 690, h = 33, value = MAIN.GRAPH.RATE_EXSCORE, angle = MAIN.G_ANGLE.RIGHT})
			posY = posY + 33
		end
	end
	for i = 1, 10, 1 do
		table.insert(parts.destination, {
			id = "bar-exscore-" ..wd[i], timer = MAIN.TIMER.SONGBAR_CHANGE, loop = 300, op = {op[i]}, dst = {
				{time = 0, x = window.posX + 9, y = window.posY + 10, w = 0, h = 33, acc = MAIN.ACC.DECELERATE},
				{time = 300, w = 690}
			}
		})
	end
	table.insert(parts.destination, {
		id = "score-bar-info", dst = {
			{x = window.posX + 6, y = window.posY + 7, w = 696, h = 40},
		}
	})
end
-- クリア状況
local function clearType(parts)
	table.insert(parts.image, {id = "sel-bar-notplayed", src = 8, x = 1234, y = 260, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-failed", src = 8, x = 1234, y = 293, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-laassist", src = 8, x = 1234, y = 326, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-clear", src = 8, x = 1234, y = 359, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-easyclear", src = 8, x = 1234, y = 392, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-fullcombo", src = 8, x = 860, y = 425, w = 561, h = 33, divx = 3, cycle = 100})
	table.insert(parts.image, {id = "sel-bar-hardclear", src = 8, x = 1234, y = 458, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-exhardclear", src = 8, x = 1047, y = 491, w = 374, h = 33, divx = 2, cycle = 100})
	table.insert(parts.image, {id = "sel-bar-perfect", src = 8, x = 1234, y = 524, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-max", src = 8, x = 1234, y = 557, w = 187, h = 33})
	table.insert(parts.image, {id = "sel-bar-assist", src = 8, x = 1234, y = 590, w = 187, h = 33})
	local wd = {"notplayed" ,"failed", "laassist", "clear", "easyclear", "fullcombo", "hardclear", "exhardclear", "perfect", "max", "assist"}
	local op = {MAIN.OP.SELECT_BAR_NOT_PLAYED, MAIN.OP.SELECT_BAR_FAILED, MAIN.OP.SELECT_BAR_LIGHT_ASSIST_EASY_CLEARED, MAIN.OP.SELECT_BAR_NORMAL_CLEARED, MAIN.OP.SELECT_BAR_EASY_CLEARED, MAIN.OP.SELECT_BAR_FULL_COMBO_CLEARED, MAIN.OP.SELECT_BAR_HARD_CLEARED, MAIN.OP.SELECT_BAR_EXHARD_CLEARED, MAIN.OP.SELECT_BAR_PERFECT_CLEARED, MAIN.OP.SELECT_BAR_MAX_CLEARED, MAIN.OP.SELECT_BAR_ASSIST_EASY_CLEARED}
	do
		local posy = {75, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19}
		for i = 1, 11, 1 do
			table.insert(parts.destination, {
				id = "sel-bar-" ..wd[i], op = {op[i]}, dst = {
					{x = window.posX + 706, y = window.posY + posy[i], w = 187, h = 33},
				}
			})
		end
	end
end
-- 判定グラフ、判定カウント
local function judgeDetail(parts)
	-- グラフ
	do
		table.insert(parts.graph, {id = "gra-poor", src = 8, x = 950, y = 72, w = 300, h = 18, value = MAIN.GRAPH.RATE_POOR, angle = MAIN.G_ANGLE.RIGHT})
		table.insert(parts.graph, {id = "gra-bad", src = 8, x = 950, y = 54, w = 300, h = 18, value = MAIN.GRAPH.RATE_BAD, angle = MAIN.G_ANGLE.RIGHT})
		table.insert(parts.graph, {id = "gra-good", src = 8, x = 950, y = 36, w = 300, h = 18, value = MAIN.GRAPH.RATE_GOOD, angle = MAIN.G_ANGLE.RIGHT})
		table.insert(parts.graph, {id = "gra-great", src = 8, x = 950, y = 18, w = 300, h = 18, value = MAIN.GRAPH.RATE_GREAT, angle = MAIN.G_ANGLE.RIGHT})
		table.insert(parts.graph, {id = "gra-pgreat", src = 8, x = 950, y = 0, w = 300, h = 18, value = MAIN.GRAPH.RATE_PGREAT, angle = MAIN.G_ANGLE.RIGHT})
		local wd = {"poor", "bad", "good", "great", "pgreat"}
		local posy = {51, 81, 110, 139, 168}
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "gra-" ..wd[i], loop = 300, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
					{time = 0, x = window.posX + 198, y = window.posY + posy[i], w = 0, h = 18, acc = MAIN.ACC.DECELERATE},
					{time = 300, w = 300}
				}
			})
		end
	end
	-- カウント
	do
		table.insert(parts.value, {id = "poorcount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = MAIN.NUM.POOR})
		table.insert(parts.value, {id = "badcount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = MAIN.NUM.BAD})
		table.insert(parts.value, {id = "goodcount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = MAIN.NUM.GOOD})
		table.insert(parts.value, {id = "greatcount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = MAIN.NUM.GREAT})
		table.insert(parts.value, {id = "pgreatcount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = MAIN.NUM.PERFECT})
		local wd = {"poor", "bad", "good", "great", "pgreat"}
		local posy = {52, 82, 111, 139, 169}
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = wd[i] .."count", dst = {
					{x = window.posX + 115, y = window.posY + posy[i], w = 19, h = 15},
				}
			})
		end
	end
end
-- scoreレート
local function scoreRate(parts)
	table.insert(parts.image, {id = "scorelate-frame", src = 8, x = 1294, y = 231, w = 83, h = 25})
	table.insert(parts.value, {id = "scorelate", src = 8, x = 900, y = 400, w = 260, h = 25, divx = 10, digit = 3, ref = MAIN.NUM.SCORE_RATE})
	table.insert(parts.value, {id = "scorelate-afterdot", src = 8, x = 900, y = 400, w = 286, h = 25, divx = 11, digit = 2, ref = MAIN.NUM.SCORE_RATE_AFTERDOT})
	table.insert(parts.destination, {
		id = "scorelate-frame", loop = 1000, op = {-MAIN.OP.SELECT_BAR_NOT_PLAYED, MAIN.OP.SONGBAR}, dst = {
			{time = 1000, x = window.posX + 796, y = window.posY + 150, w = 83, h = 25}
		}
	})
	-- gradeバーで未プレイでない
	table.insert(parts.destination, {
		id = "scorelate-frame", loop = 1000, op = {-MAIN.OP.SELECT_BAR_NOT_PLAYED, MAIN.OP.GRADEBAR}, dst = {
			{time = 1000, x = window.posX + 796, y = window.posY + 150, w = 83, h = 25}
		}
	})
	table.insert(parts.destination, {
		id = "scorelate", loop = 1000, op = {-MAIN.OP.SELECT_BAR_NOT_PLAYED}, dst = {
			{time = 1000, x = window.posX + 716, y = window.posY + 150, w = 26, h = 25}
		}
	})
	table.insert(parts.destination, {
		id = "scorelate-afterdot", loop = 1000, op = {-MAIN.OP.SELECT_BAR_NOT_PLAYED}, dst = {
			{time = 1000, x = window.posX + 808, y = window.posY + 150, w = 20, h = 20}
		}
	})
end
-- メインフレーム
local function mainFrame(parts)
	table.insert(parts.image, {id = "score-frame", src = 8, x = 0, y = 0, w = 895, h = 194})
	table.insert(parts.value, {id = "exscore", src = 8, x = 900, y = 700, w = 253, h = 30, divx = 11, digit = 4, ref = MAIN.NUM.SCORE})
	table.insert(parts.value, {id = "combobreakcount", src = 8, x = 900, y = 700, w = 253, h = 30, divx = 11, digit = 4, ref = MAIN.NUM.COMBOBREAK})
	table.insert(parts.value, {id = "misscount", src = 8, x = 900, y = 700, w = 253, h = 30, divx = 11, digit = 4, ref = MAIN.NUM.MISSCOUNT})
	table.insert(parts.destination, {
		id = "score-frame", dst = {
			{x = window.posX, y = window.posY, w = 895, h = 194},
		}
	})
	table.insert(parts.destination, {
		id = "exscore", dst = {
			{x = window.posX + 625, y = window.posY + 162, w = 18, h = 30},
		}
	})
	table.insert(parts.destination, {
		id = "combobreakcount", dst = {
			{x = window.posX + 625, y = window.posY + 133, w = 18, h = 30},
		}
	})
	table.insert(parts.destination, {
		id = "misscount", dst = {
			{x = window.posX + 625, y = window.posY + 104, w = 18, h = 30},
		}
	})
end

local function load()
	local parts = {}
	parts.image = {}
	parts.value = {}
	parts.graph = {}
	parts.destination = {}
	mainFrame(parts)
	judgeDetail(parts)
	clearType(parts)
	rankBar(parts)
	scoreRate(parts)
	displayRank(parts)
	timingGraph(parts)
	return parts
end

return {
	load = load
}