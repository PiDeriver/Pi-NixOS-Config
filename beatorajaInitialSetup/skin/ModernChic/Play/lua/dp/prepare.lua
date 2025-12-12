--[[
	曲読み込み時,practiceモード待機時
	@author : KASAKO
--]]

local function songInformation(parts)
	local loadingWindowPosX = {BASE.laneLeftPosX + 70, BASE.laneRightPosX + 70}
	local loadingWindowPosY = 420
	local plaseWaitX = {BASE.laneLeftPosX + 8, BASE.laneRightPosX + 8}
	local centerPosX = BASE.laneLeftPosX + (1164 / 2)

	local op = {-MAIN.OP.LANECOVER1_CHANGING, MAIN.OP.LANECOVER1_CHANGING}
	local alpha1 = {0, 255}
	local alpha2 = {255, 0}
	local alpha3 = {100, 0}
	local RGB = {255, 255, 255}

	table.insert(parts.judgegraph, {id = "notesgraph", type = MAIN.JUDGEGRAPH.TYPE.NOTES})
	table.insert(parts.graph, {id = "loading_bar", src = 1, x = 1050, y = 150, w = 300, h = 26, angle = 2, type = MAIN.GRAPH.LOAD_PROGRESS})
	table.insert(parts.image, {id = "loading_wd1", src = 1, x = 1100, y = 220, w = 510, h = 60})
	table.insert(parts.image, {id = "loading_wd2", src = 1, x = 1100, y = 280, w = 510, h = 60})
	table.insert(parts.image, {id = "loadingwindow", src = 1, x = 720, y = 220, w = 380, h = 311})
	table.insert(parts.image, {id = "loading_notesinfo", src = 1, x = 1100, y = 340, w = 184, h = 86})
	table.insert(parts.image, {id = "emblem", src = 1, x = 380, y = 680, w = 996, h = 74})
	table.insert(parts.image, {id = "loading_barframe", src = 1, x = 1050, y = 120, w = 304, h = 30})
	table.insert(parts.value, {id = "loading_par", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 3, ref = MAIN.NUM.LOADING_PROGRESS, align = 1})
	table.insert(parts.value, {id = "totalnote-normal", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_NORMAL})
	table.insert(parts.value, {id = "totalnote-scr", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_SCRATCH})
	table.insert(parts.value, {id = "totalnote-ln", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_LN})
	table.insert(parts.value, {id = "totalnote-bss", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTE_BSS})

	for i = 1, 2, 1 do
		-- please wait
		table.insert(parts.destination,	{
			id = "loading_wd1", op = {MAIN.OP.NOW_LOADING, -MAIN.OP.LANECOVER1_CHANGING}, offset = MAIN.OFFSET.LIFT, dst = {
				{time = 0, x = plaseWaitX[i], y = 320, w = 510, h = 60, acc = MAIN.ACC.ACCELERATION, a = 140},
				{time = 1000, a = 80},
				{time = 2000, a = 140}
			}
		})
		-- good ruck
		table.insert(parts.destination,	{
			id = "loading_wd2", op = {MAIN.OP.LOADED}, loop = 1000, timer = MAIN.TIMER.READY, offset = MAIN.OFFSET.LIFT, dst = {
				{time = 0, x = plaseWaitX[i], y = 320, w = 510, h = 60, acc = MAIN.ACC.ACCELERATION},
				{time = 1000, y = 300, a = 0}
			}
		})
	end
	for i = 1, 2, 1 do
		for j = 1, 2, 1 do
			--[[ プレビュー機能追加のため保留
			table.insert(parts.destination,	{
				id = "loadingwindow", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i], y = loadingWindowPosY, w = 380, h = 311, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "notesgraph", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 38, y = loadingWindowPosY + 161, w = 304, h = 100, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "bpmgraph", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 38, y = loadingWindowPosY + 161, w = 304, h = 100, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "loading_notesinfo", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 48, y = loadingWindowPosY + 56, w = 184, h = 86, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "totalnote-normal", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 98, y = loadingWindowPosY + 114, w = 20, h = 20, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "totalnote-ln", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 242, y = loadingWindowPosY + 114, w = 20, h = 20, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "totalnote-scr", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 98, y = loadingWindowPosY + 65, w = 20, h = 20, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "totalnote-bss", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 242, y = loadingWindowPosY + 65, w = 20, h = 20, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "loading_barframe", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 38, y = loadingWindowPosY +12, w = 304, h = 30, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "loading_bar", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 40, y = loadingWindowPosY + 14, w = 300, h = 26, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "loading_par", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 130, y = loadingWindowPosY + 16, w = 24, h = 20, a = alpha1[j]}
				}
			})
			table.insert(parts.destination,	{
				id = "per", op = {MAIN.OP.NOW_LOADING, op[j]}, offset = MAIN.OFFSET.LIFT, dst = {
					{x = loadingWindowPosX[i] + 225, y = loadingWindowPosY + 16, w = 24, h = 18, a = alpha1[j]}
				}
			})
			]]

			-- BACKBMP(-101)がある場合は優先（タイトル、ジャンル、アーティストは消す）
			-- stretch:1 アスペクト比を保ちつつ描画先の範囲に収まるように伸縮する
			table.insert(parts.destination,	{
				id = MAIN.IMAGE.BACKBMP, op = {MAIN.OP.NOW_LOADING, MAIN.OP.BACKBMP, op[j]}, filter = MAIN.FILTER.OFF, stretch = MAIN.STRETCH.FIT_INNER, dst = {
					{x = BASE.laneLeftPosX, y = 400, w = 1164, h = 500, a = alpha3[j]}
				}
			})
				
			-- エンブレム
			table.insert(parts.destination,	{
				id = "emblem", op = {MAIN.OP.NOW_LOADING, op[j]}, dst = {
					{x = BASE.laneLeftPosX + 84, y = 914, w = 996, h = 74, a = alpha2[j]}
				}
			})
			-- ジャンル
			table.insert(parts.destination,	{
				id = "pregenre", filter = MAIN.FILTER.OFF, op = {MAIN.OP.NOW_LOADING, op[j]}, dst = {
					{x = centerPosX, y = 790, w = 1164, h = 40, a = alpha2[j], r = RGB[1], g = RGB[2], b = RGB[3]}
				}
			})
			-- タイトル
			table.insert(parts.destination,	{
				id = "pretitle", filter = MAIN.FILTER.OFF, op = {MAIN.OP.NOW_LOADING, op[j]}, dst = {
					{x = centerPosX, y = 600, w = 1164, h = 90, a = alpha2[j], r = RGB[1], g = RGB[2], b = RGB[3]}
				}
			})
			-- アーティスト
			table.insert(parts.destination,	{
				id = "preartist", filter = MAIN.FILTER.OFF, op = {MAIN.OP.NOW_LOADING, op[j]}, dst = {
					{x = centerPosX, y = 430, w = 1164, h = 40, a = alpha2[j], r = RGB[1], g = RGB[2], b = RGB[3]}
				}
			})
		end
	end
end

local function information(parts)
	table.insert(parts.image, {id = "preautoinfo", src = 1, x = 720, y = 20, w = 318, h = 165})
	if PROPERTY.isAutoplayInfoOn() then
		local posx = {BASE.subPosX[1] + 7, BASE.subPosX[2] + 7}
		for i = 1, 2, 1 do
		table.insert(parts.destination,	{
			id = "preautoinfo", op = {MAIN.OP.AUTOPLAYON, MAIN.OP.LOADED}, dst = {
				{time = 0, x = posx[i], y = 773, w = 318, h = 165},
				{time = 1000, a = 150},
				{time = 2000, a = 255}
			}
		})
		table.insert(parts.destination,	{
			id = "preautoinfo", op = {MAIN.OP.REPLAY_PLAYING, MAIN.OP.LOADED}, dst = {
				{time = 0, x = posx[i], y = 773, w = 318, h = 165},
				{time = 1000, a = 150},
				{time = 2000, a = 255}
			}
		})
		end
	end
end

local function practice(parts)
	local width = 1165
	local height = 700
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, op = {MAIN.OP.STATE_PRACTICE}, dst = {
			{x = BASE.laneLeftPosX, y = 0, w = width, h = height, a = 100},
		}
	})
	table.insert(parts.destination, {
		id = "bga", op = {MAIN.OP.STATE_PRACTICE}, dst = {
			{x = BASE.laneLeftPosX, y = 0, w = width, h = height},
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
	-- songinfoframe
	songInformation(parts)
	-- オート中、リプレイ中のみ倍速可能のお知らせ
	information(parts)
	-- practiceモード時は中央に設定画面を表示
	practice(parts)
	return parts
end

return {
	load = load
}