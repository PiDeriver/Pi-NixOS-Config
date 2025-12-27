--[[
	グラフバー
	@author : KASAKO
--]]

local function load()
	local parts = {}
	
	local cycleNum = 20000
	
	parts.image = {
		-- スコアグラフフレーム
		{id = "graFrame", src = 22, x = 0, y = 0, w = 331, h = 198},
		-- nowscore bestscore target lankフレーム
		{id = "graFrame2", src = 22, x = 0, y = 729, w = 331, h = 112},
		-- グラフバー
		{id = "graBarMAX", src = 22, x = 0, y = 199, w = 331, h = 29},
		{id = "graBarA1", src = 22, x = 0, y = 850, w = 340, h = 29},
		{id = "graBarAA1", src = 22, x = 0, y = 879, w = 340, h = 29},
		{id = "graBarAAA1", src = 22, x = 0, y = 908, w = 340, h = 29},
		{id = "graBarA2", src = 22, x = 0, y = 937, w = 340, h = 29},
		{id = "graBarAA2", src = 22, x = 0, y = 966, w = 340, h = 29},
		{id = "graBarAAA2", src = 22, x = 0, y = 995, w = 340, h = 29},
		-- 現在のランク
		{id = "graNowAAA", src = 22, x = 340, y = 0, w = 74, h = 20},
		{id = "graNowAA", src = 22, x = 340, y = 20, w = 74, h = 20},
		{id = "graNowA", src = 22, x = 340, y = 40, w = 74, h = 20},
		{id = "graNowB", src = 22, x = 340, y = 60, w = 74, h = 20},
		{id = "graNowC", src = 22, x = 340, y = 80, w = 74, h = 20},
		{id = "graNowD", src = 22, x = 340, y = 100, w = 74, h = 20},
		{id = "graNowE", src = 22, x = 340, y = 120, w = 74, h = 20},
		{id = "graNowF", src = 22, x = 340, y = 140, w = 74, h = 20},
		-- ターゲットラベル
--		{id = "graTarget", src = 22, x = 500, y = 530, w = 160, h = 198, divy = 11, len = 11, ref = MAIN.BUTTON.TARGET},
		-- 判定ランク
		{id = "graJudgeVE", src = 22, x = 340, y = 530, w = 160, h = 18},
		{id = "graJudgeE", src = 22, x = 340, y = 548, w = 160, h = 18},
		{id = "graJudgeN", src = 22, x = 340, y = 566, w = 160, h = 18},
		{id = "graJudgeH", src = 22, x = 340, y = 584, w = 160, h = 18},
		{id = "graJudgeVH", src = 22, x = 340, y = 602, w = 160, h = 18},

		-- 背景
		{id = "graBg", src = 25, x = 0, y = 0, w = 331, h = 531},
	}
	
	parts.value = {
		-- 自スコア
		{id = "numMyExscore", src = 1, x = 1008, y = 940, w = 330, h = 40, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.SCORE2},
		-- ターゲットスコア
		{id = "numTarExscore", src = 1, x = 1008, y = 940, w = 330, h = 40, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TARGET_SCORE},
		-- マイベストとのEXSCORE差分
		-- zeropadding 1:0で埋める 2:裏0で埋める
		{id = "numDiffExscoreMybest", src = 1, x = 720, y = 1040, w = 288, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_HIGHSCORE, align = 0},
		-- ターゲットとのEXSCORE差分
		{id = "numDiffExscoreTarget", src = 1, x = 720, y = 1040, w = 288, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_TARGETSCORE, align = 0},
	}
	
	--110: SCORERATE
	parts.graph = {
		{id = "graph-now", src = 22, x = 580, y = 0, w = 78, h = 523, divy = 523, cycle = cycleNum, type = MAIN.GRAPH.SCORERATE, angle = MAIN.G_ANGLE.DOWN},
		{id = "graph-now-best", src = 22, x = 580, y = 0, w = 78, h = 523, divy = 523, type = MAIN.GRAPH.SCORERATE_FINAL, angle = MAIN.G_ANGLE.DOWN},

		{id = "graph-best-bg", src = 22, x = 500, y = 0, w = 78, h = 523, type = MAIN.GRAPH.BESTSCORERATE, angle = MAIN.G_ANGLE.DOWN},
		{id = "graph-best", src = 22, x = 500, y = 0, w = 78, h = 523, divy = 523, cycle = cycleNum, type = MAIN.GRAPH.BESTSCORERATE_NOW, angle = MAIN.G_ANGLE.DOWN},

		{id = "graph-target-bg", src = 22, x = 420, y = 0, w = 78, h = 523, type = MAIN.GRAPH.TARGETSCORERATE, angle = MAIN.G_ANGLE.DOWN},
		{id = "graph-target", src = 22, x = 420, y = 0, w = 78, h = 523, divy = 523, cycle = cycleNum, type = MAIN.GRAPH.TARGETSCORERATE_NOW, angle = MAIN.G_ANGLE.DOWN},
	}
	
	parts.destination = {}

	local positionX = 0
	local positionY = 239
	local graphPosY = 351

	if PROPERTY.isGraphPositionLeft() or PROPERTY.isGraphPositionRight() then
		if PROPERTY.isGraphPositionLeft() then
			positionX = BASE.subPosX[1]
		elseif PROPERTY.isGraphPositionRight() then
			positionX = BASE.subPosX[2]
		end
		-- グラフフレーム
		table.insert(parts.destination, {
			id = "graFrame", dst = {
				{x = positionX + 0, y = positionY + 643, w = 331, h = 198},
			}
		})
		table.insert(parts.destination, {
			id = "graFrame2", dst = {
				{x = positionX + 0, y = positionY + 0, w = 331, h = 112},
			}
		})
		-- ターゲットラベル
		--[[
		table.insert(parts.destination, {
			id = "graTarget", dst = {
				{x = positionX + 4, y = positionY + 23, w = 160, h = 18},
			}
		})]]
		table.insert(parts.destination,	{
			id = "rivalname", dst = {
				{x = positionX + 82, y = positionY + 16, w = 140, h = 25},
			}
		})
		do
			-- 判定ランク
			local wd = {"VH", "H", "N", "E", "VE"}
			local op = {MAIN.OP.JUDGE_VERYHARD, MAIN.OP.JUDGE_HARD, MAIN.OP.JUDGE_NORMAL, MAIN.OP.JUDGE_EASY, MAIN.OP.JUDGE_VERYEASY}
			for i = 1, 5, 1 do
				table.insert(parts.destination, {
					id = "graJudge"..wd[i], op = {op[i]}, dst = {
						{x = positionX + 169, y = positionY + 23, w = 160, h = 18},
					}
				})
			end
		end

		-- 背景
		table.insert(parts.destination, {
			id = "graBg", dst = {
				{x = positionX + 0, y = positionY + 112, w = 331, h = 531, a = 245},
			}
		})
		-- グラフ用明るさ調整
		table.insert(parts.destination,	{
			id = MAIN.IMAGE.BLACK, offset = PROPERTY.offsetGraphBrightness.num, dst = {
				{x = positionX + 0, y = positionY + 112, w = 331, h = 531, a = 0},
			}
		})
		-- 現在のスコアとターゲットスコア
		table.insert(parts.destination, {
			id = "numMyExscore", dst = {
				{x = positionX + 100, y = positionY + 777, w = 33, h = 40},
			}
		})
		table.insert(parts.destination, {
			id = "numTarExscore", dst = {
				{x = positionX + 100, y = positionY + 666, w = 33, h = 40},
			}
		})
		-- 基準点
		table.insert(parts.destination, {
			id = "graBarMAX", dst = {
				{x = positionX + 0, y = graphPosY + 501, w = 331, h = 29},
			}
		})
		-- 8/9
		table.insert(parts.destination, {
			id = "graBarAAA1", op = {-MAIN.OP.AAA}, dst = {
				{x = positionX + 0, y = graphPosY + 464, w = 340, h = 29},
			}
		})
		-- 7/9
		table.insert(parts.destination, {
			id = "graBarAA1", op = {-MAIN.OP.AA}, dst = {
				{x = positionX + 0, y = graphPosY + 406, w = 340, h = 29},
			}
		})
		-- 6/9
		table.insert(parts.destination, {
			id = "graBarA1", op = {-MAIN.OP.A}, dst = {
				{x = positionX + 0, y = graphPosY + 348, w = 340, h = 29},
			}
		})
		table.insert(parts.destination, {
			id = "graBarAAA2", op = {MAIN.OP.AAA}, dst = {
				{x = positionX + 0, y = graphPosY + 464, w = 340, h = 29},
			}
		})
		table.insert(parts.destination, {
			id = "graBarAA2", op = {MAIN.OP.AA}, dst = {
				{x = positionX + 0, y = graphPosY + 406, w = 340, h = 29},
			}
		})
		table.insert(parts.destination, {
			id = "graBarA2", op = {MAIN.OP.A}, dst = {
				{x = positionX + 0, y = graphPosY + 348, w = 340, h = 29},
			}
		})

		-- 基準点の白いあの線
		table.insert(parts.destination,	{
			id = MAIN.IMAGE.WHITE, dst = {
				{x = positionX + 0, y = positionY + 109, w = 331, h = 2},
			}
		})

		-- 現在のベストレート
		table.insert(parts.destination, {
			id = "graph-now-best", dst = {
				{x = positionX + 243, y = positionY + 112, w = 78, h = 523, a = 50},
			}
		})
		-- 現在のスコア
		table.insert(parts.destination, {
			id = "graph-now", dst = {
				{x = positionX + 243, y = positionY + 112, w = 78, h = 523},
			}
		})
		do
			-- 現在のランク
			local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
			local op = {MAIN.OP.AAA_1P, MAIN.OP.AA_1P, MAIN.OP.A_1P, MAIN.OP.B_1P, MAIN.OP.C_1P, MAIN.OP.D_1P, MAIN.OP.E_1P, MAIN.OP.F_1P}
			for i = 1, 7, 1 do
				table.insert(parts.destination, {
					id = "graNow"..wd[i], op = {op[i]}, dst = {
						{x = positionX + 244, y = positionY + 125, w = 74, h = 20},
					}
				})
			end
		end

		-- 自己ベスト
		table.insert(parts.destination, {
			id = "graph-best-bg", dst = {
				{x = positionX + 161, y = positionY + 112, w = 78, h = 523, a = 50},
			}
		})
		table.insert(parts.destination, {
			id = "graph-best", dst = {
				{x = positionX + 161, y = positionY + 112, w = 78, h = 523},
			}
		})
		-- 自己ベストとの差

		-- ターゲットスコア
		table.insert(parts.destination, {
			id = "graph-target-bg", dst = {
				{x = positionX + 80, y = positionY + 112, w = 78, h = 523, a = 50},
			}
		})
		table.insert(parts.destination, {
			id = "graph-target", dst = {
				{x = positionX + 80, y = positionY + 112, w = 78, h = 523},
			}
		})
		-- ターゲットスコアとの差
	end

	return parts
end

return {
	load = load
}