--[[
	曲読み込み時の動作 & 練習モード設定中
	@author : KASAKO
--]]

local function preInfo(parts)
	table.insert(parts.image, {id = "emblem", src = 1, x = 0, y = 1260, w = 996, h = 74})
	-- STAGEFILEがある場合はうっすらと背景に
	table.insert(parts.destination, {
		id = MAIN.IMAGE.STAGEFILE, loop = 750, op = {MAIN.OP.NOW_LOADING, MAIN.OP.STAGEFILE}, filter = MAIN.FILTER.OFF, stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, dst = {
			{time = 500, x = BASE.infoPositionX + 36, y = 330, w = 1280, h = 560, a = 0},
			{time = 750, a = 50}
		}
	})
	-- BACKBMPがある場合は優先（タイトル、ジャンル、アーティストは消す）
	table.insert(parts.destination,	{
		id = MAIN.IMAGE.BACKBMP, loop = 750, op = {MAIN.OP.NOW_LOADING, MAIN.OP.BACKBMP}, blend = MAIN.BLEND.ADDITION, stretch = MAIN.STRETCH.FIT_INNER, dst = {
			{time = 500, x = BASE.infoPositionX + 36, y = 330, w = 1280, h = 560, a = 0},
			{time = 750, a = 255}
		}
	})
	-- エンブレム
	table.insert(parts.destination,	{
		id = "emblem", loop = 750, blend = MAIN.BLEND.ADDITION, op = {MAIN.OP.NOW_LOADING}, dst = {
			{time = 500, x = BASE.infoPositionX + 180, y = 913, w = 996, h = 74, a = 0},
			{time = 750, a = 255}
		}
	})
	-- ジャンル（ロード中）
	table.insert(parts.destination,	{
		id = "pregenre", loop = 750, op = {MAIN.OP.NOW_LOADING, MAIN.OP.NO_BACKBMP}, dst = {
			{time = 500, x = BASE.infoPositionX + 680, y = 790, w = 1200, h = 40, a = 0},
			{time = 750, a = 255}
		}
	})
	-- タイトル（ロード中）
	table.insert(parts.destination,	{
		id = "pretitle", loop = 750, op = {MAIN.OP.NOW_LOADING, MAIN.OP.NO_BACKBMP}, dst = {
			{time = 500, x = BASE.infoPositionX + 680, y = 600, w = 1200, h = 90, a = 0},
			{time = 750, a = 255}
		}
	})
	-- タイトル（ロード完了）
	table.insert(parts.destination,	{
		id = "pretitle", timer = MAIN.TIMER.READY, loop = -1, op = {MAIN.OP.LOADED, MAIN.OP.NO_BACKBMP}, dst = {
			{time = 0, x = BASE.infoPositionX + 680, y = 600, w = 1200, h = 90, a = 255},
			{time = 500, a = 0}
		}
	})
	-- アーティスト（ロード中）
	table.insert(parts.destination,	{
		id = "preartist", loop = 750, op = {MAIN.OP.NOW_LOADING, MAIN.OP.NO_BACKBMP}, dst = {
			{time = 500, x = BASE.infoPositionX + 680, y = 430, w = 1200, h = 40, a = 0},
			{time = 750, a = 255}
		}
	})
end

local function information(parts)
	table.insert(parts.image, {id = "preautoinfo", src = 1, x = 0, y = 1050, w = 801, h = 108})
	-- オート中、リプレイ中のみ倍速可能のお知らせ
	if PROPERTY.isAutoplayInfoOn() and PROPERTY.isDetailInfoSwitchOff() then
		table.insert(parts.destination,	{
			id = "preautoinfo", op = {MAIN.OP.AUTOPLAYON, MAIN.OP.LOADED}, dst = {
				{time = 0, x = BASE.infoPositionX + 276, y = 890, w = 801, h = 108},
				{time = 1000, a = 150},
				{time = 2000, a = 255}
			}
		})
		table.insert(parts.destination,	{
			id = "preautoinfo", op = {MAIN.OP.REPLAY_PLAYING, MAIN.OP.LOADED}, dst = {
				{time = 0, x = BASE.infoPositionX + 276, y = 890, w = 801, h = 108},
				{time = 1000, a = 150},
				{time = 2000, a = 255}
			}
		})
	end
end

local function songInformation(parts)
	local loadingWindowPosX = BASE.playsidePositionX + 70
	local loadingWindowPosY = 420
	local op = {-MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.LANECOVER1_CHANGING}
	local alpha = {255, 0}
	table.insert(parts.image, {id = "loadingwindow", src = 1, x = 1200, y = 410, w = 380, h = 311})
	table.insert(parts.image, {id = "loading_barframe", src = 1, x = 700, y = 950, w = 304, h = 30})
	table.insert(parts.image, {id = "loading_notesinfo", src = 1, x = 1500, y = 730, w = 184, h = 86})
	table.insert(parts.judgegraph, {id = "notesgraph", type = MAIN.JUDGEGRAPH.TYPE.NOTES})
	table.insert(parts.graph, {id = "loading_bar", src = 1, x = 700, y = 1000, w = 300, h = 26, angle = 2, type = MAIN.GRAPH.LOAD_PROGRESS})
	-- ロード状況％
	table.insert(parts.value, {id = "loading_par", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 3, ref = MAIN.NUM.LOADING_PROGRESS, align = MAIN.N_ALIGN.LEFT})
	-- 総ノート数（鍵盤のみ）
	table.insert(parts.value, {id = "totalnote-normal", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_NORMAL})
	-- 総皿
	table.insert(parts.value, {id = "totalnote-scr", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_SCRATCH})
	-- 総LN
	table.insert(parts.value, {id = "totalnote-ln", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_LN})
	-- 総bss
	table.insert(parts.value, {id = "totalnote-bss", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_BSS})
	for i = 1, 2, 1 do
		table.insert(parts.destination,	{
			id = "loadingwindow", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX, y = loadingWindowPosY, w = 380, h = 311, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "notesgraph", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 38, y = loadingWindowPosY + 161, w = 304, h = 100, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "bpmgraph", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 38, y = loadingWindowPosY + 161, w = 304, h = 100, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "loading_notesinfo", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 48, y = loadingWindowPosY + 56, w = 184, h = 86, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "totalnote-normal", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 98, y = loadingWindowPosY + 114, w = 20, h = 20, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "totalnote-ln", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 242, y = loadingWindowPosY + 114, w = 20, h = 20, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "totalnote-scr", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 98, y = loadingWindowPosY + 65, w = 20, h = 20, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "totalnote-bss", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 242, y = loadingWindowPosY + 65, w = 20, h = 20, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "loading_barframe", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 38, y = loadingWindowPosY +12, w = 304, h = 30, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "loading_bar", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 40, y = loadingWindowPosY + 14, w = 300, h = 26, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "loading_par", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 130, y = loadingWindowPosY + 16, w = 27, h = 20, a = alpha[i]}
			}
		})
		table.insert(parts.destination,	{
			id = "per", op = {MAIN.OP.NOW_LOADING, op[i]}, offset = MAIN.OFFSET.LIFT, dst = {
				{x = loadingWindowPosX + 225, y = loadingWindowPosY + 16, w = 27, h = 18, a = alpha[i]}
			}
		})
	end
	-- ロード完了時はフェードアウト
	table.insert(parts.destination,	{
		id = "loadingwindow", timer = MAIN.TIMER.READY, offset = MAIN.OFFSET.LIFT, loop = -1, dst = {
			{time = 0, x = loadingWindowPosX, y = loadingWindowPosY, w = 380, h = 311},
			{time = 200, y = loadingWindowPosY - 10, a = 0}
		}
	})
end

local function pleaseWait(parts)
	local plaseWaitX = BASE.playsidePositionX + 8
	table.insert(parts.image, {id = "loading_wd1", src = 1, x = 1200, y = 950, w = 497, h = 46})
	table.insert(parts.image, {id = "loading_wd2", src = 1, x = 1200, y = 996, w = 497, h = 46})
	-- please wait
	table.insert(parts.destination,	{
		id = "loading_wd1", op = {MAIN.OP.NOW_LOADING, -MAIN.OP.LANECOVER1_CHANGING}, offset = MAIN.OFFSET.LIFT, dst = {
			{time = 0, x = plaseWaitX, y = 320, w = 497, h = 46, acc = MAIN.ACC.ACCELERATION},
			{time = 1000, a = 120},
			{time = 2000, a = 255}
		}
	})
	-- good ruck
	table.insert(parts.destination,	{
		id = "loading_wd2", op = {MAIN.OP.LOADED}, loop = 1000, timer = MAIN.TIMER.READY, offset = MAIN.OFFSET.LIFT, dst = {
			{time = 0, x = plaseWaitX, y = 320, w = 497, h = 46, acc = MAIN.ACC.ACCELERATION},
			{time = 1000, y = 300, a = 0}
		}
	})
end

local function practice(parts)
	-- 練習時用のBGA
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, op = {MAIN.OP.STATE_PRACTICE}, dst = {
			{x = BASE.infoPositionX + 28, y = 281, w = 1296, h = 737},
		}
	})
	table.insert(parts.destination, {
		id = "bga", stretch = MAIN.STRETCH.FIT_OUTER_TRIMMED, op = {MAIN.OP.STATE_PRACTICE}, dst = {
			{x = BASE.infoPositionX + 28, y = 281, w = 1296, h = 737}
		}
	})
end

local function load()
	local parts = {}
	parts.image = {}
	parts.value = {}
	parts.graph = {}
	parts.judgegraph = {}
	parts.destination = {}
	preInfo(parts)
	information(parts)
	songInformation(parts)
	pleaseWait(parts)
	practice(parts)
	return parts
end

return {
	load = load
}