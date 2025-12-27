--[[
	これまでのプレイ状況と選択した曲のTOTAL値などを表示
	@author : KASAKO
--]]
local base = {posX = 10, posY = 10}

local function frame(parts)
	table.insert(parts.image, {id = "info-frame", src = 5, x = 2401, y = 312, w = 429, h = 194})
	table.insert(parts.destination, {
		id = "info-frame", dst = {
			{x = base.posX, y = base.posY, w = 429, h = 194},
		}
	})
end
local function info(parts)
	table.insert(parts.image, {id = "info-frame2", src = 5, x = 2100, y = 10, w = 180, h = 190})
	table.insert(parts.image, {id = "info-frame3", src = 5, x = 2100, y = 210, w = 270, h = 190})


	-- これまで叩いたノート数
	table.insert(parts.value,{id = "totalplaynotes", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 10, ref = 333})
	-- これまで叩いたピカグレ
	table.insert(parts.value,{id = "totalpgreat", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 10, ref = 33})
	-- これまで叩いたグレート
	table.insert(parts.value,{id = "totalgreat", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 10, ref = 34})
	-- これまで叩いたgood
	table.insert(parts.value,{id = "totalgood", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 10, ref = 35})
	-- これまで叩いたbad
	table.insert(parts.value,{id = "totalbad", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 10, ref = 36})
	-- これまで叩いたpoor
	table.insert(parts.value,{id = "totalpoor", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 10, ref = 37})
	-- 総ノート数
	table.insert(parts.value,{id = "totalnotes", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = 74, align = 1})
	-- 曲の長さ（分）
	table.insert(parts.value,{id = "songlen-min", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 2, ref = 1163})
	-- 曲の長さ（秒）
	table.insert(parts.value,{id = "songlen-sec", src = 5, x = 2401, y = 525, w = 242, h = 15, divx = 11, digit = 2, ref = 1164})
	-- プレイ数
	table.insert(parts.value,{id = "playcount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 4, ref = 77})
	-- TOTAL値
	table.insert(parts.value,{id = "total", src = 5, x = 2401, y = 510, w = 220, h = 15, divx = 10, digit = 4, ref = 368, align = 1})
	-- 現在のIR順位
	table.insert(parts.value,{id = "ir_rank", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 5, ref = 179})
	-- IR参加人数
	table.insert(parts.value,{id = "ir_totalplayer", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 5, ref = 180})
	-- IRクリアレート
	table.insert(parts.value,{id = "ir_clearrate", src = 5, x = 2401, y = 510, w = 220, h = 15, divx = 10, digit = 3, ref = 181})

	table.insert(parts.destination, {
		id = "info-frame2", op = {-MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 7, y = base.posY + 2, w = 180, h = 190},
		}
	})
	table.insert(parts.destination, {
		id = "totalplaynotes", op = {-MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 200, y = base.posY + 166, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "totalpgreat", op = {-MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 200, y = base.posY + 136, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "totalgreat", op = {-MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 200, y = base.posY + 104, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "totalgood", op = {-MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 200, y = base.posY + 73, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "totalbad", op = {-MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 200, y = base.posY + 41, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "totalpoor", op = {-MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 200, y = base.posY + 11, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "info-frame3", op = {MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 7, y = base.posY + 2, w = 270, h = 190},
		}
	})
	table.insert(parts.destination, {
		id = "totalnotes", op = {MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 140, y = base.posY + 167, w = 20, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "songlen-min", op = {MAIN.OP.SONGBAR}, dst = {
			{ x = base.posX + 140, y = base.posY + 105, w = 20, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "songlen-sec", op = {MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 203, y = base.posY + 105, w = 20, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "playcount", op = {MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 140, y = base.posY + 75, w = 20, h = 15},
		}
	})
end
local function totalGraph(parts)
	table.insert(parts.image, {id = "totalFrame", src = 5, x = 2800, y = 0, w = 186, h = 24})
	table.insert(parts.image, {id = "totalFrameInfoLow", src = 5, x = 2800, y = 24, w = 93, h = 16})
	table.insert(parts.image, {id = "totalFrameInfoHigh", src = 5, x = 2893, y = 24, w = 93, h = 16})
	table.insert(parts.graph, {
		id = "gr_totalLow", src = 5, x = 2800, y = 58, w = 180, h = 18, angle = 0, value = function()
			local calcNum = CUSTOM.NUM.calcTotal()
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			local dValue = (50 + (totalNum - calcNum) / 2) / 100
			if dValue >= 1 then
				return 0.99
			elseif dValue <= 0 then
				return 0.01
			else
				return dValue
			end
		end
	})
	table.insert(parts.graph, {
		id = "gr_totalHigh", src = 5, x = 2800, y = 40, w = 180, h = 18, angle = 0, value = function()
			local calcNum = CUSTOM.NUM.calcTotal()
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			-- 偏差値
			return (50 + (totalNum - calcNum) / 2) / 100
		end
	})

	-- トータルゲージ計算機の値からのズレで色を変化させる
	-- 計算値より高い：かんたん
	table.insert(parts.destination, {
		id = "total", draw = function()
			local calcNum = CUSTOM.NUM.calcTotal() - 20
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			return main_state.option(MAIN.OP.SONGBAR) and (calcNum < totalNum)
		end, dst = {
			{x = base.posX + 140, y = base.posY + 136, w = 20, h = 15, r = 0, g = 120, b = 255},
		}
	})
	-- 計算値より低い：難しい
	table.insert(parts.destination, {
		id = "total", draw = function()
			local calcNum = CUSTOM.NUM.calcTotal() + 20
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			return main_state.option(MAIN.OP.SONGBAR) and (calcNum >= totalNum)
		end, dst = {
			{x = base.posX + 140, y = base.posY + 136, w = 20, h = 15, r = 255, g = 120, b = 0},
		}
	})
	-- 計算値より-20 ~ +20：ふつう
	table.insert(parts.destination, {
		id = "total", draw = function()
			local calcNumMin = CUSTOM.NUM.calcTotal() - 20
			local calcNumMax = CUSTOM.NUM.calcTotal() + 20
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			return main_state.option(MAIN.OP.SONGBAR) and (calcNumMin <= totalNum) and (calcNumMax >= totalNum)
		end, dst = {
			{x = base.posX + 140, y = base.posY + 136, w = 20, h = 15},
		}
	})

	local tPosY = 133
	table.insert(parts.destination, {
		id = "totalFrame", op = {MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 230, y = base.posY + tPosY, w = 186, h = 24},
		}
	})
	table.insert(parts.destination, {
		id = "gr_totalLow", blend = MAIN.BLEND.ADDITION, draw = function()
			local calcNum = CUSTOM.NUM.calcTotal()
			local totalNum = main_state.number(368)
			return main_state.option(MAIN.OP.SONGBAR) and (calcNum >= totalNum)
		end, dst = {
			{x = base.posX + 233, y = base.posY + tPosY + 3, w = 180, h = 18},
		}
	})
	table.insert(parts.destination, {
		id = "gr_totalHigh", blend = MAIN.BLEND.ADDITION, draw = function()
			local calcNum = CUSTOM.NUM.calcTotal()
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			return main_state.option(MAIN.OP.SONGBAR) and (calcNum < totalNum)
		end, dst = {
			{x = base.posX + 233, y = base.posY + tPosY + 3, w = 180, h = 18},
		}
	})
	table.insert(parts.destination, {
		id = "totalFrameInfoLow", draw = function()
			local calcNum = CUSTOM.NUM.calcTotal()
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			return main_state.option(MAIN.OP.SONGBAR) and (calcNum >= totalNum)
		end, dst = {
			{x = base.posX + 276, y = base.posY + tPosY + 5, w = 93, h = 16},
		}
	})
	table.insert(parts.destination, {
		id = "totalFrameInfoHigh", draw = function()
			local calcNum = CUSTOM.NUM.calcTotal()
			local totalNum = main_state.number(MAIN.NUM.SONGGAUGE_TOTAL)
			return main_state.option(MAIN.OP.SONGBAR) and (calcNum < totalNum)
		end, dst = {
			{x = base.posX + 276, y = base.posY + tPosY + 5, w = 93, h = 16},
		}
	})
end

local function judgeLevel(parts)
	table.insert(parts.value,{id = "judge-num", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, ref = MAIN.NUM.JUDGERANK})
	table.insert(parts.image, {id = "judge-veryeasy", src = 5, x = 2835, y = 320, w = 165, h = 16})
	table.insert(parts.image, {id = "judge-easy", src = 5, x = 2835, y = 336, w = 165, h = 16})
	table.insert(parts.image, {id = "judge-normal", src = 5, x = 2835, y = 352, w = 165, h = 16})
	table.insert(parts.image, {id = "judge-hard", src = 5, x = 2835, y = 368, w = 165, h = 16})
	table.insert(parts.image, {id = "judge-veryhard", src = 5, x = 2835, y = 384, w = 165, h = 16})
	local wd = {"veryeasy", "easy", "normal", "hard", "veryhard"}
	local op = {184, 183, 182, 181, 180}
	for i = 1, 5, 1 do
		table.insert(parts.destination, {
			id = "judge-" ..wd[i], op = {op[i], MAIN.OP.SONGBAR}, dst = {
				{x = base.posX + 230, y = base.posY + 43, w = 165, h = 16},
			}
		})
	end
	table.insert(parts.destination, {
		id = "judge-num", op = {MAIN.OP.SONGBAR}, dst = {
			{x = base.posX + 140, y = base.posY + 43, w = 22, h = 15},
		}
	})
end

local function irReading(parts)
	table.insert(parts.image, {id = "offline", src = 5, x = 2100, y = 430, w = 130, h = 20})
	table.insert(parts.image, {id = "complete", src = 5, x = 2100, y = 450, w = 130, h = 20})
	-- IR読み込み時間
	table.insert(parts.value,{id = "ir_uwt", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, ref = 220})
	-- IR読み込み時間
	table.insert(parts.destination, {
		id = "ir_uwt", op = {MAIN.OP.SONGBAR, MAIN.OP.ONLINE}, dst = {
			{x = base.posX + 225, y = base.posY + 11, w = 20, h = 15}
		}
	})
	-- IR読み込み完了
	table.insert(parts.destination, {
		id = "complete", op = {MAIN.OP.SONGBAR, MAIN.OP.IR_LOADED}, dst = {
			{x = base.posX + 225, y = base.posY + 11, w = 130, h = 20}
		}
	})
	-- オフライン時
	table.insert(parts.destination, {
		id = "offline", op = {MAIN.OP.SONGBAR, MAIN.OP.OFFLINE}, dst = {
			{x = base.posX + 215, y = base.posY + 9, w = 130, h = 20},
		}
	})
end



local function load()
	local parts = {}
	parts.image = {
		{id = "loading", src = 5, x = 2100, y = 410, w = 130, h = 20}
	}
	parts.value = {}
	parts.graph = {}
	parts.destination = {}
	frame(parts)
	info(parts)
	totalGraph(parts)
	judgeLevel(parts)
	irReading(parts)
	return parts
end

return {
	load = load
}