--[[
	ライバル比較モード
	@author : KASAKO
--]]
local window = {posX = 10, posY = 220}
local function judge(parts)
	-- 勝利
	table.insert(parts.destination, {
		id = "compare-win", op = {MAIN.OP.COMPARE_RIVAL, MAIN.OP.WIN_1P}, dst = {
			{x = window.posX + 180, y = window.posY + 570, w = 170, h = 50},
		},
	})
	table.insert(parts.destination, {
		id = "compare-lose", op = {MAIN.OP.COMPARE_RIVAL, MAIN.OP.WIN_1P}, dst = {
			{x = window.posX + 685, y = window.posY + 570, w = 170, h = 50},
		},
	})

	-- ライバル勝利
	table.insert(parts.destination, {
		id = "compare-lose", op = {MAIN.OP.COMPARE_RIVAL, MAIN.OP.WIN_2P}, dst = {
			{x = window.posX + 180, y = window.posY + 570, w = 170, h = 50},
		},
	})
	table.insert(parts.destination, {
		id = "compare-win", op = {MAIN.OP.COMPARE_RIVAL, MAIN.OP.WIN_2P}, dst = {
			{x = window.posX + 685, y = window.posY + 570, w = 170, h = 50},
		},
	})
end
local function name(parts)
	-- 名前
	table.insert(parts.destination, {
		id = "yourname", op = {MAIN.OP.COMPARE_RIVAL}, dst = {
			{x = window.posX + 270, y = window.posY + 500, w = 300, h = 35},
		},
	})
	table.insert(parts.destination, {
		id = "rivalname", op = {MAIN.OP.COMPARE_RIVAL}, dst = {
			{x = window.posX + 770, y = window.posY + 500, w = 300, h = 35},
		},
	})
end
local function clearRank(parts)
	-- クリアランク
	local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
	local refRate = {100, 88.88, 77.77, 66.66, 55.55, 44.44, 33.33, 22.22, -1}
	local posY = 1750
	for i = 1, 8, 1 do
		table.insert(parts.image, {
			id = "compare-"..wd[i], src = 5, x = 2720, y = posY, w = 170, h = 50
		})
		posY = posY + 50
	end
	for i = 1, 8, 1 do
		-- 自分
		table.insert(parts.destination, {
			id = "compare-"..wd[i], draw = function()
				return main_state.option(2) and main_state.option(MAIN.OP.COMPARE_RIVAL) and CUSTOM.NUM.achievementRate(MAIN.NUM.SCORE) <= refRate[i] and CUSTOM.NUM.achievementRate(MAIN.NUM.SCORE) > refRate[i + 1]
			end, dst = {
				{x = 190, y = 655, w = 170, h = 50},
			}
		})
		-- ライバル
		table.insert(parts.destination, {
			id = "compare-"..wd[i], draw = function()
				return main_state.option(2) and main_state.option(MAIN.OP.COMPARE_RIVAL) and CUSTOM.NUM.achievementRate(MAIN.NUM.RIVAL_SCORE) <= refRate[i] and CUSTOM.NUM.achievementRate(MAIN.NUM.RIVAL_SCORE) > refRate[i + 1]
			end, dst = {
				{x = 695, y = 655, w = 170, h = 50},
			}
		})
	end
end
local function info(parts)
	local mine = window.posX + 165
	local rival = window.posX + 675
	local title = window.posX + 430
	do
		local wd = {"myscore", "mypgreat", "mygreat", "mygood", "mybad", "mypoor"}
		local posY = 375
		for i = 1, 6, 1 do
			table.insert(parts.destination, {
				id = "compare-" ..wd[i], draw = function()
					return CUSTOM.OP.isYouWin()
				end, dst = {
					{x = mine, y = window.posY + posY, w = 34, h = 42, r = 0, g = 192, b = 242},
				}
			})
			table.insert(parts.destination, {
				id = "compare-" ..wd[i], draw = function()
					return CUSTOM.OP.isRivalWin()
				end, dst = {
					{x = mine, y = window.posY + posY, w = 34, h = 42, r = 238, g = 67, b = 0},
				}
			})
			posY = posY - 65
		end
	end
	-- ライバル情報
	do
		local wd = {"rivalscore", "rivalpgreat", "rivalgreat", "rivalgood", "rivalbad", "rivalpoor"}
		local posY = 375
		for i = 1, 6, 1 do
			table.insert(parts.destination, {
				id = "compare-" ..wd[i], draw = function()
					return CUSTOM.OP.isRivalWin()
				end, dst = {
					{x = rival, y = window.posY + posY, w = 34, h = 42, r = 0, g = 192, b = 242},
				}
			})
			table.insert(parts.destination, {
				id = "compare-" ..wd[i], draw = function()
					return CUSTOM.OP.isYouWin()
				end, dst = {
					{x = rival, y = window.posY + posY, w = 34, h = 42, r = 238, g = 67, b = 0},
				}
			})
			posY = posY - 65
		end
	end
	-- 文字
	do
		local wd = {"vs", "rank", "score", "pgreat", "great", "good", "bad", "poor"}
		local posY = 500
		for i = 1, 8, 1 do
			table.insert(parts.destination, {
				id = "compare-" ..wd[i], op = {MAIN.OP.COMPARE_RIVAL}, dst = {
					{x = title, y = window.posY + posY, w = 170, h = 50},
				}
			})
			posY = posY - 65
		end
	end
end
local function rivalSelector(parts)
	table.insert(parts.image, {id = "compare-rivalSelector_off", src = 5, x = 1064, y = 2150, w = 168, h = 40})
	table.insert(parts.image, {id = "compare-rivalSelector_on", src = 5, x = 1064, y = 2190, w = 168, h = 40, act = MAIN.BUTTON.RIVAL})
	table.insert(parts.destination, {id = "compare-rivalSelector_off", op = {MAIN.OP.COMPARE_RIVAL}, dst = {{x = window.posX + 432, y = window.posY + 578, w = 168, h = 40}}})
	table.insert(parts.destination, {
		id = "compare-rivalSelector_on", op = {MAIN.OP.COMPARE_RIVAL}, dst = {
			{time = 0, x = window.posX + 432, y = window.posY + 578, w = 168, h = 40},
			{time = 500, a = 100},
			{time = 1000, a = 255}
		}
	})
end

local function load()
	local parts = {}
	
	parts.image = {
		{id = "compare-frame", src = 5, x = 2000, y = 2200, w = 1022, h = 655},
		{id = "compare-frame-small", src = 5, x = 2000, y = 2900, w = 1000, h = 180},
		{id = "compare-win", src = 5, x = 2550, y = 1700, w = 170, h = 50},
		{id = "compare-lose", src = 5, x = 2550, y = 1750, w = 170, h = 50},
		{id = "compare-vs", src = 5, x = 2550, y = 1800, w = 170, h = 50},
		{id = "compare-score", src = 5, x = 2550, y = 1850, w = 170, h = 50},
		{id = "compare-pgreat", src = 5, x = 2550, y = 1900, w = 170, h = 50},
		{id = "compare-great", src = 5, x = 2550, y = 1950, w = 170, h = 50},
		{id = "compare-good", src = 5, x = 2550, y = 2000, w = 170, h = 50},
		{id = "compare-bad", src = 5, x = 2550, y = 2050, w = 170, h = 50},
		{id = "compare-poor", src = 5, x = 2550, y = 2100, w = 170, h = 50},
		{id = "compare-rank", src = 5, x = 2720, y = 1700, w = 170, h = 50},
	}
	
	parts.value = {
		-- ベストスコア
		{id = "compare-myscore", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.SCORE},
		{id = "compare-rivalscore", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.RIVAL_SCORE},
		-- pgreat数
		{id = "compare-mypgreat", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.PERFECT},
		{id = "compare-rivalpgreat", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.RIVAL_PERFECT},
		-- great
		{id = "compare-mygreat", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.GREAT},
		{id = "compare-rivalgreat", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.RIVAL_GREAT},
		-- good
		{id = "compare-mygood", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.GOOD},
		{id = "compare-rivalgood", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5,ref = MAIN.NUM.RIVAL_GOOD},
		-- bad
		{id = "compare-mybad", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.BAD},
		{id = "compare-rivalbad", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.RIVAL_BAD},
		-- poor
		{id = "compare-mypoor", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.POOR},
		{id = "compare-rivalpoor", src = 5, x = 2550, y = 1300, w = 374, h = 42, divx = 11, digit = 5, ref = MAIN.NUM.RIVAL_POOR},
	}

	parts.destination = {}
	table.insert(parts.destination, {id = "compare-frame", op = {MAIN.OP.COMPARE_RIVAL}, dst = {{x = window.posX, y = window.posY, w = 1022, h = 655, a = 230}}})
	judge(parts)
	name(parts)
	clearRank(parts)
	info(parts)
	rivalSelector(parts)
	
	return parts
end

return {
	load = load
}