--[[
	IR関係メニュー
	オプションONかつオンライン時で表示
	@author : KASAKO
]]
-- IR順位が更新され かつ IR上位10％でない
local function irRankUpdate()
	if CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_BEGIN) or CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_SUCCESS) then
		return false
	else
		local rankPer = main_state.number(MAIN.NUM.IR_RANK) / main_state.number(MAIN.NUM.IR_TOTALPLAYER) * 100
		local prevNum = main_state.number(MAIN.NUM.IR_PREVRANK)
		local nowNum = main_state.number(MAIN.NUM.IR_RANK)
		return prevNum > nowNum and rankPer > 10
	end
end
-- IR順位更新なし時 かつ 上位10％でない
local function irRankNoupdate()
	if CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_BEGIN) or CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_SUCCESS) then
		return false
	else
		local rankPer = main_state.number(MAIN.NUM.IR_RANK) / main_state.number(MAIN.NUM.IR_TOTALPLAYER) * 100
		local prevNum = main_state.number(MAIN.NUM.IR_PREVRANK)
		local nowNum = main_state.number(MAIN.NUM.IR_RANK)
		return prevNum <= nowNum and rankPer > 10
	end
end
-- IR順位が更新され かつ IR上位10％
local function irRankTop10PerInUpdate()
	if CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_BEGIN) or CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_SUCCESS) then
		return false
	else
		local rankPer = main_state.number(MAIN.NUM.IR_RANK) / main_state.number(MAIN.NUM.IR_TOTALPLAYER) * 100
		local prevNum = main_state.number(MAIN.NUM.IR_PREVRANK)
		local nowNum = main_state.number(MAIN.NUM.IR_RANK)
		return prevNum > nowNum and rankPer <= 10
	end
end
-- IR順位更新なし かつ IR上位10％
local function irRankTop10PerInNoUpdate()
	if CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_BEGIN) or CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_SUCCESS) then
		return false
	else
		local rankPer = main_state.number(MAIN.NUM.IR_RANK) / main_state.number(MAIN.NUM.IR_TOTALPLAYER) * 100
		local prevNum = main_state.number(MAIN.NUM.IR_PREVRANK)
		local nowNum = main_state.number(MAIN.NUM.IR_RANK)
		return prevNum <= nowNum and rankPer <= 10
	end
end
-- IR読み込み中
local function irLoading()
	return CUSTOM.OP.isTimerOn(MAIN.TIMER.IR_CONNECT_BEGIN) and CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_SUCCESS)
end
-- 単純にIR順位が更新されたかを判定
local function irRankUpdate2()
	-- IRにスコアを更新したか
	if CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_BEGIN) or CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_SUCCESS) then
		return false
	else
		local prevNum = main_state.number(MAIN.NUM.IR_PREVRANK)
		local nowNum = main_state.number(MAIN.NUM.IR_RANK)
		return prevNum > nowNum
	end
end
-- IRメニューの状態
local function irMenuRanking(isIrRanking) return isIrRanking and main_state.time(MAIN.TIMER.IR_CONNECT_SUCCESS) end
local function irMenuClear(isIrClear) return isIrClear and main_state.time(MAIN.TIMER.IR_CONNECT_SUCCESS) end
-- カバーの表示切り替え
local function hiddenCounter()
	local screenHidden = CONFIG.result.irCover
	return {
		change = function()
			screenHidden = not(screenHidden)
			CUSTOM.SOUND.menuChangeSound()
		end,
		get = function()
			return screenHidden
		end
	}
end

local function load()
	local parts = {}
	local isIrRanking
	local isIrClear

	-- メニュー表示状況
	if PROPERTY.isIrRankingTop10() then
		isIrRanking = true
		isIrClear = false
	elseif PROPERTY.isIrClearType() then
		isIrRanking = false
		isIrClear = true
	end

	-- irメニュー切り替え
	local function irMenuSwitch()
		isIrRanking = not isIrRanking
		isIrClear = not isIrClear
		CUSTOM.SOUND.menuChangeSound()
	end

	parts.image = {
		{id = "irTopFrame", src = 2, x = 670, y = 380, w = 665, h = 714},
		{id = "irRankingFrame", src = 2, x = 670, y = 160, w = 665, h = 210},
		{id = "irSending", src = 2, x = 670, y = 100, w = 665, h = 50},
		{id = "irSendComp", src = 2, x = 670, y = 50, w = 665, h = 50},
		{id = "irSendFaild", src = 2, x = 670, y = 0, w = 665, h = 50},
		{id = "IrOvertake", src = 6, x = 0, y = 380, w = 142, h = 142},
		{id = "IrLoading", src = 6, x = 199, y = 420, w = 89, h = 19},
		-- TOP10名前隠し
		{id = "irTop10Cover", src = 1, x = 0, y = 0, w = 512, h = 645},
		-- 自身のポジション枠
		{id = "irMyPositionFrame", src = 2, x = 0, y = 1630, w = 655, h = 148, divy = 2, cycle = 100},
		-- ランプ状況
		{id = "irNoplay", src = 5, x = 0, y = 684, w = 38, h = 76},
		{id = "irFailed", src = 5, x = 0, y = 0, w = 76, h = 76, divx = 2, cycle = 50},
		{id = "irEasy", src = 5, x = 0, y = 76, w = 38, h = 76},
		{id = "irNormal", src = 5, x = 0, y = 152, w = 38, h = 76},
		{id = "irHard", src = 5, x = 0, y = 228, w = 38, h = 76},
		{id = "irExhard", src = 5, x = 0, y = 304, w = 76, h = 76, divx = 2, cycle = 50},
		{id = "irFullCombo", src = 5, x = 0, y = 380, w = 114, h = 76, divx = 3, cycle = 50},
		{id = "irPerfect", src = 5, x = 0, y = 456, w = 114, h = 76, divx = 3, cycle = 50},
		{id = "irAssist", src = 5, x = 0, y = 532, w = 38, h = 76},
		{id = "irLaAssist", src = 5, x = 0, y = 608, w = 38, h = 76},
		-- IRクリアタイプ用
		{id = "irClearFrame", src = 2, x = 1335, y = 0, w = 665, h = 714},
		{id = "irClearFrame2", src = 2, x = 1335, y = 720, w = 665, h = 648},
		{id = "irMyPositionFrame2", src = 2, x = 1335, y = 1910, w = 661, h = 150, divy = 2, cycle = 100},
		-- スクロールバー
		{id = "scrollBarFrame", src = 2, x = 2670, y = 0, w = 28, h = 714},

	}
	-- スクショ用ボタン
	local screenHidden = hiddenCounter()
	table.insert(parts.image, {
		id = "screenShot", src = 2, x = 1200, y = 1110, w = 86, h = 43, divx = 2, cycle = 200, act = screenHidden.change
	})
	-- IRライバルタイプ
	table.insert(parts.image, {
		id = "irRivaltypeMybestdif", src = 2, x = 852, y = 1153, w = 167, h = 43
	})
	table.insert(parts.image, {
		id = "irRivaltypeRank", src = 2, x = 852, y = 1110, w = 167, h = 43
	})
	-- IRTOP10アイコン
	table.insert(parts.image, {
		id = "irTop10Label", src = 2, x = 852, y = 1325, w = 234, h = 43
	})
	table.insert(parts.image, {
		id = "irTop10LabelRect", src = 2, x = 852, y = 1325, w = 234, h = 43, act = function()
			return irMenuSwitch()
		end,
	})
	-- IRCLEARアイコン
	table.insert(parts.image, {
		id = "irClearLabel", src = 2, x = 852, y = 1282, w = 234, h = 43
	})
	table.insert(parts.image, {
		id = "irClearLabelRect", src = 2, x = 852, y = 1282, w = 234, h = 43, act = function()
			return irMenuSwitch()
		end,
	})
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
				id = "clearTypeIr"..i, ref = ref[i], images = {"irNoplay", "irFailed", "irAssist", "irLaAssist", "irEasy", "irNormal", "irHard", "irExhard", "irFullCombo", "irPerfect", "irPerfect"}
			})
		end
	end
	
	parts.value = {
		{id = "irMyRank", src = 4, x = 0, y = 0, w = 440, h = 60, divx = 10, digit = 5, ref = MAIN.NUM.IR_RANK, align = MAIN.N_ALIGN.CENTER},
		-- 上位10％時
		{id = "irEliteRank", src = 4, x = 0, y = 384, w = 440, h = 180, divx = 10, divy = 3, digit = 5, ref = MAIN.NUM.IR_RANK, align = MAIN.N_ALIGN.CENTER, cycle = 50},
		-- 更新前の順位
		{id = "irPrevMyRank", src = 4, x = 0, y = 0, w = 440, h = 60, divx = 10, digit = 5, ref = MAIN.NUM.IR_PREVRANK, align = MAIN.N_ALIGN.CENTER},
		-- IR参加人数
		{id = "irTotalPlayer", src = 4, x = 0, y = 0, w = 440, h = 60, divx = 10, digit = 5, ref = MAIN.NUM.IR_TOTALPLAYER, align = MAIN.N_ALIGN.CENTER},
	}

	do
		-- スロット10個分順位
		local rank = {
			MAIN.NUM.RANKING1_INDEX,
			MAIN.NUM.RANKING2_INDEX,
			MAIN.NUM.RANKING3_INDEX,
			MAIN.NUM.RANKING4_INDEX,
			MAIN.NUM.RANKING5_INDEX,
			MAIN.NUM.RANKING6_INDEX,
			MAIN.NUM.RANKING7_INDEX,
			MAIN.NUM.RANKING8_INDEX,
			MAIN.NUM.RANKING9_INDEX,
			MAIN.NUM.RANKING10_INDEX
		}
		for i = 1, 10, 1 do
			table.insert(parts.value, {
				id = "indexIr" ..i, src = 4, x = 440, y = 60, w = 341, h = 36, divx = 11, digit = 5, zeropadding = MAIN.N_ZEROPADDING.ON, ref = rank[i]
			})
		end
		-- スロット10個分EXSCORE
		local ref = {
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
				id = "exscoreIr"..i, src = 4, x = 440, y = 60, w = 310, h = 36, divx = 10, digit = 5, align = MAIN.N_ALIGN.CENTER, ref = ref[i]
			})
		end
		-- TOP10からのスコア差分
		for i = 1, 10, 1 do
			table.insert(parts.value,{
				id = "exscoreIrDiff"..i, src = 4, x = 440, y = 276, w = 372, h = 72, divx = 12, divy = 2, digit = 6, align = MAIN.N_ALIGN.CENTER, value = function()
					if main_state.number(ref[i]) == -2147483648 then
						return 0
					else
						return main_state.number(ref[i]) - CUSTOM.NUM.myScoreBest()
					end
				end,
			})
		end
	end

	do
		-- 更新前と更新後の順位差分
		table.insert(parts.value, {
			id = "irRankDiff", src = 4, x = 440, y = 276, w = 372, h = 72, divx = 12, divy = 2, digit = 6, align = MAIN.N_ALIGN.CENTER, value = function()
				return CUSTOM.NUM.irRankDiff()
			end,
		})
	end

	parts.graph = {}

	parts.slider = {
		{id = "scrollBar", src = 2, x = 2670, y = 714, w = 28, h = 70, type = MAIN.SLIDER.IR_POSITION, range = 655, angle = MAIN.S_ANGLE.DOWN, changeable = true}
	}

	parts.destination = {}

	-- IR送信中
	table.insert(parts.destination, {
		id = "irSending", timer = MAIN.TIMER.IR_CONNECT_BEGIN, dst = {
			{x = RESULT_BASE.SUB_POS_X, y = 1024, w = 665, h = 50},
		}
	})
	-- IR送信完了
	table.insert(parts.destination, {
		id = "irSendComp", timer = MAIN.TIMER.IR_CONNECT_SUCCESS, dst = {
			{x = RESULT_BASE.SUB_POS_X, y = 1024, w = 665, h = 50},
		}
	})
	-- IR送信失敗
	table.insert(parts.destination, {
		id = "irSendFaild", timer = MAIN.TIMER.IR_CONNECT_FAIL, dst = {
			{x = RESULT_BASE.SUB_POS_X, y = 1024, w = 665, h = 50},
		}
	})

	do
		local posY = 806
		table.insert(parts.destination, {
			id = "irRankingFrame", dst = {
				{x = RESULT_BASE.SUB_POS_X, y = posY, w = 665, h = 210},
			}
		})
		-- 接続先リポジトリ
		table.insert(parts.destination, {
			id = "repositoryname", dst = {
				{x = RESULT_BASE.SUB_POS_X + 645, y = posY + 15, w = 655, h = 25},
			}
		})

		-- op606: IR_WAITING
		-- IR更新中
		do
			local posX = {105, 437}
			for i = 1, 2, 1 do
				table.insert(parts.destination, {
					id = "IrLoading", loop = 0, timer = timer_util.timer_observe_boolean(function() return irLoading() end), dst = {
						{time = 0, x = RESULT_BASE.SUB_POS_X + posX[i], y = posY + 64, w = 89, h = 19},
						{time = 1000, a = 100},
						{time = 2000, a = 255},
					}
				})
			end
		end

		-- IR順位を更新した時(上位10%でない)
		table.insert(parts.destination, {
			id = "irPrevMyRank", loop = 500, timer = timer_util.timer_observe_boolean(function() return irRankUpdate() end), op = {-MAIN.OP.IR_WAITING}, dst = {
				{time = 0, x = RESULT_BASE.SUB_POS_X + 30, y = posY + 48, w = 44, h = 60, a = 255},
				{time = 500, y = posY + 24, a = 0}
			}
		})
		table.insert(parts.destination, {
			id = "irMyRank", loop = 500, timer = timer_util.timer_observe_boolean(function() return irRankUpdate() end), op = {-MAIN.OP.IR_WAITING}, dst = {
				{time = 0, x = RESULT_BASE.SUB_POS_X + 30, y = posY + 72, w = 44, h = 60, a = 0},
				{time = 500, y = posY + 48, a = 255}
			}
		})

		-- IR順位に変化なし(上位10％でない)
		table.insert(parts.destination, {
			id = "irMyRank", timer = timer_util.timer_observe_boolean(function() return irRankNoupdate() end), op = {-MAIN.OP.IR_WAITING}, dst = {
				{x = RESULT_BASE.SUB_POS_X + 30, y = posY + 48, w = 44, h = 60}
			}
		})

		-- IR順位を更新した時（上位10％）
		table.insert(parts.destination, {
			id = "irPrevMyRank", loop = 500, timer = timer_util.timer_observe_boolean(function() return irRankTop10PerInUpdate() end), op = {-MAIN.OP.IR_WAITING}, dst = {
				{time = 0, x = RESULT_BASE.SUB_POS_X + 30, y = posY + 48, w = 44, h = 60, a = 255},
				{time = 500, y = posY + 24, a = 0}
			}
		})
		table.insert(parts.destination, {
			id = "irEliteRank", loop = 500, timer = timer_util.timer_observe_boolean(function() return irRankTop10PerInUpdate() end), op = {-MAIN.OP.IR_WAITING}, dst = {
				{time = 0, x = RESULT_BASE.SUB_POS_X + 30, y = posY + 72, w = 44, h = 60, a = 0},
				{time = 500, y = posY + 48, a = 255}
			}
		})

		-- IR順位に変化なし（上位10％）
		table.insert(parts.destination, {
			id = "irEliteRank", timer = timer_util.timer_observe_boolean(function() return irRankTop10PerInNoUpdate() end), op = {-MAIN.OP.IR_WAITING}, dst = {
				{x = RESULT_BASE.SUB_POS_X + 30, y = posY + 48, w = 44, h = 60}
			}
		})

		-- 更新前と更新後の差分
		table.insert(parts.destination, {
			id = "irRankDiff", draw = function()
				return CUSTOM.NUM.irRankDiff() ~= 0
			end, dst = {
				{x = RESULT_BASE.SUB_POS_X + 80, y = posY + 15, w = 22, h = 25}
			}
		})

		-- 全体人数
		table.insert(parts.destination, {
			id = "irTotalPlayer", timer = MAIN.TIMER.IR_CONNECT_SUCCESS, dst = {
				{x = RESULT_BASE.SUB_POS_X + 365, y = posY + 48, w = 44, h = 60},
			}
		})

		-- 順位を更新した
		-- op334 : UPDATE_IRRANK
		table.insert(parts.destination, {
			id = "IrOvertake", loop = 1300, timer = timer_util.timer_observe_boolean(function() return irRankUpdate2() end), dst = {
				{time = 700, x = RESULT_BASE.SUB_POS_X - 95, y = posY + 35, w = 142 * 2, h = 142 * 2, a = 0},
				{time = 1300, x = RESULT_BASE.SUB_POS_X - 23, y = posY + 107, w = 142, h = 142, a = 255},
			}
		})
	end

	-- ランキングトップ10-----------------------------------------------------
	local irFramePoxY = 70
	table.insert(parts.destination, {
		id = "irTopFrame", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
			{x = RESULT_BASE.SUB_POS_X, y = irFramePoxY, w = 665, h = 714},
		}
	})
	-- 見出し
	table.insert(parts.destination, {
		id = "irTop10Label", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
			{x = RESULT_BASE.SUB_POS_X + 11, y = irFramePoxY + 663, w = 234, h = 43},
		}
	})
	table.insert(parts.destination, {
		id = "irClearLabelRect", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
			{x = RESULT_BASE.SUB_POS_X + 11, y = irFramePoxY + 663, w = 234, h = 43},
		}, mouseRect = {x = 0, y = 0, w = 234, h = 43}
	})

	table.insert(parts.destination, {
		id = "screenShot", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
			{x = RESULT_BASE.SUB_POS_X + 265, y = irFramePoxY + 663, w = 43, h = 43},
		}
	})

	-- マイベストからの差分ラベル
	table.insert(parts.destination, {
		id = "irRivaltypeMybestdif", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
			{x = RESULT_BASE.SUB_POS_X + 480, y = irFramePoxY + 663, w = 167, h = 43},
		}
	})

	do
		local posY = {}
		local initPosY = irFramePoxY + 607
		for i = 1, 10, 1 do
			posY[i] = initPosY
			initPosY = initPosY - 65
		end
		for i = 1, 10, 1 do
			-- 自分の場合は枠を追加
			table.insert(parts.destination, {
				id = "irMyPositionFrame", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), draw = function()
					return CUSTOM.OP.isMyFrame(i)
				end, dst = {
					{x = RESULT_BASE.SUB_POS_X + 6, y = posY[i] - 19, w = 655, h = 74},
				}
			})
			-- ライバルのランプ状況
			table.insert(parts.destination, {
				id = "clearTypeIr" ..i, timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
					{time = 0, x = RESULT_BASE.SUB_POS_X + 4, y = posY[i] - 20, w = 38, h = 76},
					{time = 3000, a = 200},
					{time = 5000, a = 255}
				}
			})
			-- 順位
			table.insert(parts.destination, {
				id = "indexIr" ..i, dst = {
					{x = RESULT_BASE.SUB_POS_X + 40, y = posY[i] + 8, w = 17, h = 20, r = 201, g = 255, b = 9},
				}
			})
			-- ライバルネーム
			-- 自分の場合は色を変化
			table.insert(parts.destination, {
				id = "irRankName"..i, timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), draw = function()
					return CUSTOM.OP.isMyFrame(i)
				end,
				dst = {
						{x = RESULT_BASE.SUB_POS_X + 160, y = posY[i], w = 170, h = 30, r = 255, g = 161, b = 3},
				}
			})
			table.insert(parts.destination, {
				id = "irRankName"..i, timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), draw = function()
					return not CUSTOM.OP.isMyFrame(i)
				end,
				dst = {
						{x = RESULT_BASE.SUB_POS_X + 160, y = posY[i], w = 170, h = 30},
				}
			})
			-- ライバルのEXSCORE
			table.insert(parts.destination,{
				id = "exscoreIr"..i, timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), draw = function()
					return CUSTOM.OP.isMyFrame(i)
				end,
				dst = {
					{x = RESULT_BASE.SUB_POS_X + 330, y = posY[i] + 3, w = 28, h = 36, r = 255, g = 161, b = 3},
				}
			})
			table.insert(parts.destination,{
				id = "exscoreIr"..i, timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), draw = function()
					return not CUSTOM.OP.isMyFrame(i)
				end,
				dst = {
					{x = RESULT_BASE.SUB_POS_X + 330, y = posY[i] + 3, w = 28, h = 36},
				}
			})
			-- 自己ベとの差分
			table.insert(parts.destination,{
				id = "exscoreIrDiff"..i, timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), draw = function()
					return not CUSTOM.OP.isMyFrame(i) and main_state.number(379 + i) ~= -2147483648
				end,
				dst = {
					{x = RESULT_BASE.SUB_POS_X + 475, y = posY[i] + 3, w = 28, h = 36},
				}
			})
		end
	end
	-- スクショ用隠し（スクショボタンを押された場合に表示を切り替える）
	table.insert(parts.destination, {
		id = "irTop10Cover", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), draw = screenHidden.get, dst = {
			{x = RESULT_BASE.SUB_POS_X + 150, y = irFramePoxY + 10, w = 512, h = 645},
		}
	})
	-- スクロールバー
	table.insert(parts.destination, {
		id = "scrollBarFrame", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
			{x = RESULT_BASE.SCROLLBAR_POS_X, y = irFramePoxY, w = 28, h = 714},
		}
	})
	table.insert(parts.destination, {
		id = "scrollBar", timer = timer_util.timer_observe_boolean(function() return irMenuRanking(isIrRanking) end), dst = {
			{time = 0, x = RESULT_BASE.SCROLLBAR_POS_X, y = irFramePoxY + 650, w = 28, h = 70},
			{time = 1000, a = 150},
			{time = 2000, a = 255}
		}
	})

	-- IRクリア状況
	table.insert(parts.destination, {
		id = "irClearFrame", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
			{x = RESULT_BASE.SUB_POS_X, y = irFramePoxY, w = 665, h = 714},
		}
	})
	-- 見出し
	table.insert(parts.destination, {
		id = "irClearLabel", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
			{x = RESULT_BASE.SUB_POS_X + 11, y = irFramePoxY + 663, w = 234, h = 43},
		}
	})
	table.insert(parts.destination, {
		id = "irTop10LabelRect", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
			{x = RESULT_BASE.SUB_POS_X + 11, y = irFramePoxY + 663, w = 234, h = 43},
		}, mouseRect = {x = 0, y = 0, w = 234, h = 43}
	})
	do
		-- IR全体のクリア状況
		local graphLenght = 634
		local wd = {"max", "perfect", "fullcombo", "exhard", "hard", "normal", "easy", "assist", "lassist", "failed", "noplay"}
		local val = {MAIN.NUM.IR_PLAYER_MAX_RATE, MAIN.NUM.IR_PLAYER_PERFECT_RATE, MAIN.NUM.IR_PLAYER_FULLCOMBO_RATE, MAIN.NUM.IR_PLAYER_EXHARD_RATE, MAIN.NUM.IR_PLAYER_HARD_RATE, MAIN.NUM.IR_PLAYER_NORMAL_RATE, MAIN.NUM.IR_PLAYER_EASY_RATE, MAIN.NUM.IR_PLAYER_ASSIST_RATE, MAIN.NUM.IR_PLAYER_LIGHTASSIST_RATE, MAIN.NUM.IR_PLAYER_FAILED_RATE, MAIN.NUM.IR_PLAYER_NOPLAY_RATE}

		local posY = 1370
		-- グラフバーの登録
		for i = 1, 11, 1 do
			table.insert(parts.graph, {
				id = "s_bar" ..wd[i], src = 2, x = 1335, y = posY, w = graphLenght, h = 49, angle = 0, value = function()
					local rate = main_state.number(val[i])
					if rate == -2147483648 then
						return 0
					else
						-- 1は100％を表す
						return rate / 100
					end
				end
			})
			posY = posY + 49
		end
		-- グラフ描画
		local dstPosY = 673
		for i = 1, 11, 1 do
			table.insert(parts.destination, {
				id = "s_bar" ..wd[i], blend = MAIN.BLEND.ADDITION, loop = 500, timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
					{time = 0, x = RESULT_BASE.SUB_POS_X + 15, y = dstPosY, w = 0, h = 49, acc = MAIN.ACC.DECELERATE},
					{time = 500, w = graphLenght}
				}
			})
			dstPosY = dstPosY - 59
		end
	end

	do
		-- クリアタイプのレート
		local wd = {"max", "perfect", "fullcombo", "exhard", "hard", "normal", "easy", "assist", "lassist", "failed", "noplay"}
		local clearTypeNumRef = {
			MAIN.NUM.IR_PLAYER_MAX,
			MAIN.NUM.IR_PLAYER_PERFECT,
			MAIN.NUM.IR_PLAYER_FULLCOMBO,
			MAIN.NUM.IR_PLAYER_EXHARD,
			MAIN.NUM.IR_PLAYER_HARD,
			MAIN.NUM.IR_PLAYER_NORMAL,
			MAIN.NUM.IR_PLAYER_EASY,
			MAIN.NUM.IR_PLAYER_ASSIST,
			MAIN.NUM.IR_PLAYER_LIGHTASSIST,
			MAIN.NUM.IR_PLAYER_FAILED,
			MAIN.NUM.IR_PLAYER_NOPLAY
		}
		local clearTypeRateRef = {
			MAIN.NUM.IR_PLAYER_MAX_RATE,
			MAIN.NUM.IR_PLAYER_PERFECT_RATE,
			MAIN.NUM.IR_PLAYER_FULLCOMBO_RATE,
			MAIN.NUM.IR_PLAYER_EXHARD_RATE,
			MAIN.NUM.IR_PLAYER_HARD_RATE,
			MAIN.NUM.IR_PLAYER_NORMAL_RATE,
			MAIN.NUM.IR_PLAYER_EASY_RATE,
			MAIN.NUM.IR_PLAYER_ASSIST_RATE,
			MAIN.NUM.IR_PLAYER_LIGHTASSIST_RATE,
			MAIN.NUM.IR_PLAYER_FAILED_RATE,
			MAIN.NUM.IR_PLAYER_NOPLAY_RATE
		}
		local clearTypeAfterdotRateRef = {
			MAIN.NUM.IR_PLAYER_MAX_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_PERFECT_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_FULLCOMBO_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_EXHARD_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_HARD_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_NORMAL_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_EASY_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_ASSIST_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_LIGHTASSIST_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_FAILED_RATE_AFTERDOT,
			MAIN.NUM.IR_PLAYER_NOPLAY_RATE_AFTERDOT
		}
		for i = 1, 11, 1 do
			table.insert(parts.value, {
				id = "s_" ..wd[i] .."num", src = 4, x = 440, y = 60, w = 341, h = 36, divx = 11, digit = 4, align = 0, ref = clearTypeNumRef[i]
			})
			table.insert(parts.value, {
				id = "s_" ..wd[i] .."rate", src = 4, x = 440, y = 60, w = 310, h = 36, divx = 10, digit = 3, align = 0, ref = clearTypeRateRef[i]
			})
			table.insert(parts.value, {
				id = "s_" ..wd[i] .."rateAfterdot", src = 4, x = 440, y = 60, w = 310, h = 36, divx = 10, digit = 1, align = 0, ref = clearTypeAfterdotRateRef[i]
			})
		end
		local ratePosY = 680
		for i = 1, 11, 1 do
			table.insert(parts.destination, {
				id = "s_" ..wd[i] .."num", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
					{x = RESULT_BASE.SUB_POS_X + 30, y = ratePosY, w = 31, h = 36},
				}
			})
			table.insert(parts.destination, {
				id = "s_" ..wd[i] .."rate", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
					{x = RESULT_BASE.SUB_POS_X + 445, y = ratePosY, w = 31, h = 36},
				}
			})
			table.insert(parts.destination, {
				id = "s_" ..wd[i] .."rateAfterdot", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
					{x = RESULT_BASE.SUB_POS_X + 546, y = ratePosY, w = 31, h = 36},
				}
			})
			table.insert(parts.destination, {
				id = "irMyPositionFrame2", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), draw = function()
					return CUSTOM.NUM.mybestClearType() == i
				end, dst = {
					{x = RESULT_BASE.SUB_POS_X + 1, y = ratePosY - 20, w = 661, h = 75},
				}
			})
			ratePosY = ratePosY - 59
		end
	end
	-- 文字
	table.insert(parts.destination, {
		id = "irClearFrame2", timer = timer_util.timer_observe_boolean(function() return irMenuClear(isIrClear) end), dst = {
			{x = RESULT_BASE.SUB_POS_X, y = irFramePoxY + 7, w = 665, h = 648},
		}
	})
	
	return parts
end

return {
	load = load
}