--[[
	グラフバー
	@author : KASAKO
--]]

local function load()
	local parts = {}
	
	local n_gr_cycle = 20000
	local graphFramePosX
	
	local lab_nowscore
	local lab_bestscore
	local lab_target
	local score_display_frame
	local white_line
	local num_exscore_player
	local num_exscore_tar
	local barA
	local barAA
	local barAAA
	local barMAX
	local barA2
	local barAA2
	local barAAA2
	local gra_now
	local gra_best
	local gra_target
	local rank
	local diffExscoreMybest
	local diffExscoreTarget
	local bar_width
	local num_align
	local direction
	
	if PROPERTY.isInfoDisplayTypeA() then
		graphFramePosX = BASE.infoPositionX + 26
	elseif PROPERTY.isInfoDisplayTypeB() then
		graphFramePosX = BASE.infoPositionX + 553
	end
	
	local graph_bg = graphFramePosX + 172
	
	if PROPERTY.isGraphbarStretchLeft() then
		lab_nowscore = graphFramePosX + 599
		lab_bestscore = graphFramePosX + 599
		lab_target = graphFramePosX + 599
		score_display_frame = graphFramePosX
		white_line = graphFramePosX + 596
		num_exscore_player = graphFramePosX + 34
		num_exscore_tar = graphFramePosX + 34
		barA = graphFramePosX + 315
		barAA = graphFramePosX + 269
		barAAA = graphFramePosX + 222
		barMAX = graphFramePosX + 174
		barA2 = graphFramePosX + 315
		barAA2 = graphFramePosX + 269
		barAAA2 = graphFramePosX + 222
		gra_now = graphFramePosX + 596
		gra_best = graphFramePosX + 596
		gra_target = graphFramePosX + 596
		rank = graphFramePosX + 514
		diffExscoreMybest = graphFramePosX + 454
		diffExscoreTarget = graphFramePosX + 454
		bar_width = -415
		num_align = MAIN.N_ALIGN.RIGHT
		direction = "l"
	elseif PROPERTY.isGraphbarStretchRight() then
		lab_nowscore = graphFramePosX
		lab_bestscore = graphFramePosX
		lab_target = graphFramePosX
		score_display_frame = graphFramePosX + 603
		white_line = graphFramePosX + 172
		num_exscore_player = graphFramePosX + 634
		num_exscore_tar = graphFramePosX + 634
		barA = graphFramePosX + 449
		barAA = graphFramePosX + 495
		barAAA = graphFramePosX + 541
		barMAX = graphFramePosX + 548
		barA2 = graphFramePosX + 449
		barAA2 = graphFramePosX + 495
		barAAA2 = graphFramePosX + 541
		gra_now = graphFramePosX + 175
		gra_best = graphFramePosX + 175
		gra_target = graphFramePosX + 175
		rank = graphFramePosX + 184
		diffExscoreMybest = graphFramePosX + 179
		diffExscoreTarget = graphFramePosX + 179
		bar_width = 415
		num_align = MAIN.N_ALIGN.LEFT
		direction = "r"
	end
	
	parts.image = {
		-- スコアグラフフレーム
		{id = "infoScoregraphFrame", src = 2, x = 26, y = 926, w = 771, h = 200},
		-- グラフエリアカバー
		{id = "graphCover", src = 2, x = 0, y = 1130, w = 771, h = 198},
		-- グラフ用背景
		{id = "graph-bg", src = 25, x = 0, y = 0, w = 428, h = 183},
		{id = "bar-1", src = 22, x = 60, y = 200, w = 7, h = 185},
		{id = "bar-2", src = 22, x = 70, y = 200, w = 7, h = 185},
		{id = "bar-max-l", src = 22, x = 0, y = 200, w = 50, h = 185},
		{id = "bar-max-r", src = 22, x = 100, y = 200, w = 50, h = 185},
		{id = "label-nowscore", src = 22, x = 450, y = 0, w = 172, h = 51},
		{id = "label-bestscore", src = 22, x = 450, y = 60, w = 172, h = 51},
		{id = "label-target_flame", src = 22, x = 450, y = 120, w = 172, h = 51},
		-- ref77: btn_target
--		{id = "label-target", src = 22, x = 630, y = 0, w = 172, h = 187, divy = 11, len = 11, ref = MAIN.BUTTON.TARGET},
		{id = "now-AAA-l", src = 22, x = 450, y = 180, w = 75, h = 22},
		{id = "now-AA-l", src = 22, x = 450, y = 202, w = 75, h = 22},
		{id = "now-A-l", src = 22, x = 450, y = 224, w = 75, h = 22},
		{id = "now-B-l", src = 22, x = 450, y = 246, w = 75, h = 22},
		{id = "now-C-l", src = 22, x = 450, y = 268, w = 75, h = 22},
		{id = "now-D-l", src = 22, x = 450, y = 290, w = 75, h = 22},
		{id = "now-E-l", src = 22, x = 450, y = 312, w = 75, h = 22},
		{id = "now-F-l", src = 22, x = 450, y = 334, w = 75, h = 22},
		{id = "now-AAA-r", src = 22, x = 530, y = 180, w = 75, h = 22},
		{id = "now-AA-r", src = 22, x = 530, y = 202, w = 75, h = 22},
		{id = "now-A-r", src = 22, x = 530, y = 224, w = 75, h = 22},
		{id = "now-B-r", src = 22, x = 530, y = 246, w = 75, h = 22},
		{id = "now-C-r", src = 22, x = 530, y = 268, w = 75, h = 22},
		{id = "now-D-r", src = 22, x = 530, y = 290, w = 75, h = 22},
		{id = "now-E-r", src = 22, x = 530, y = 312, w = 75, h = 22},
		{id = "now-F-r", src = 22, x = 530, y = 334, w = 75, h = 22},
		-- スコア表示部
		{id = "score-display-frame", src = 22, x = 630, y = 190, w = 168, h = 198},
	}
	
	parts.value = {
		-- 自スコア
		{id = "num-exscore_player", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.SCORE2},
		-- ターゲットスコア
		{id = "num-exscore_tar", src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.TARGET_SCORE},
		-- マイベストとのEXSCORE差分
		-- zeropadding 1:0で埋める 2:裏0で埋める
		{id = "num-diffExscoreMybest", src = 1, x = 1400, y = 201, w = 324, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_HIGHSCORE, align = num_align},
		-- ターゲットとのEXSCORE差分
		{id = "num-diffExscoreTarget", src = 1, x = 1400, y = 201, w = 324, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_TARGETSCORE, align = num_align},
	}
	
	--110: SCORERATE
	parts.graph = {
		{id = "graph-now", src = 22, x = 0, y = 0, w = 415, h = 51, divx = 415, cycle = n_gr_cycle, type = MAIN.GRAPH.SCORERATE, angle = 0},
		{id = "graph-now-best", src = 22, x = 0, y = 0, w = 415, h = 51, divx = 415, type = MAIN.GRAPH.SCORERATE_FINAL, angle = 0},
		{id = "graph-best-bg", src = 22, x = 0, y = 60, w = 415, h = 51, type = MAIN.GRAPH.BESTSCORERATE, angle = 0},
		{id = "graph-best", src = 22, x = 0, y = 60, w = 415, h = 51, divx = 415, cycle = n_gr_cycle, type = MAIN.GRAPH.BESTSCORERATE_NOW, angle = 0},
		{id = "graph-target-bg", src = 22, x = 0, y = 120, w = 415, h = 51, type = MAIN.GRAPH.TARGETSCORERATE, angle = 0},
		{id = "graph-target", src = 22, x = 0, y = 120, w = 415, h = 51, divx = 415, cycle = n_gr_cycle, type = MAIN.GRAPH.TARGETSCORERATE_NOW, angle = 0},
	}
	
	parts.destination = {}
	
	if PROPERTY.isGraphareaCoverOff() then
		-- グラフ用フレーム
		table.insert(parts.destination, {
			id = "infoScoregraphFrame", dst = {
				{x = graphFramePosX, y = 4, w = 771, h = 200}
			}
		})
	
		-- グラフ用背景
		table.insert(parts.destination,	{id = "graph-bg", dst = {
				{x = graph_bg, y = 5, w = 428, h = 183},
			}
		})
		-- グラフ用明るさ調整
		table.insert(parts.destination,	{
			id = MAIN.IMAGE.BLACK, offset = PROPERTY.offsetGraphBrightness.num, dst = {
				{x = graph_bg, y = 5, w = 428, h = 183, a = 0},
			}
		})
		-- 現在のスコア
		table.insert(parts.destination,	{
			id = "label-nowscore", dst = {
				{x = lab_nowscore, y = 133, w = 172, h = 51},
			}
		})
		-- ベストスコア
		table.insert(parts.destination,	{
			id = "label-bestscore", dst = {
				{x = lab_bestscore, y = 80, w = 172, h = 51},
			}
		})
		
		-- ターゲット
		table.insert(parts.destination,	{
			id = "label-target_flame", dst = {
				{x = lab_target, y = 27, w = 172, h = 51},
			}
		})
		table.insert(parts.destination,	{
			id = "rivalname", dst = {
				{x = lab_target + 87, y = 38, w = 150, h = 25},
			}
		})
		
		-- スコア表示部
		table.insert(parts.destination,	{
			id = "score-display-frame", dst = {
				{x = score_display_frame, y = 4, w = 168, h = 198},
			}
		})
		
		-- 基準点の白いあの線
		table.insert(parts.destination,	{
			id = MAIN.IMAGE.WHITE, dst = {
				{x = white_line, y = 4, w = 3, h = 185},
			}
		})
		
		-- 自スコア
		table.insert(parts.destination,	{
			id = "num-exscore_player", dst = {
				{x = num_exscore_player, y = 140, w = 27, h = 20},
			}
		})
		
		-- ターゲットスコア
		table.insert(parts.destination,	{
			id = "num-exscore_tar", dst = {
				{x = num_exscore_tar, y = 40, w = 27, h = 20},
			}
		})
		
		-- 判定A
		table.insert(parts.destination,	{
			id = "bar-1", dst = {
				{x = barA, y = 4, w = 7, h = 185},
			}
		})
		-- 判定AA
		table.insert(parts.destination,	{
			id = "bar-1", dst = {
				{x = barAA, y = 4, w = 7, h = 185},
			}
		})
		-- 判定AAA
		table.insert(parts.destination,	{
			id = "bar-1", dst = {
				{x = barAAA, y = 4, w = 7, h = 185},
			}
		})
		-- 判定MAX
		if PROPERTY.isGraphbarStretchLeft() then
			table.insert(parts.destination,	{
				id = "bar-max-l", dst = {
					{x = barMAX, y = 4, w = 50, h = 185},
				}
			})
		elseif PROPERTY.isGraphbarStretchRight() then
			table.insert(parts.destination,	{
				id = "bar-max-r", dst = {
					{x = barMAX, y = 4, w = 50, h = 185},
				}
			})
		end
		
		-- 判定A到達
		table.insert(parts.destination,	{
			id = "bar-2", op = {MAIN.OP.A}, dst = {
				{x = barA2, y = 4, w = 7, h = 185},
			}
		})
		-- 判定AA到達
		table.insert(parts.destination,	{
			id = "bar-2", op = {MAIN.OP.AA}, dst = {
				{x = barAA2, y = 4, w = 7, h = 185},
			}
		})
		-- 判定AAA到達
		table.insert(parts.destination,	{
			id = "bar-2", op = {MAIN.OP.AAA}, dst = {
				{x = barAAA2, y = 4, w = 7, h = 185},
			}
		})
		-- 現在のベストレート
		table.insert(parts.destination,	{
			id = "graph-now-best", dst = {
				{x = gra_now, y = 133, w = bar_width, h = 51, a = 50},
			}
		})
		-- 現在のスコア
		table.insert(parts.destination,	{
			id = "graph-now", dst = {
				{x = gra_now, y = 133, w = bar_width, h = 51, a = 200},
			}
		})
		
		-- 現在のランク
		table.insert(parts.destination,	{
			id = "now-AAA-" .. direction, op = {MAIN.OP.AAA_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		table.insert(parts.destination,	{
			id = "now-AA-" .. direction, op = {MAIN.OP.AA_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		table.insert(parts.destination,	{
			id = "now-A-" .. direction, op = {MAIN.OP.A_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		table.insert(parts.destination,	{
			id = "now-B-" .. direction, op = {MAIN.OP.B_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		table.insert(parts.destination,	{
			id = "now-C-" .. direction, op = {MAIN.OP.C_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		table.insert(parts.destination,	{
			id = "now-D-" .. direction, op = {MAIN.OP.D_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		table.insert(parts.destination,	{
			id = "now-E-" .. direction, op = {MAIN.OP.E_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		table.insert(parts.destination,	{
			id = "now-F-" .. direction, op = {MAIN.OP.F_1P}, dst = {
				{x = rank, y = 145, w = 75, h = 22},
			}
		})
		
		-- 自己ベスト
		-- op100: SELECT_BAR_NOT_PLAYED
		table.insert(parts.destination,	{
			id = "graph-best-bg", loop = 1000, dst = {
				{time = 0, x = gra_best, y = 80, w = 0, h = 51, a = 0},
				{time = 1000, w = bar_width, a = 50}
			}
		})
		-- 自己ベスト（現在）
		table.insert(parts.destination,	{
			id = "graph-best", dst = {
				{x = gra_best, y = 80, w = bar_width, h = 51, a = 200},
			}
		})
		-- 自己ベストとの差
		table.insert(parts.destination,	{
			id = "num-diffExscoreMybest", dst = {
				{x = diffExscoreMybest, y = 95, w = 27, h = 20},
			}
		})
		
		-- ターゲットスコア
		table.insert(parts.destination,	{
			id = "graph-target-bg", loop = 1000, dst = {
				{time = 0, x = gra_target, y = 27, w = 0, h = 51, a = 0},
				{time = 1000, w = bar_width, a = 50}
			}
		})
		-- ターゲットスコア（現在）
		table.insert(parts.destination,	{
			id = "graph-target", dst = {
				{x = gra_target, y = 27, w = bar_width, h = 51, a = 200},
			}
		})
		-- ターゲットスコアとの差
		table.insert(parts.destination,	{
			id = "num-diffExscoreTarget", dst = {
				{x = diffExscoreTarget, y = 40, w = 27, h = 20},
			}
		})
	elseif PROPERTY.isGraphareaCoverOn() then
		-- グラフエリアカバー
		table.insert(parts.destination,	{
			id = "graphCover", dst = {
				{x = graphFramePosX, y = 4, w = 771, h = 198},
			}
		})
	end
	
	return parts
end

return {
	load = load
}