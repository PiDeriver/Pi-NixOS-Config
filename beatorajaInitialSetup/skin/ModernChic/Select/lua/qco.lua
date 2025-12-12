--[[
	IRランキング、クリアレート表示用
	@author : KASAKO
--]]
-- 自身の順位枠か
local function isMyFrame(indexNum)
	local indexRank = main_state.number(389 + indexNum)
	local myRank = main_state.number(MAIN.NUM.IR_RANK)
	local flg = main_state.text(119 + indexNum) == "YOU"
	return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and (indexRank == myRank) and flg
end
local function load()
	local parts = {}
	local irFramePosX = 18
	local irFramePosY = 235
	local crFramePosX = 590
	local crFramePosY = 325
	local fcFramePosX = 590
	local fcFramePosY = 235
	local posRankingFrame = {590, 235}
	
	parts.image = {
		{id = "qco_ir_frame", src = 9, x = 0, y = 0, w = 560, h = 160},
		{id = "qco_fc_frame", src = 9, x = 570, y = 0, w = 410, h = 70},
		{id = "qco_cr_frame", src = 9, x = 570, y = 80, w = 410, h = 70},
		{id = "qco_fc_per", src = 9, x = 881, y = 170, w = 100, h = 70},
		{id = "qco_cr_per", src = 9, x = 881, y = 242, w = 100, h = 70},
		{id = "qco_ranking_frame", src = 9, x = 0, y = 370, w = 410, h = 160},
		{id = "qcoNoPlay", src = 9, x = 500, y = 170, w = 110, h = 22},
		{id = "qcoFailed", src = 9, x = 500, y = 192, w = 110, h = 22},
		{id = "qcoLaEasy", src = 9, x = 500, y = 214, w = 110, h = 22},
		{id = "qcoClear", src = 9, x = 500, y = 236, w = 110, h = 22},
		{id = "qcoEasy", src = 9, x = 500, y = 258, w = 110, h = 22},
		{id = "qcoFullCombo", src = 9, x = 500, y = 280, w = 330, h = 22, divx = 3, cycle = 300},
		{id = "qcoHardClear", src = 9, x = 500, y = 302, w = 110, h = 22},
		{id = "qcoExHard", src = 9, x = 500, y = 324, w = 220, h = 22, divx = 2, cycle = 200},
		{id = "qcoPerfect", src = 9, x = 500, y = 346, w = 110, h = 22},
		{id = "qcoMax", src = 9, x = 500, y = 368, w = 110, h = 22},
		{id = "qcoAssist", src = 9, x = 500, y = 390, w = 110, h = 22},
		{id = "qcoLoading", src = 9, x = 830, y = 390, w = 75, h = 44},
		{id = "qcoFCLoading", src = 9, x = 830, y = 434, w = 75, h = 44},
		{id = "qcoClearLoading", src = 9, x = 830, y = 478, w = 75, h = 44},

		-- 自身のポジション枠
		{id = "qcoMyRank", src = 9, x = 980, y = 0, w = 420, h = 80, divy = 2, cycle = 100},
	}
	-- クリアランク
	do
		local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
		local y = {530, 552, 574, 596, 618, 640, 662, 684}
		for i = 1, 8, 1 do
			table.insert(parts.image, {
				id = "qco"..wd[i], src = 9, x = 500, y = y[i], w = 59, h = 22
			})
		end
	end
	
	parts.imageset = {}
	do
		-- TOP10のクリア状況
		local ref = {
			MAIN.NUM.RANKING1_CLEAR,
			MAIN.NUM.RANKING2_CLEAR,
			MAIN.NUM.RANKING3_CLEAR,
			MAIN.NUM.RANKING4_CLEAR,
			MAIN.NUM.RANKING5_CLEAR,
			MAIN.NUM.RANKING6_CLEAR,
			MAIN.NUM.RANKING7_CLEAR,
			MAIN.NUM.RANKING8_CLEAR,
			MAIN.NUM.RANKING9_CLEAR,
			MAIN.NUM.RANKING10_CLEAR
		}

		for i = 1, 10, 1 do
			table.insert(parts.imageset,{
				id = "clearTypeIr"..i, ref = ref[i], images = {"qcoNoPlay", "qcoFailed", "qcoAssist", "qcoLaEasy", "qcoEasy", "qcoClear", "qcoHardClear", "qcoExHard", "qcoFullCombo", "qcoPerfect", "qcoPerfect"}
			})
		end
	end
	
	parts.value = {
		-- 現在のIR順位
		-- align:0,1,2 右、左、中央
		{id = "ir_rank2", src = 9, x = 0, y = 170, w = 430, h = 42, divx = 10, digit = 5, ref = MAIN.NUM.IR_RANK, align = 2},
		{id = "ir_eliteRank", src = 9, x = 0, y = 530, w = 430, h = 126, divx = 10, divy = 3, digit = 5, ref = MAIN.NUM.IR_RANK, align = 2, cycle = 100},
		-- IR参加人数
		{id = "ir_totalplayer2", src = 9, x = 0, y = 170, w = 430, h = 42, divx = 10, digit = 5, ref = MAIN.NUM.IR_TOTALPLAYER, align = 2},
		-- IRクリアレート
		{id = "ir_clearrate2", src = 9, x = 0, y = 254, w = 430, h = 42, divx = 10, digit = 3, ref = MAIN.NUM.IR_PLAYER_TOTAL_CLEAR_RATE},
		{id = "ir_clearrate2_ad", src = 9, x = 0, y = 327, w = 310, h = 31, divx = 10, digit = 1, ref = MAIN.NUM.IR_PLAYER_TOTAL_CLEAR_RATE_AFTERDOT},
--		{id = "ir_clearrate2_wh", src = 9, x = 0, y = 614, w = 430, h = 42, divx = 10, digit = 3, ref = 227},
--		{id = "ir_clearrate2_ad_wh", src = 9, x = 0, y = 718, w = 310, h = 31, divx = 10, digit = 1, ref = 241},
		-- IRフルコンレート
		{id = "ir_fcrate2", src = 9, x = 0, y = 212, w = 430, h = 42, divx = 10, digit = 3, ref = MAIN.NUM.IR_PLAYER_TOTAL_FULLCOMBO_RATE},
		{id = "ir_fcrate2_ad", src = 9, x = 0, y = 296, w = 310, h = 31, divx = 10, digit = 1, ref = MAIN.NUM.IR_PLAYER_TOTAL_FULLCOMBO_RATE_AFTERDOT},
	}
	
	do
		-- 10スロット情報
		-- rank
		local indexRef = {
			MAIN.NUM.RANKING1_INDEX,
			MAIN.NUM.RANKING2_INDEX,
			MAIN.NUM.RANKING3_INDEX,
			MAIN.NUM.RANKING4_INDEX,
			MAIN.NUM.RANKING5_INDEX,
			MAIN.NUM.RANKING6_INDEX,
			MAIN.NUM.RANKING7_INDEX,
			MAIN.NUM.RANKING8_INDEX,
			MAIN.NUM.RANKING9_INDEX,
			MAIN.NUM.RANKING10_INDEX,
		}
		-- EXSCORE
		local exscoreRef = {
			MAIN.NUM.RANKING1_EXSCORE,
			MAIN.NUM.RANKING2_EXSCORE,
			MAIN.NUM.RANKING3_EXSCORE,
			MAIN.NUM.RANKING4_EXSCORE,
			MAIN.NUM.RANKING5_EXSCORE,
			MAIN.NUM.RANKING6_EXSCORE,
			MAIN.NUM.RANKING7_EXSCORE,
			MAIN.NUM.RANKING8_EXSCORE,
			MAIN.NUM.RANKING9_EXSCORE,
			MAIN.NUM.RANKING10_EXSCORE
		}
		for i = 1, 10, 1 do
			table.insert(parts.value,{
				id = "indexIr"..i, src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = indexRef[i]
			})
			table.insert(parts.value,{
				id = "exscoreIr"..i, src = 5, x = 2401, y = 510, w = 220, h = 15, divx = 10, digit = 5, ref = exscoreRef[i]
			})
		end
	end
	
	parts.destination = {}
	
	-- IR情報
	table.insert(parts.destination,	{
		id = "qco_ir_frame", draw = function()
			return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
		end, dst = {
			{x = irFramePosX, y = irFramePosY, w = 560, h = 160},
		}
	})
	-- 接続先リポジトリ
	table.insert(parts.destination,	{
		id = "repositoryname", draw = function()
			return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
		end,
		dst = {
			{x = irFramePosX + 550, y = irFramePosY + 5, w = 560, h = 20, r = 237, g = 177, b = 10},
		}
	})
	table.insert(parts.destination,	{
		id = "ir_rank2", draw = function()
			local totalPlayerNum = main_state.number(MAIN.NUM.IR_TOTALPLAYER)
			local myRank = main_state.number(MAIN.NUM.IR_RANK)
			local rankPer = myRank / totalPlayerNum * 100
			return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and rankPer >= 10
		end,
		dst = {
			{x = irFramePosX + 19, y = irFramePosY + 33, w = 43, h = 42},
		}
	})
	-- 未プレイ
	table.insert(parts.destination,	{
		id = "qcoLoading", draw = function()
			local myRank = main_state.number(MAIN.NUM.IR_RANK)
			return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and myRank == 0
		end,
		dst = {
			{x = irFramePosX + 90, y = irFramePosY + 30, w = 75, h = 44},
		}
	})
	-- 自身の順位が上位10%の時に表示
	table.insert(parts.destination,	{
		id = "ir_eliteRank",
		draw = function()
			local totalPlayerNum = main_state.number(180)
			local myRank = main_state.number(179)
			local rankPer = myRank / totalPlayerNum * 100
			return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and rankPer <= 10 and myRank ~= 0
		end,
		dst = {
			{x = irFramePosX + 19, y = irFramePosY + 33, w = 43, h = 42},
		}
	})
	table.insert(parts.destination,	{
		id = "ir_totalplayer2", draw = function()
			return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
		end, dst = {
			{x = irFramePosX + 300, y = irFramePosY + 33, w = 43, h = 42},
		}
	})
	-- ロード中または失敗
	-- op606: IR_WAITING
	do
		local posX = {90, 370}
		for i = 1, 2, 1 do
			table.insert(parts.destination,{
				id = "qcoLoading", draw = function()
					return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and main_state.option(MAIN.OP.IR_WAITING)
				end, dst = {
					{time = 0, x = irFramePosX + posX[i], y = irFramePosY + 30, w = 75, h = 44},
					{time = 1000, a = 50},
					{time = 2000, a = 255}
				}
			})
		end
	end
	
	if PROPERTY.isIrClearrateFullcomborate() then
		-- クリアレート
		table.insert(parts.destination,	{
			id = "qco_cr_frame", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
			end, dst = {
				{x = crFramePosX, y = crFramePosY, w = 410, h = 70}
			}
		})
		table.insert(parts.destination,	{
			id = "qco_cr_per", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and not main_state.option(MAIN.OP.IR_WAITING)
			end, dst = {
				{x = crFramePosX + 320, y = crFramePosY + 5, w = 100, h = 70}
			}
		})
		table.insert(parts.destination,	{
			id = "ir_clearrate2", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
			end, dst = {
				{x = crFramePosX + 203, y = crFramePosY + 15, w = 43, h = 42}
			}
		})
		table.insert(parts.destination,	{
			id = "ir_clearrate2_ad", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
			end, dst = {
				{x = crFramePosX + 342, y = crFramePosY + 15, w = 31, h = 31}
			}
		})
		table.insert(parts.destination, {
			id = "qcoClearLoading", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and main_state.option(MAIN.OP.IR_WAITING)
			end, dst = {
				{time = 0, x = crFramePosX + 270, y = crFramePosY + 15, w = 75, h = 44},
				{time = 1000, a = 50},
				{time = 2000, a = 255}
			}
		})
		-- フルコン率
		table.insert(parts.destination,	{
			id = "qco_fc_frame", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
			end, dst = {
				{x = fcFramePosX, y = fcFramePosY, w = 410, h = 70},
			}
		})
		table.insert(parts.destination,	{
			id = "qco_fc_per", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and not main_state.option(MAIN.OP.IR_WAITING)
			end, dst = {
				{x = fcFramePosX + 320, y = fcFramePosY + 5, w = 100, h = 70},
			}
		})
		table.insert(parts.destination,	{
			id = "ir_fcrate2", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
			end, dst = {
				{x = fcFramePosX + 203, y = fcFramePosY + 15, w = 43, h = 42},
			}
		})
		table.insert(parts.destination,	{
			id = "ir_fcrate2_ad", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
			end, dst = {
				{x = fcFramePosX + 342, y = fcFramePosY + 15, w = 31, h = 31},
			}
		})
		table.insert(parts.destination, {
			id = "qcoFCLoading", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and main_state.option(MAIN.OP.IR_WAITING)
			end, dst = {
				{time = 0, x = fcFramePosX + 270, y = fcFramePosY + 15, w = 75, h = 44},
				{time = 1000, a = 50},
				{time = 2000, a = 255}
			}
		})
	elseif PROPERTY.isIrRanking() then
		table.insert(parts.destination, {
			id = "qco_ranking_frame", draw = function()
				return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
			end, dst = {
				{x = posRankingFrame[1], y = posRankingFrame[2], w = 410, h = 160},
			}
		})
		do
			-- 1位から5位のy座標
			local PosY = {112, 85, 59, 33, 6}
			for i = 1, 5, 1 do
				-- 自身の場合は強調表示する
				table.insert(parts.destination, {
					id = "qcoMyRank", draw = function()
						return isMyFrame(i)
					end, dst = {
						{x = posRankingFrame[1] - 6, y = posRankingFrame[2] + PosY[i] - 12, w = 420, h = 40},
					}
				})
				-- インデックス
				table.insert(parts.destination,{
					id = "indexIr"..i, draw = function()
						return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
					end, dst = {
						{x = posRankingFrame[1] + 5, y = posRankingFrame[2] + PosY[i], w = 13, h = 15},
					}
				})
				-- 名前
				table.insert(parts.destination,{
					id = "irRankName"..i, draw = function()
						return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
					end, dst = {
						{x = posRankingFrame[1] + 80, y = posRankingFrame[2] + PosY[i] - 3, w = 100, h = 16},
					}
				})
				-- EXSCORE
				table.insert(parts.destination,{
					id = "exscoreIr"..i, draw = function()
						return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
					end, dst = {
						{x = posRankingFrame[1] + 175, y = posRankingFrame[2] + PosY[i], w = 13, h = 15},
					}
				})
				-- クリア状況
				table.insert(parts.destination,{
					id = "clearTypeIr"..i, draw = function()
						return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE)
					end, dst = {
						{x = posRankingFrame[1] + 295, y = posRankingFrame[2] + PosY[i] - 3, w = 110, h = 22},
					}
				})
				-- クリアランク
				do
					local refRate = {100, 88.8, 77.7, 66.6, 55.5, 44.4, 33.3, 22.2, -1}
					local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
					for j = 1, 8, 1 do
						table.insert(parts.destination, {
							id = "qco"..wd[j],
							draw = function()
								-- exスコアを取得
								local exScore = main_state.number(379 + i)
								-- 最大exスコアを取得
								local maxExScore = main_state.number(74) * 2
								local rankRate = (exScore / maxExScore) * 100
								return (main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)) and main_state.option(MAIN.OP.ONLINE) and rankRate <= refRate[j] and rankRate > refRate[j + 1]
							end,
							dst = {
								{x = posRankingFrame[1] + 240, y = posRankingFrame[2] + PosY[i] - 3, w = 59, h = 22},
							}
						})
					end
				end
			end
		end
	end
	
	return parts
end

return {
	load = load
}