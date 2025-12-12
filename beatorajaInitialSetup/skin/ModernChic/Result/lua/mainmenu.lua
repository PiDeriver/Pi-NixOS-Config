--[[
	グラフ、判定数、メインメニュー
	@author : KASAKO
]]
local luajava = require("luajava")
local Gdx = luajava.bindClass("com.badlogic.gdx.Gdx")
local input = luajava.bindClass("com.badlogic.gdx.Input")

-- メインメニューフラグ
local isInfoMenu1 = true
local isInfoMenu2 = false

-- タイミング分布グラフ作成
local function createTimingDistributionGraph(contents)
	local m = {}
	m.graphMagnification = nil
	m.graphColor = "00FF00EE"
	m.averageColor = "FFFFFFFF"
	m.devColor = "AAAAAAFF"
	m.PGColor = "000088FF"
	m.GRColor = "008800FF"
	m.GDColor = "888800FF"
	m.BDColor = "880000FF"
	m.PRColor = "000000FF"
	-- 倍率
	if PROPERTY.isTDGMagnificationLow() then
		-- +-225ms
		m.graphMagnification = 450
	elseif PROPERTY.isTDGMagnificationNormal() then
		-- +-150ms
		m.graphMagnification = 300
	elseif PROPERTY.isTDGMagnificationHigh() then
		-- +-75ms
		m.graphMagnification = 150
	end
	-- 配色パターン
	if PROPERTY.isTDGColorRed() then
		m.graphColor = "E286A7EE"
		m.PGColor = "550000FF"
		m.GRColor = "990000FF"
		m.GDColor = "550000FF"
		m.BDColor = "990000FF"
		m.PRColor = "000000FF"
	elseif PROPERTY.isTDGColorGreen() then
		m.graphColor = "86E088EE"
		m.PGColor = "005500FF"
		m.GRColor = "008800FF"
		m.GDColor = "005500FF"
		m.BDColor = "008800FF"
		m.PRColor = "000000FF"
	elseif PROPERTY.isTDGColorBlue() then
		m.graphColor = "89DDDCEE"
		m.PGColor = "000055FF"
		m.GRColor = "000099FF"
		m.GDColor = "000055FF"
		m.BDColor = "000099FF"
		m.PRColor = "000000FF"
	end

	table.insert(contents, {
		id = "timingdistributiongraph",
		width = m.graphMagnification,
		lineWidth = 1,
		graphColor = m.graphColor,
		averageColor = m.averageColor,
		devColor = m.devColor,
		PGColor = m.PGColor,
		GRColor = m.GRColor,
		GDColor = m.GDColor,
		BDColor = m.BDColor,
		PRColor = m.PRColor,
		drawAverage = MAIN.TIMINGDISTRIBUTIONGRAPH.DRAW_AVERAGE.ON,
		drawDev = MAIN.TIMINGDISTRIBUTIONGRAPH.DRAW_DEV.ON
	})
end

local function load(flg)
	local parts = {}
	-- メインメニュー切り替え
	local function infoMenuSwitch()
		isInfoMenu1 = not isInfoMenu1
		isInfoMenu2 = not isInfoMenu2
		-- 音声出力
		CUSTOM.SOUND.menuChangeSound()
	end

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
	
	do
		local gaugeWidth = 8
		local gaugeHeight = 35
		parts.image = {
			{id = "mainInfo", src = 2, x = 0, y = 0, w = 665, h = 150, divy = 3, cycle = 9000},
			{id = "mainInfo2", src = 2, x = 0, y = 100, w = 665, h = 50},
			{id = "mainGraphFrame", src = 2, x = 0, y = 160, w = 665, h = 356},
			-- メインメニュー
			{id = "mainJudgeFrame", src = 2, x = 0, y = 520, w = 665, h = 582},
			{id = "mainJudgeFrame2", src = 2, x = 2000, y = 0, w = 665, h = 582},
			-- メインメニュー切り替え用
			{id = "mainMenu", src = 2, x = 2000, y = 890, w = 234, h = 43, act = function()
				return infoMenuSwitch()
			end},
			{id = "mainMenuRect", src = 2, x = 2000, y = 933, w = 234, h = 43},
			-- ランプ（修飾用）
			{id = "lampGreen", src = 5, x = 0, y = 760, w = 38, h = 76},
			-- クリア状況
			{id = "clearType", src = 2, x = 150, y = 1110, w = 702, h = 473, divx = 3, divy = 11, cycle = 192, len = 11, ref = MAIN.NUM.CLEAR, act = MAIN.NUM.CLEAR},
			-- ベストクリア状況
			{id = "clearType2", src = 2, x = 150, y = 1110, w = 702, h = 473, divx = 3, divy = 11, cycle = 192, len = 11, ref = MAIN.NUM.TARGET_CLEAR, act = MAIN.NUM.TARGET_CLEAR},
			-- 自己ベスト更新
			{id = "scoreUpdate", src = 6, x = 199, y = 380, w = 214, h = 36, divx = 2, cycle = 200},
			-- ランプ更新
			{id = "lampUpdate", src = 2, x = 670, y = 1630, w = 254, h = 148, divy = 2, cycle = 100},
			-- ランク更新
			{id = "rankUpdate", src = 2, x = 924, y = 1630, w = 165, h = 148, divy = 2, cycle = 100},
			-- トータルノート数、使用OP表示フレーム
			{id = "infoFrame", src = 6, x = 0, y = 530, w = 649, h = 44},
			-- 使用OP 1P
			{id = "useOption1P", src = 6, x = 520, y = 0, w = 175, h = 400, divy = 10, len = 10, ref = MAIN.BUTTON.RANDOM_1P, act = MAIN.BUTTON.RANDOM_1P},
			-- 使用OP 2P
			{id = "useOption2P", src = 6, x = 520, y = 0, w = 175, h = 400, divy = 10, len = 10, ref = MAIN.BUTTON.RANDOM_2P, act = MAIN.BUTTON.RANDOM_2P},
			-- ノーマルゲージ（赤over80明）
			{id = "gauge-r1", src = 8, x = 0, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（赤over80暗）
			{id = "gauge-r2", src = 8, x = 16, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（赤over80明）
			{id = "gauge-r3", src = 8, x = 0, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（青under80明）
			{id = "gauge-b1", src = 8, x = 8, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（青under80暗）
			{id = "gauge-b2", src = 8, x = 24, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（青over60明）
			{id = "gauge-b3", src = 8, x = 8, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（緑under80明）
			{id = "gauge-g1", src = 8, x = 32, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（緑under80暗）
			{id = "gauge-g2", src = 8, x = 48, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- ノーマルゲージ（緑under80明）
			{id = "gauge-g3", src = 8, x = 32, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- アシストゲージ（ピンクover60明）
			{id = "gauge-p1", src = 8, x = 40, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- アシストゲージ（ピンク暗）
			{id = "gauge-p2", src = 8, x = 56, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- アシストゲージ（ピンク明）
			{id = "gauge-p3", src = 8, x = 40, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- EXゲージ（黄明）
			{id = "gauge-y1", src = 8, x = 0, y = 35, w = gaugeWidth, h = gaugeHeight},
			-- EXゲージ（黄暗）
			{id = "gauge-y2", src = 8, x = 16, y = 35, w = gaugeWidth, h = gaugeHeight},
			-- EXゲージ（黄明）
			{id = "gauge-y3", src = 8, x = 0, y = 35, w = gaugeWidth, h = gaugeHeight},
			-- HAZARDゲージ（紫明）
			{id = "gauge-h1", src = 8, x = 64, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- HAZARDゲージ（紫暗）
			{id = "gauge-h2", src = 8, x = 72, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- HAZARDゲージ（紫明）
			{id = "gauge-h3", src = 8, x = 64, y = 0, w = gaugeWidth, h = gaugeHeight},
			-- 判定グラフフレーム
			{id = "timingGraphFrame", src = 2, x = 0, y = 1910, w = 250, h = 60},
			-- combo文字
			{id = "wdCombo", src = 2, x = 0, y = 2040, w = 210, h = 60},
			-- misscount文字
			{id = "wdMisscount", src = 2, x = 0, y = 2100, w = 210, h = 60},
			-- StageFileなし
			{id = "noimage", src = 2, x = 2000, y = 980, w = 640, h = 380},
			-- コースフレーム
			{id = "courseFrame", src = 2, x = 2000, y = 1370, w = 652, h = 377},
			-- コース用（1-5）
			{id = "course_1-5", src = 2, x = 2250, y = 590, w = 100, h = 320},
			-- コース用（6-10）
			{id = "course_6-10", src = 2, x = 2350, y = 590, w = 100, h = 320},
			-- グラフ関連フレーム
			{id = "graphFrame", src = 2, x = 2000, y = 1750, w = 670, h = 385},
			{id = "timFS", src = 2, x = 2000, y = 2135, w = 652, h = 25},
			-- アシスト表示
			{id = "assistInfo", src = 2, x = 650, y = 1910, w = 655, h = 40}
		}
	end
	
	parts.value = {
		-- 今回のEXSCORE
		{id = "mainExscore", src = 4, x = 440, y = 60, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.SCORE3, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- 自己べとのEXSCORE差分
		{id = "mainExscoreDiff", src = 4, x = 440, y = 96, w = 372, h = 72, divx = 12, divy = 2, digit = 6, ref = MAIN.NUM.DIFF_HIGHSCORE2, align = MAIN.N_ALIGN.RIGHT},
		-- EXSCOREレート
		{id = "numExscoreRate", src = 4, x = 440, y = 96, w = 310, h = 36, divx = 10, digit = 3, ref = MAIN.NUM.SCORE_RATE, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- EXSCOREレート（小数点）
		{id = "numExscoreRateAfterdot", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.SCORE_RATE_AFTERDOT, align = MAIN.N_ALIGN.RIGHT},
		-- 今回のコンボ
		{id = "mainCombo", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.MAXCOMBO2, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- 自己べとのコンボ差分
		{id = "mainComboDiff", src = 4, x = 440, y = 96, w = 372, h = 72, divx = 12, divy = 2, digit = 6, ref = MAIN.NUM.DIFF_MAXCOMBO, align = MAIN.N_ALIGN.RIGHT},
		-- 今回のミスカウント
		{id = "numMisscount", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.MISSCOUNT2, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- 自己べとのミスカウント差分
		{id = "numMisscountDiff", src = 4, x = 440, y = 276, w = 372, h = 72, divx = 12, divy = 2, digit = 6, ref = MAIN.NUM.DIFF_MISSCOUNT, align = MAIN.N_ALIGN.RIGHT},
		-- ピカグレ数
		{id = "numPG", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.PERFECT, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- グレ数
		{id = "numGR", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.GREAT, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numGR_ER", src = 4, x = 440, y = 312, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.EARLY_GREAT, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numGR_SL", src = 4, x = 440, y = 276, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.LATE_GREAT, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- good数
		{id = "numGD", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.GOOD, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numGD_ER", src = 4, x = 440, y = 312, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.EARLY_GOOD, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numGD_SL", src = 4, x = 440, y = 276, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.LATE_GOOD, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- bad数
		{id = "numBD", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.BAD, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numBD_ER", src = 4, x = 440, y = 312, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.EARLY_BAD, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numBD_SL", src = 4, x = 440, y = 276, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.LATE_BAD, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- poor数
		{id = "numPR", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.POOR, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numPR_ER", src = 4, x = 440, y = 312, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.EARLY_POOR, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numPR_SL", src = 4, x = 440, y = 276, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.LATE_POOR, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- miss数
		{id = "numMS", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.MISS, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numMS_ER", src = 4, x = 440, y = 312, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.EARLY_MISS, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "numMS_SL", src = 4, x = 440, y = 276, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.LATE_MISS, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- ゲージ
		{id = "numGauge", src = 4, x = 0, y = 96, w = 440, h = 36, divx = 10, digit = 3, ref = MAIN.NUM.GROOVEGAUGE, align = MAIN.N_ALIGN.RIGHT},
		{id = "numGaugeAfterdot", src = 4, x = 0, y = 132, w = 440, h = 36, divx = 10, digit = 1, ref = MAIN.NUM.GROOVEGAUGE_AFTERDOT, align = MAIN.N_ALIGN.RIGHT},
		-- 総ノート数
		{id = "totalNotes", src = 4, x = 440, y = 96, w = 310, h = 36, divx = 10, digit = 5, ref = MAIN.NUM.TOTALNOTES, align = MAIN.N_ALIGN.RIGHT},
		-- タイミンググラフ用
		{id = "timingFastNum", src = 4, x = 440, y = 312, w = 341, h = 36, divx = 11, digit = 4, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON, value = function()
			return main_state.number(MAIN.NUM.TOTALEARLY)
		end,},
		{id = "timingSlowNum", src = 4, x = 440, y = 276, w = 341, h = 36, divx = 11, digit = 4, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON, value = function()
			return main_state.number(MAIN.NUM.TOTALLATE)
		end,},
		-- TOTAL値
		{id = "numTOTAL", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, ref = MAIN.NUM.SONGGAUGE_TOTAL, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- 参考TOTAL値
		{id = "numRefTOTAL", src = 4, x = 440, y = 96, w = 341, h = 36, divx = 11, digit = 5, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON, value = function()
			return CUSTOM.NUM.calcTotal()
		end},
		-- タイミング標準偏差
		{id = "stddevRate", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.STDDEV_TIMING, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- タイミング標準偏差（小数点）
		{id = "stddevRateAfterdot", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.STDDEV_TIMING_AFTERDOT, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- タイミング平均
		{id = "aveTimRate", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.AVERAGE_TIMING, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- タイミング平均（小数点）
		{id = "aveTimRateAfterdot", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.AVERAGE_TIMING_AFTERDOT, align = MAIN.N_ALIGN.RIGHT, zeropadding = MAIN.N_ZEROPADDING.ON},
	}

	parts.gaugegraph = {{
		id = "grooveGaugeGraph",
		assistClearBGColor = "44004455",
		assistAndEasyFailBGColor = "00444455",
		grooveFailBGColor = "00440055",
		grooveClearAndHardBGColor = "44000055",
		exHardBGColor = "44440055",
		hazardBGColor = "44444455",
		assistClearLineColor = "ff00ff",
		assistAndEasyFailLineColor = "00ffff",
		grooveFailLineColor = "00ff00",
		grooveClearAndHardLineColor = "ff0000",
		exHardLineColor = "ffff00",
		hazardLineColor = "cccccc",
		borderlineColor = "ff0000",
		borderColor = "44000055"
	}}

	parts.judgegraph = {
		-- 判定用グラフ
		{id = "judgesGraph", noGap = MAIN.JUDGEGRAPH.NOGAP.OFF, orderReverse = MAIN.JUDGEGRAPH.ORDERREVERSE.ON, type = MAIN.JUDGEGRAPH.TYPE.JUDGE, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.ON},
		-- ノート構成グラフ
		{id = "notesGraph", noGap = MAIN.JUDGEGRAPH.NOGAP.OFF, orderReverse = MAIN.JUDGEGRAPH.ORDERREVERSE.OFF, type = MAIN.JUDGEGRAPH.TYPE.NOTES, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF},
		-- fast slow用グラフ
		{id = "fsGraph", noGap = MAIN.JUDGEGRAPH.NOGAP.OFF, orderReverse = MAIN.JUDGEGRAPH.ORDERREVERSE.OFF, type = MAIN.JUDGEGRAPH.TYPE.FASTSLOW, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF},
	}

	parts.bpmgraph = {{id = "bpmgraph"}}

	parts.timingdistributiongraph = {}
	createTimingDistributionGraph(parts.timingdistributiongraph)

	parts.graph = {
		-- FAST
		{id = "gra_fastRate", src = 2, x = 0, y = 1970, w = 246, h = 26, angle = 0, value = function()
			return CUSTOM.GRAPH.FastRate()
		end},
		-- SLOW
		{id = "gra_slowRate", src = 2, x = 0, y = 1996, w = 246, h = 26, angle = 0, value = function()
			return CUSTOM.GRAPH.SlowRate()
		end},
	}

	parts.destination = {}

	-- インフォ
	if flg == 0 then
		-- 通常でもコース経過中はアニメーションさせない
		table.insert(parts.destination, {
			id = "mainInfo", draw = function()
				return main_state.text(MAIN.STRING.COURSE1_TITLE) == ""
			end, dst = {
				{x = RESULT_BASE.MAIN_POS_X, y = 1024, w = 665, h = 50},
			}
		})
		table.insert(parts.destination, {
			id = "mainInfo2", draw = function()
				return main_state.text(MAIN.STRING.COURSE1_TITLE) ~= ""
			end, dst = {
				{x = RESULT_BASE.MAIN_POS_X, y = 1024, w = 665, h = 50},
			}
		})
	else
		-- コース
		table.insert(parts.destination, {
			id = "mainInfo2", dst = {
				{x = RESULT_BASE.MAIN_POS_X, y = 1024, w = 665, h = 50},
			}
		})
	end

	-- ゲージグラフ
	table.insert(parts.destination, {
		id = "mainGraphFrame", dst = {
			{x = RESULT_BASE.MAIN_POS_X, y = 659, w = 665, h = 356},
		}
	})
	-- 通常リザルトの時のみ
	if flg == 0 then
		table.insert(parts.destination, {
			id = "judgesGraph", dst = {
				{x = RESULT_BASE.MAIN_POS_X + 5, y = 774, w = 655, h = 236},
			}
		})
	end
	table.insert(parts.destination, {
		id = "grooveGaugeGraph", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 5, y = 774, w = 655, h = 236},
		}
	})
	-- アシストオプション案内
	table.insert(parts.destination, {
		id = "assistInfo", loop = 5000, draw = function()
			return CUSTOM.OP.isAssistOn()
		end, dst = {
			{time = 0, x = RESULT_BASE.MAIN_POS_X + 5, y = 970, w = 655, h = 40},
			{time = 4000},
			{time = 5000, a = 0}

		}
	})

	-- 今回のクリアランク（ゲージ部分）
	do
		local wd = {"rankAAA", "rankAA", "rankA", "rankB", "rankC", "rankD", "rankE", "rankF"}
		local op = {
			MAIN.OP.RESULT_AAA_1P,
			MAIN.OP.RESULT_AA_1P,
			MAIN.OP.RESULT_A_1P,
			MAIN.OP.RESULT_B_1P,
			MAIN.OP.RESULT_C_1P,
			MAIN.OP.RESULT_D_1P,
			MAIN.OP.RESULT_E_1P,
			MAIN.OP.RESULT_F_1P
		}
		local posY = 0
		for i = 1, 8, 1 do
			table.insert(parts.image, {id = wd[i], src = 7, x = 0, y = posY, w = 400, h = 168})
			posY = posY + 168
		end
		for i = 1, 8, 1 do
			if PROPERTY.isClearRankFadeout() then
				table.insert(parts.destination, {
					id = wd[i], loop = -1, op = {op[i]}, dst = {
						{time = 0, x = RESULT_BASE.MAIN_POS_X + 60, y = 800, w = 400, h = 168 * 3, a = 0},
						{time = 250, h = 168, a = 255},
						{time = 4000},
						{time = 5000, a = 0}
					}
				})
			elseif PROPERTY.isClearRankFluffy() then
				table.insert(parts.destination, {
					id = wd[i], op = {op[i]}, dst = {
						{time = 0, x = RESULT_BASE.MAIN_POS_X + 60, y = 800, w = 400, h = 168, a = 50},
						{time = 1000, a = 200},
						{time = 2000},
						{time = 3000, a = 50}
					}
				})
			end
		end
	end

	-- 使用OP、総ノート数
	table.insert(parts.destination, {
		id = "infoFrame", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 8, y = 727, w = 649, h = 44},
		}
	})
	-- 使用OP
	table.insert(parts.destination, {
		id = "useOption1P", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 26, y = 726, w = 175, h = 40},
		}
	})
	-- 使用OP（2P側）
	table.insert(parts.destination, {
		id = "useOption2P", draw = function()
			return main_state.option(MAIN.OP.SONG14KEY) or main_state.option(MAIN.OP.SONG10KEY) or main_state.option(MAIN.OP.SONG24KEYDP)
		end, dst = {
			{x = RESULT_BASE.MAIN_POS_X + 211, y = 726, w = 175, h = 40},
		}
	})
	-- 総ノート数
	table.insert(parts.destination, {
		id = "totalNotes", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 373, y = 730, w = 31, h = 36},
		}
	})

	-- ゲージ本体
	table.insert(parts.destination,	{
		id = "2001", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 21, y = 674, w = 400, h = 35},
		}
	})
	-- 残りゲージ
	table.insert(parts.destination, {
		id = "numGauge", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 409, y = 674, w = 44, h = 36},
		}
	})
	table.insert(parts.destination, {
		id = "numGaugeAfterdot", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 559, y = 674, w = 44, h = 36},
		}
	})

	do
		local exscorePosY = 545
		local itemPosY = exscorePosY - 65
		local pgPosY = itemPosY - 65
		local greatPosY = pgPosY - 65
		local goodPosY = greatPosY - 65
		local badPosY = goodPosY - 65
		local poorPosY = badPosY - 65
		local missPosY = poorPosY - 65

		-- メインメニュー1
		table.insert(parts.destination, {
			id = "mainJudgeFrame", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X, y = 70, w = 665, h = 582},
			}
		})
		-- 今回のEXSCORE
		table.insert(parts.destination, {
			id = "mainExscore", dst = {
				{x = RESULT_BASE.MAIN_POS_X + 222, y = exscorePosY, w = 28, h = 36},
			}
		})
		-- EXSCORE差分
		table.insert(parts.destination, {
			id = "mainExscoreDiff", dst = {
				{x = RESULT_BASE.MAIN_POS_X + 380, y = exscorePosY - 10, w = 22, h = 28},
			}
		})
		-- EXSCOREレート
		table.insert(parts.destination, {
			id = "numExscoreRate", dst = {
				{x = RESULT_BASE.MAIN_POS_X + 380, y =  exscorePosY + 18, w = 22, h = 28},
			}
		})
		table.insert(parts.destination, {
			id = "numExscoreRateAfterdot", dst = {
				{x = RESULT_BASE.MAIN_POS_X + 380 + 75, y =  exscorePosY + 18, w = 16, h = 23},
			}
		})
		-- EXSCORE更新
		table.insert(parts.destination, {
			id = "scoreUpdate", loop = 3000, op = {MAIN.OP.UPDATE_SCORE}, dst = {
				{time = 2500, x = RESULT_BASE.MAIN_POS_X + 535 - (107 / 2), y = exscorePosY - (36 / 2), w = 107 * 2, h = 36 * 2},
				{time = 3000, x = RESULT_BASE.MAIN_POS_X + 535, y = exscorePosY, w = 107, h = 36}
			}
		})

		if PROPERTY.isShowItemCombo() then
			-- 文字
			table.insert(parts.destination, {
				id = "wdCombo", dst = {
					{x = RESULT_BASE.MAIN_POS_X, y = itemPosY - 13, w = 210, h = 60},
				}
			})
			-- コンボ数
			table.insert(parts.destination, {
				id = "mainCombo", dst = {
					{x = RESULT_BASE.MAIN_POS_X + 222, y = itemPosY, w = 28, h = 36},
				}
			})
			-- コンボ差分
			table.insert(parts.destination, {
				id = "mainComboDiff", dst = {
					{x = RESULT_BASE.MAIN_POS_X + 380, y = itemPosY + 5, w = 22, h = 28},
				}
			})
			-- コンボ更新
			table.insert(parts.destination, {
				id = "scoreUpdate", loop = 3000, op = {MAIN.OP.UPDATE_MAXCOMBO}, dst = {
					{time = 2500, x = RESULT_BASE.MAIN_POS_X + 535 - (107 / 2), y = itemPosY - (36 / 2), w = 107 * 2, h = 36 * 2},
					{time = 3000, x = RESULT_BASE.MAIN_POS_X + 535, y = itemPosY, w = 107, h = 36}
				}
			})
		elseif PROPERTY.isShowItemMisscount() then
			-- 文字
			table.insert(parts.destination, {
				id = "wdMisscount", dst = {
					{x = RESULT_BASE.MAIN_POS_X, y = itemPosY - 13, w = 210, h = 60},
				}
			})
			-- ミスカウント数
			table.insert(parts.destination, {
				id = "numMisscount", dst = {
					{x = RESULT_BASE.MAIN_POS_X + 222, y = itemPosY, w = 28, h = 36},
				}
			})
			-- ミスカウント差分
			table.insert(parts.destination, {
				id = "numMisscountDiff", dst = {
					{x = RESULT_BASE.MAIN_POS_X + 380, y = itemPosY + 5, w = 22, h = 28},
				}
			})
			-- ミスカウント更新
			table.insert(parts.destination, {
				id = "scoreUpdate", loop = 3000, op = {MAIN.OP.UPDATE_MISSCOUNT}, dst = {
					{time = 2500, x = RESULT_BASE.MAIN_POS_X + 535 - (107 / 2), y = itemPosY - (36 / 2), w = 107 * 2, h = 36 * 2},
					{time = 3000, x = RESULT_BASE.MAIN_POS_X + 535, y = itemPosY, w = 107, h = 36}
				}
			})
		end

		-- ピカグレ数
		table.insert(parts.destination, {
			id = "numPG", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 222, y = pgPosY, w = 28, h = 36},
			}
		})

		-- GREAT, GOOD, BAD, POOR, MISS数
		do
			local wd = {"numGR", "numGD", "numBD", "numPR", "numMS"}
			local pos = {greatPosY, goodPosY, badPosY, poorPosY, missPosY}
			for i = 1, 5, 1 do
				-- グレ数
				table.insert(parts.destination, {
					id = wd[i], timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
						{x = RESULT_BASE.MAIN_POS_X + 222, y = pos[i], w = 28, h = 36},
					}
				})
				table.insert(parts.destination, {
					id = wd[i] .."_SL", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
						{x = RESULT_BASE.MAIN_POS_X + 390, y = pos[i], w = 28, h = 36},
					}
				})
				table.insert(parts.destination, {
					id = wd[i] .."_ER", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
						{x = RESULT_BASE.MAIN_POS_X + 530, y = pos[i], w = 28, h = 36},
					}
				})
			end
		end
	end

	-- 判定カウンターグラフ
	do
		local posY = 400
		table.insert(parts.destination, {
			id = "timingGraphFrame", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 390, y = posY, w = 250, h = 60},
			}
		})
		table.insert(parts.destination, {
			id = "gra_slowRate", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 392, y = posY + 27, w = 246, h = 26}
			}
		})
		table.insert(parts.destination, {
			id = "gra_fastRate", loop = 2500, timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 638, y = posY + 27, w = -246, h = 26}
			}
		})
		table.insert(parts.destination, {
			id = "timingSlowNum", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 415, y = posY + 30, w = 16, h = 20},
			}
		})
		table.insert(parts.destination, {
			id = "timingFastNum", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 555, y = posY + 30, w = 16, h = 20},
			}
		})
	end

	-- メインメニュー2
	table.insert(parts.destination, {
		id = "mainJudgeFrame2", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
			{x = RESULT_BASE.MAIN_POS_X, y = 70, w = 665, h = 582},
		}
	})
	-- 判定レベル
	do
		local wd = {"judgeVE", "judgeE", "judgeN", "judgeH", "judgeVH"}
		local op = {
			MAIN.OP.JUDGE_VERYEASY,
			MAIN.OP.JUDGE_EASY,
			MAIN.OP.JUDGE_NORMAL,
			MAIN.OP.JUDGE_HARD,
			MAIN.OP.JUDGE_VERYHARD
		}
		local posY = 590
		for i = 1, 5, 1 do
			table.insert(parts.image, {id = wd[i], src = 2, x = 2000, y = posY, w = 230, h = 60})
			posY = posY + 60
			table.insert(parts.destination, {
				id = wd[i], timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), op = {op[i]}, dst = {
					{x = RESULT_BASE.MAIN_POS_X + 180, y = 530, w = 230, h = 60},
				}
			})
		end
	end
	-- リプレイ
	do
		local noReplayOp = {MAIN.OP.NO_REPLAYDATA, MAIN.OP.NO_REPLAYDATA2, MAIN.OP.NO_REPLAYDATA3, MAIN.OP.NO_REPLAYDATA4}
		local replayOp = {MAIN.OP.REPLAYDATA, MAIN.OP.REPLAYDATA2, MAIN.OP.REPLAYDATA3, MAIN.OP.REPLAYDATA4}
		local replaySaveOp = {MAIN.OP.REPLAYDATA_SAVED, MAIN.OP.REPLAYDATA2_SAVED, MAIN.OP.REPLAYDATA3_SAVED, MAIN.OP.REPLAYDATA4_SAVED}
		local wd = {"none", "normal", "save"}
		local posX = 0
		local posY = 2040
		for i = 1, 3, 1 do
			posX = 260
			for j = 1, 4, 1 do
				table.insert(parts.image, {id = "replay-" ..wd[i] .."-" ..j, src = 2, x = posX, y = posY, w = 53, h = 46})
				posX = posX + 53
			end
			posY = posY + 46
		end
		for i = 1, 3, 1 do
			local posX = 0
			for j = 1, 4, 1 do
				-- リプレイなし
				table.insert(parts.destination, {
					id = "replay-none" .."-" ..j, op = {noReplayOp[j]}, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
						{x = RESULT_BASE.MAIN_POS_X + 415 + posX, y = 540, w = 53, h = 46},
					}
				})
				-- リプレイあり
				table.insert(parts.destination, {
					id = "replay-normal" .."-" ..j, op = {replayOp[j]}, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
						{x = RESULT_BASE.MAIN_POS_X + 415 + posX, y = 540, w = 53, h = 46},
					}
				})
				-- リプレイ保存
				table.insert(parts.destination, {
					id = "replay-save" .."-" ..j, op = {replaySaveOp[j]}, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
						{time = 0, x = RESULT_BASE.MAIN_POS_X + 415 + posX, y = 540, w = 53, h = 46},
						{time = 500, a = 80},
						{time = 1000, a = 255}
					}
				})
				posX = posX + 58
			end
		end
	end

	-- トータル
	table.insert(parts.destination, {
		id = "numTOTAL", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
			return main_state.number(MAIN.NUM.SONGGAUGE_TOTAL) >= CUSTOM.NUM.calcTotal()
		end, dst = {
			{x = RESULT_BASE.MAIN_POS_X + 187, y = 480, w = 28, h = 36, r = 83, g = 180, b = 248},
		}
	})
	table.insert(parts.destination, {
		id = "numTOTAL", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
			return main_state.number(MAIN.NUM.SONGGAUGE_TOTAL) < CUSTOM.NUM.calcTotal()
		end, dst = {
			{x = RESULT_BASE.MAIN_POS_X + 187, y = 480, w = 28, h = 36, r = 248, g = 83, b = 83},
		}
	})
	-- 参考トータル
	table.insert(parts.destination, {
		id = "numRefTOTAL", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
			{x = RESULT_BASE.MAIN_POS_X + 500, y = 480, w = 28, h = 36},
		}
	})

	if flg == 0 then
		-- グラフ関連表示
		table.insert(parts.destination, {
			id = "graphFrame", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X, y = 78, w = 670, h = 385},
			}
		})
		-- ノート構成グラフ
		table.insert(parts.destination, {
			id = "notesGraph", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 16, y = 341, w = 633, h = 88},
			}
		})
		table.insert(parts.destination, {
			id = "bpmgraph", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 16, y = 341, w = 633, h = 88},
			}
		})
		-- FAST SLOWグラフ
		table.insert(parts.destination, {
			id = "fsGraph", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X + 16, y = 211, w = 633, h = 88},
			}
		})
		do
			local ratePosY = 179
			-- タイミンググラフ
			table.insert(parts.destination, {
				id = "timingdistributiongraph", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
					{x = RESULT_BASE.MAIN_POS_X + 16, y = 81, w = 633, h = 88},
				}
			})
			table.insert(parts.destination, {
				id = "timFS", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
					{x = RESULT_BASE.MAIN_POS_X, y = 140, w = 652, h = 25, a = 200},
				}
			})
			-- 倍率
			table.insert(parts.destination, {
				id = "magnification", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
					{x = RESULT_BASE.MAIN_POS_X + 120, y = ratePosY - 2, w = 100, h = 18}
				}
			})
			-- 標準偏差
			table.insert(parts.destination, {
				id = "stddevRate", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
					{x = RESULT_BASE.MAIN_POS_X + 354, y = ratePosY, w = 15, h = 18},
				}
			})
			table.insert(parts.destination, {
				id = "stddevRateAfterdot", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
					{x = RESULT_BASE.MAIN_POS_X + 396, y = ratePosY, w = 15, h = 18},
				}
			})
			-- タイミング平均
			table.insert(parts.destination, {
				id = "aveTimRate", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
					{x = RESULT_BASE.MAIN_POS_X + 567, y = ratePosY, w = 15, h = 18},
				}
			})
			table.insert(parts.destination, {
				id = "aveTimRateAfterdot", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
					{x = RESULT_BASE.MAIN_POS_X + 609, y = ratePosY, w = 15, h = 18},
				}
			})
		end
		-- 通常
		-- ステージファイルあり
		--[[
		table.insert(parts.destination, {
			id = MAIN.IMAGE.STAGEFILE, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), op = {MAIN.OP.STAGEFILE}, stretch = MAIN.STRETCH.FIT_OUTER_TRIMMED, dst = {
				{x = RESULT_BASE.MAIN_POS_X + 13, y = 84, w = 640, h = 380, a = 150},
			}
		})
		table.insert(parts.destination, {
			id = MAIN.IMAGE.STAGEFILE, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), op = {MAIN.OP.STAGEFILE}, stretch = MAIN.STRETCH.FIT_INNER, dst = {
				{x = RESULT_BASE.MAIN_POS_X + 13, y = 84, w = 640, h = 380},
			}
		})
		-- ステージファイルなし
		table.insert(parts.destination, {
			id = "noimage", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), op = {MAIN.OP.NO_STAGEFILE}, dst = {
				{x = RESULT_BASE.MAIN_POS_X + 13, y = 84, w = 640, h = 380},
			}
		})
		]]
	else
		-- コース
		local posY = {350, 285, 220, 155, 90}
		table.insert(parts.destination, {
			id = "courseFrame", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), dst = {
				{x = RESULT_BASE.MAIN_POS_X, y = 78, w = 652, h = 377},
			}
		})
		-- 5曲以内
		table.insert(parts.destination, {
			id = "course_1-5", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
				return main_state.text(MAIN.STRING.COURSE6_TITLE) == ""
			end, dst = {
				{x = RESULT_BASE.MAIN_POS_X + 13, y = 80, w = 100, h = 320},
			}
		})
		-- 曲名(1-5)
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "course" ..i, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
					return main_state.text(MAIN.STRING.COURSE6_TITLE) == ""
				end, dst = {
					{x = RESULT_BASE.MAIN_POS_X + 383, y = posY[i], w = 520, h = 30}
				}
			})
		end

		-- 6曲以上
		-- 1-5
		table.insert(parts.destination, {
			id = "course_1-5", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
				return main_state.text(MAIN.STRING.COURSE6_TITLE) ~= ""
			end, dst = {
				{time = 0, x = RESULT_BASE.MAIN_POS_X + 13, y = 80, w = 100, h = 320},
				{time = 1999},
				{time = 2000, a = 0},
				{time = 4000}
			}
		})
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "course" ..i, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
					return main_state.text(MAIN.STRING.COURSE6_TITLE) ~= ""
				end, dst = {
					{time = 0, x = RESULT_BASE.MAIN_POS_X + 383, y = posY[i], w = 520, h = 30},
					{time = 1999},
					{time = 2000, a = 0},
					{time = 4000}
				}
			})
		end
		-- 6-10
		table.insert(parts.destination, {
			id = "course_6-10", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
				return main_state.text(MAIN.STRING.COURSE6_TITLE) ~= ""
			end, dst = {
				{time = 0, x = RESULT_BASE.MAIN_POS_X + 13, y = 80, w = 100, h = 320, a = 0},
				{time = 1999},
				{time = 2000, a = 255},
				{time = 4000}
			}
		})
		-- 曲名(1-5)
		for i = 1, 5, 1 do
			table.insert(parts.destination, {
				id = "course" ..5 + i, timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), draw = function()
					return main_state.text(MAIN.STRING.COURSE6_TITLE) ~= ""
				end, dst = {
					{time = 0, x = RESULT_BASE.MAIN_POS_X + 383, y = posY[i], w = 520, h = 30, a = 0},
					{time = 1999},
					{time = 2000, a = 255},
					{time = 4000}
				}
			})
		end
	end

	-- メインメニュー切り替え
	table.insert(parts.destination, {
		id = "mainMenu", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 11, y = 601, w = 234, h = 43},
		}
	})
	table.insert(parts.destination, {
		id = "mainMenuRect", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 11, y = 601, w = 234, h = 43},
		}, mouseRect = {x = 0, y = 0, w = 234, h = 43}
	})

	-- 共通
	-- 今回のクリアランク
	do
		local wd = {"thisTimeAAA", "thisTimeAA", "thisTimeA", "thisTimeB", "thisTimeC", "thisTimeD", "thisTimeE", "thisTimeF"}
		local op = {
			MAIN.OP.RESULT_AAA_1P,
			MAIN.OP.RESULT_AA_1P,
			MAIN.OP.RESULT_A_1P,
			MAIN.OP.RESULT_B_1P,
			MAIN.OP.RESULT_C_1P,
			MAIN.OP.RESULT_D_1P,
			MAIN.OP.RESULT_E_1P,
			MAIN.OP.RESULT_F_1P
		}
		local posY = 1110
		for i = 1, 8, 1 do
			table.insert(parts.image, {id = wd[i], src = 2, x = 0, y = posY, w = 142, h = 43})
			posY = posY + 43
		end
		for i = 1, 8, 1 do
			table.insert(parts.destination, {
				id = wd[i], op = {op[i]}, dst = {
					{x = RESULT_BASE.MAIN_POS_X + 510, y = 601, w = 142, h = 43},
				}
			})
		end
	end
	-- クリアランク更新
	do
		table.insert(parts.destination, {
			id = "rankUpdate", draw = function()
				local prev = main_state.number(MAIN.NUM.TARGET_CLEAR)
				local bestRank = CUSTOM.NUM.bestRank()
				local nowRank = CUSTOM.NUM.nowRank()
				return (bestRank < nowRank) and (prev ~= 0)
			end, dst = {
				{x = RESULT_BASE.MAIN_POS_X + 499, y = 585, w = 165, h = 74},
			}
		})
	end

	-- 今回のクリアタイプ
	table.insert(parts.destination, {
		id = "clearType", dst = {
			{x = RESULT_BASE.MAIN_POS_X + 261, y = 601, w = 234, h = 43},
		}
	})
	-- クリアタイプ更新（オプション値がないので自作する必要あり）
	table.insert(parts.destination, {
		id = "lampUpdate", draw = function()
			-- 以前のクリアランプを数値
			local prev = main_state.number(MAIN.NUM.TARGET_CLEAR)
			-- 今回のクリアランプ
			local now = main_state.number(MAIN.NUM.CLEAR)
			-- 比較時今回が上回っている　かつ　初見ではない
			return prev < now and prev ~= 0
		end, dst = {
			{x = RESULT_BASE.MAIN_POS_X + 252, y = 585, w = 254, h = 74},
		}
	})

	do
		-- 修飾用パーツ
		local posY = {525, 460, 395, 330, 265, 200, 135, 70}
		local delay = 0
		for i = 1, 8, 1 do
			table.insert(parts.destination, {
				id = "lampGreen", timer = timer_util.timer_observe_boolean(function() return isInfoMenu1 end), blend = MAIN.BLEND.ADDITION, dst = {
					{time = 0, x = RESULT_BASE.MAIN_POS_X + 4, y = posY[i], w = 38, h = 76, a = 255},
					{time = 0 + delay},
					{time = 2000 - delay, a = 50},
					{time = 2000 + delay},
					{time = 4000, a = 255}
				}
			})
			delay = delay + 100
		end
	end
	do
		-- 修飾用パーツ
		local posY = {525, 460}
		local delay = 0
		for i = 1, 2, 1 do
			table.insert(parts.destination, {
				id = "lampGreen", timer = timer_util.timer_observe_boolean(function() return isInfoMenu2 end), blend = MAIN.BLEND.ADDITION, dst = {
					{time = 0, x = RESULT_BASE.MAIN_POS_X + 4, y = posY[i], w = 38, h = 76, a = 255},
					{time = 0 + delay},
					{time = 2000 - delay, a = 50},
					{time = 2000 + delay},
					{time = 4000, a = 255}
				}
			})
			delay = delay + 100
		end
	end
	do
		-- キーボード入力用（いる？）
		table.insert(parts.destination, {
			id = MAIN.IMAGE.BLACK, draw = function()
				if Gdx.input:isKeyPressed(input.Keys.RIGHT) then
					isInfoMenu1 = true
					isInfoMenu2 = false
				elseif Gdx.input:isKeyPressed(input.Keys.LEFT) then
					isInfoMenu1 = false
					isInfoMenu2 = true
				end
			end, dst = {
				{x = 0, y = 0, w = 0, h = 0},
			}
		})
	end

	return parts
end

return {
	load = load
}