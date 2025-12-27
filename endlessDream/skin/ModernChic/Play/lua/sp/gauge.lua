--[[
	グルーヴゲージ部分
	@author : KASAKO
--]]

local function load()
	local parts = {}
	parts.image = {
		-- ゲージフレーム
		{id = "gaugeFrame_1P", src = 1, x = 0, y = 861, w = 556, h = 69},
		{id = "gaugeFrame_2P", src = 1, x = 600, y = 861, w = 556, h = 69},
		
		-- ゲージ隠し
		{id = "gaugeCover_1P", src = 1, x = 0, y = 1180, w = 556, h = 69},
		{id = "gaugeCover_2P", src = 1, x = 600, y = 1180, w = 556, h = 69},
		
		-- 小数点
		{id = "afterdot", src = 1, x = 326, y = 950, w = 10, h = 36},
		
		-- ノーマルゲージ（赤over80明）
		{id = "gauge-r1", src = 29, x = 0, y = 0, w = 8, h = 35},
		-- ノーマルゲージ（赤over80暗）
		{id = "gauge-r2", src = 29, x = 16, y = 0, w = 8, h = 35},
		-- ノーマルゲージ（赤over80明）
		{id = "gauge-r3", src = 29, x = 0, y = 0, w = 8, h = 35},
		
		-- ノーマルゲージ（青under80明）
		{id = "gauge-b1", src = 29, x = 8, y = 0, w = 8, h = 35},
		-- ノーマルゲージ（青under80暗）
		{id = "gauge-b2", src = 29, x = 24, y = 0, w = 8, h = 35},
		-- ノーマルゲージ（青over60明）
		{id = "gauge-b3", src = 29, x = 8, y = 0, w = 8, h = 35},
		
		-- ノーマルゲージ（緑under80明）
		{id = "gauge-g1", src = 29, x = 32, y = 0, w = 8, h = 35},
		-- ノーマルゲージ（緑under80暗）
		{id = "gauge-g2", src = 29, x = 48, y = 0, w = 8, h = 35},
		-- ノーマルゲージ（緑under80明）
		{id = "gauge-g3", src = 29, x = 32, y = 0, w = 8, h = 35},
		
		-- アシストゲージ（ピンクover60明）
		{id = "gauge-p1", src = 29, x = 8, y = 35, w = 8, h = 35},
		-- アシストゲージ（ピンク暗）
		{id = "gauge-p2", src = 29, x = 24, y = 35, w = 8, h = 35},
		-- アシストゲージ（ピンク明）
		{id = "gauge-p3", src = 29, x = 8, y = 35, w = 8, h = 35},
		
		-- EXゲージ（黄明）
		{id = "gauge-y1", src = 29, x = 0, y = 35, w = 8, h = 35},
		-- EXゲージ（黄暗）
		{id = "gauge-y2", src = 29, x = 16, y = 35, w = 8, h = 35},
		-- EXゲージ（黄明）
		{id = "gauge-y3", src = 29, x = 0, y = 35, w = 8, h = 35},
		
		-- HAZARDゲージ（紫明）
		{id = "gauge-h1", src = 29, x = 64, y = 0, w = 8, h = 35},
		-- HAZARDゲージ（紫暗）
		{id = "gauge-h2", src = 29, x = 72, y = 0, w = 8, h = 35},
		-- HAZARDゲージ（紫明）
		{id = "gauge-h3", src = 29, x = 64, y = 0, w = 8, h = 35},
		
		--アシストモード
		{id = "mode-assist", src = 1, x = 1200, y = 0, w = 190, h = 15},
		-- イージーモード
		{id = "mode-easy", src = 1, x = 1200, y = 15, w = 190, h = 15},
		-- ノーマルモード
		{id = "mode-normal", src = 1, x = 1200, y = 30, w = 190, h = 15},
		-- ハードモード
		{id = "mode-hard", src = 1, x = 1200, y = 45, w = 190, h = 15},
		-- EXハードモード
		{id = "mode-exhard", src = 1, x = 1200, y = 60, w = 190, h = 15},
		-- ハザードモード
		{id = "mode-hazard", src = 1, x = 1200, y = 75, w = 190, h = 15},
		-- 通常段位モード
		{id = "mode-grade", src = 1, x = 1390, y = 0, w = 190, h = 15},
		-- EX段位モード
		{id = "mode-exgrade", src = 1, x = 1390, y = 15, w = 190, h = 15},
		-- EXHARD段位モード
		{id = "mode-exhardgrade", src = 1, x = 1390, y = 30, w = 190, h = 15},
	}
	
	parts.value = {
		-- ゲージ％
		{id = "gaugenumber", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, divy = 1, digit = 3, ref = MAIN.NUM.GROOVEGAUGE},
		-- ゲージ％（小数）
		{id = "gaugenumber_afterdot", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, divy = 1, digit = 1, ref = MAIN.NUM.GROOVEGAUGE_AFTERDOT},
	}

	parts.gauge = {
		id = 2001,
		parts = 50,
		nodes = {
		-- 並び順はoverclear(明),underclear(明),overclear(暗),underclear(暗),先端の色(明),先端の色(暗)
		-- アシストイージーゲージ
		"gauge-r1","gauge-p1","gauge-r2","gauge-p2","gauge-r3","gauge-p3",
		-- イージーゲージ
		"gauge-r1","gauge-g1","gauge-r2","gauge-g2","gauge-r3","gauge-g3",
		-- ノーマルゲージ
		"gauge-r1","gauge-b1","gauge-r2","gauge-b2","gauge-r3","gauge-b3",
		-- ハードゲージ(2,4,6番目はダミー？)
		"gauge-r1","gauge-p1","gauge-r2","gauge-p2","gauge-r3","gauge-p3",
		-- EXハードゲージ(2,4,6番目はダミー？)
		"gauge-y1","gauge-p1","gauge-y2","gauge-p2","gauge-y3","gauge-p3",
		-- ハザードゲージ(2,4,6番目はダミー？)
		"gauge-h1","gauge-p1","gauge-h2","gauge-p2","gauge-h3","gauge-p3"
		}
	}
	if CONFIG.play.smallGauge then
		parts.gauge.parts = 100
	end
	
	parts.destination = {}

	-- フレーム
	table.insert(parts.destination,	{
		id = "gaugeFrame_"..BASE.GAUGE.PS, dst = {
			{x = BASE.gaugePositionX, y = BASE.GAUGE.POS_Y, w = 556, h = 69},
		}
	})

	-- ゲージ本体(EXH,HAZARD,特殊段位ゲージは点滅処理を入れる)
	table.insert(parts.destination,	{
		id = "2001", draw = function() return CUSTOM.OP.isBrinkGauge() end, dst = {
			{time = 0, x = BASE.gaugePositionX + BASE.GAUGE.POS_X, y = BASE.GAUGE.POS_Y + 9, w = BASE.GAUGE.WIDTH, h = 35, acc = MAIN.ACC.DECELERATE},
			{time = 500, a = 200},
			{time = 1000, a = 255}
		}
	})
	table.insert(parts.destination,	{
		id = "2001", draw = function() return not CUSTOM.OP.isBrinkGauge() end, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.POS_X, y = BASE.GAUGE.POS_Y + 9, w = BASE.GAUGE.WIDTH, h = 35},
		}
	})

	-- ゲージが伸びているように見せる
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, loop = 2500, dst = {
			{time = 0, x = BASE.gaugePositionX + BASE.GAUGE.POS_X, y = BASE.GAUGE.POS_Y + 9, w = BASE.GAUGE.WIDTH, h = 35, acc = MAIN.ACC.DECELERATE},
			{time = 2500, x = BASE.gaugePositionX + BASE.GAUGE.POS_X + BASE.GAUGE.WIDTH, w = 0}
		}
	})
	
	-- ゲージ%
	-- 通常ゲージ
	table.insert(parts.destination,	{
		id = "afterdot", dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.AFTERDOT_X, y = BASE.GAUGE.POS_Y + 26, w = 10, h = 36},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber", op = {-MAIN.OP.GAUGE_HARD}, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 28, h = 36},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber_afterdot", op = {-MAIN.OP.GAUGE_HARD}, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.AFTERDOT_NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 21, h = 27},
		}
	})
	
	-- HARD,EXHARD時
	table.insert(parts.destination,	{
		id = "gaugenumber", op = {MAIN.OP.GAUGE_HARD, -MAIN.OP.GAUGE_1P_20_29, -MAIN.OP.GAUGE_1P_10_19, -MAIN.OP.GAUGE_1P_0_9}, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 28, h = 36},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber_afterdot", op = {MAIN.OP.GAUGE_HARD, -MAIN.OP.GAUGE_1P_20_29, -MAIN.OP.GAUGE_1P_10_19, -MAIN.OP.GAUGE_1P_0_9}, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.AFTERDOT_NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 21, h = 27},
		}
	})
	
	-- HARD,EXHARDのときの点滅動作
	do
		local loopTime = {500, 250, 125}
		local op = {MAIN.OP.GAUGE_1P_20_29, MAIN.OP.GAUGE_1P_10_19, MAIN.OP.GAUGE_1P_0_9}
		for i = 1, 3, 1 do
		table.insert(parts.destination,	{
			id = "gaugenumber", op = {MAIN.OP.GAUGE_HARD, op[i]}, dst = {
				{time = 0, x = BASE.gaugePositionX + BASE.GAUGE.NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 28, h = 36},
				{time = loopTime[i], a = 0}
			}
		})
		table.insert(parts.destination,	{
			id = "gaugenumber_afterdot", op = {MAIN.OP.GAUGE_HARD, op[i]}, dst = {
				{time = 0, x = BASE.gaugePositionX + BASE.GAUGE.AFTERDOT_NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 21, h = 27},
				{time = loopTime[i], a = 0}
			}
		})
		end
	end
	
	-- パーフェクト状態時は色を変える
	table.insert(parts.destination,	{
		id = "afterdot", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.AFTERDOT_X, y = BASE.GAUGE.POS_Y + 26, w = 10, h = 36, r = BASE.GAUGE.PERFECT_COLOR[1], g = BASE.GAUGE.PERFECT_COLOR[2], b = BASE.GAUGE.PERFECT_COLOR[3]},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 28, h = 36, r = BASE.GAUGE.PERFECT_COLOR[1], g = BASE.GAUGE.PERFECT_COLOR[2], b = BASE.GAUGE.PERFECT_COLOR[3]},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber_afterdot", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{x = BASE.gaugePositionX + BASE.GAUGE.AFTERDOT_NUM_X, y = BASE.GAUGE.POS_Y + 26, w = 21, h = 27, r = BASE.GAUGE.PERFECT_COLOR[1], g = BASE.GAUGE.PERFECT_COLOR[2], b = BASE.GAUGE.PERFECT_COLOR[3]},
		}
	})
	
	-- ゲージの状況
	do
		local type = {"assist", "easy", "normal", "hard", "exhard", "hazard", "grade", "exgrade", "exhardgrade"}
		for i = 1, 9, 1 do
			table.insert(parts.destination,	{
				id = "mode-"..type[i], draw = function()
					return main_state.gauge_type() == i - 1
				end,
				dst = {
					{x = BASE.gaugePositionX + BASE.GAUGE.TYPE_X, y = BASE.GAUGE.POS_Y + 50, w = 190, h = 15},
				}
			})
		end
	end

	-- ゲージ隠し
	table.insert(parts.destination,	{
		id = "gaugeCover_"..BASE.GAUGE.PS, draw = function() return PROPERTY.isGaugeCoverOn() and CUSTOM.OP.isTimerOff(MAIN.TIMER.ENDOFNOTE_1P) end,
		dst = {
			{x = BASE.gaugePositionX, y = BASE.GAUGE.POS_Y, w = 556, h = 69},
		}
	})
	
	return parts
end

return {
	load = load
}