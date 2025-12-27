--[[
	グルーヴゲージ部分
	@author : KASAKO
--]]

local function information(parts)
	local perfectColor = {147, 204, 44}
	-- ゲージ%
	local posx = BASE.laneLeftPosX + 519
	local posy = 180
	table.insert(parts.destination, {
		id = "perFrame", dst = {
			{x = posx, y = posy, w = 126, h = 90},
		}
	})
	table.insert(parts.destination, {
		id = "afterdot", dst = {
			{x = posx + 26, y =  posy + 14, w = 8, h = 8},
		}
	})
	table.insert(parts.destination, {
		id = "gaugenumber", op = {-MAIN.OP.GAUGE_HARD}, dst = {
			{x = posx + 15, y = posy + 40, w = 30, h = 40},
		}
	})
	table.insert(parts.destination, {
		id = "gaugenumber_afterdot", op = {-MAIN.OP.GAUGE_HARD}, dst = {
			{x = posx + 40, y = posy + 5, w = 21, h = 40},
		}
	})
	-- HARD,EXHARD時
	table.insert(parts.destination,	{
		id = "gaugenumber", op = {MAIN.OP.GAUGE_HARD, -MAIN.OP.GAUGE_1P_20_29, -MAIN.OP.GAUGE_1P_10_19, -MAIN.OP.GAUGE_1P_0_9}, dst = {
			{x = posx + 15, y = posy + 40, w = 30, h = 40},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber_afterdot", op = {MAIN.OP.GAUGE_HARD, -MAIN.OP.GAUGE_1P_20_29, -MAIN.OP.GAUGE_1P_10_19, -MAIN.OP.GAUGE_1P_0_9}, dst = {
			{x = posx + 40, y = posy + 5, w = 21, h = 40},
		}
	})
	-- HARD,EXHARDのときの点滅動作
	do
		local loopTime = {500, 250, 125}
		local op = {232, 231, 230}
		for i = 1, 3, 1 do
		table.insert(parts.destination,	{
			id = "gaugenumber", op = {MAIN.OP.GAUGE_HARD, op[i]}, dst = {
				{time = 0, x = posx + 15, y = posy + 40, w = 30, h = 40},
				{time = loopTime[i], a = 0}
			}
		})
		table.insert(parts.destination,	{
			id = "gaugenumber_afterdot", op = {MAIN.OP.GAUGE_HARD, op[i]}, dst = {
				{time = 0, x = posx + 40, y = posy + 5, w = 21, h = 40},
				{time = loopTime[i], a = 0}
			}
		})
		end
	end
	-- パーフェクト状態時は色を変える
	table.insert(parts.destination,	{
		id = "afterdot", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{x = posx + 26, y =  posy + 14, w = 8, h = 8, r = perfectColor[1], g = perfectColor[2], b = perfectColor[3]},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{x = posx + 15, y = posy + 40, w = 30, h = 40, r = perfectColor[1], g = perfectColor[2], b = perfectColor[3]},
		}
	})
	table.insert(parts.destination,	{
		id = "gaugenumber_afterdot", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.POOR_EXIST, -MAIN.OP.BAD_EXIST, -MAIN.OP.GOOD_EXIST}, dst = {
			{x = posx + 40, y = posy + 5, w = 21, h = 40, r = perfectColor[1], g = perfectColor[2], b = perfectColor[3]},
		}
	})
	-- ゲージ隠し
	table.insert(parts.destination, {
		id = "perFrame2", draw = function()
			return PROPERTY.isGaugeCoverOn() and CUSTOM.OP.isTimerOff(MAIN.TIMER.ENDOFNOTE_1P)
		end,
		dst = {
			{x = posx, y = posy, w = 126, h = 90},
		}
	})
end

local function body(parts)
	local posx
	local w
	if PROPERTY.isGaugeStretchDirectionRight() then
		posx = BASE.laneLeftPosX + 328
		w = 500
	elseif PROPERTY.isGaugeStretchDirectionLeft() then
		posx = BASE.laneLeftPosX + 828
		w = -500
	end
	-- ゲージ本体ゲージ本体(EXH,HAZARD,特殊段位ゲージは点滅処理を入れる)
	table.insert(parts.destination,	{
		id = "2001", draw = function() return CUSTOM.OP.isBrinkGauge() end, dst = {
			{time = 0, x = posx, y = 117, w = w, h = 35},
			{time = 500, a = 200},
			{time = 1000, a = 255}
		}
	})
	table.insert(parts.destination,	{
		id = "2001", draw = function() return not CUSTOM.OP.isBrinkGauge() end, dst = {
			{x = posx, y = 117, w = w, h = 35},
		}
	})
	-- ゲージが伸びているように見せる
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, loop = 2500, dst = {
			{time = 0, x = posx, y = 117, w = w, h = 35, acc = MAIN.ACC.DECELERATE},
			{time = 2500, x = posx + w, w = 0}
		}
	})
	-- ゲージ隠し
	table.insert(parts.destination,	{
		id = "gaugeCover", draw = function() return PROPERTY.isGaugeCoverOn() and CUSTOM.OP.isTimerOff(MAIN.TIMER.ENDOFNOTE_1P) end, dst = {
			{x = BASE.laneLeftPosX + 328, y = 117, w = 500, h = 35},
		}
	})
end

local function load()
	local parts = {}
	parts.image = {
		{id = "perFrame", src = 1, x = 380, y = 460, w = 126, h = 90},
		-- ゲージ隠し
		{id = "gaugeCover", src = 1, x = 0, y = 1200, w = 500, h = 35},
		{id = "perFrame2", src = 1, x = 550, y = 460, w = 126, h = 90},
		-- 小数点
		{id = "afterdot", src = 1, x = 530, y = 528, w = 8, h = 8},
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
	}
	
	parts.value = {
		-- ゲージ％
		{id = "gaugenumber", src = 1, x = 1008, y = 940, w = 300, h = 40, divx = 10, divy = 1, digit = 3, ref = MAIN.NUM.GROOVEGAUGE},
		-- ゲージ％（小数）
		{id = "gaugenumber_afterdot", src = 1, x = 1008, y = 980, w = 210, h = 40, divx = 10, divy = 1, digit = 1, ref = MAIN.NUM.GROOVEGAUGE_AFTERDOT},
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
	if CONFIG.play.smallGauge then parts.gauge.parts = 100 end
	
	parts.destination = {}
	information(parts)
	body(parts)
	
	return parts
end

return {
	load = load
}