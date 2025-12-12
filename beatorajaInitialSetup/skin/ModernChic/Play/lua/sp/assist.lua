--[[
	FAST,SLOW
	スコア差分の配置
	@author : KASAKO
--]]

-- ターゲット差分とfast/slow表示位置の決定
local function setDifTimPosition()
	-- ターゲット差分表示位置
	local difftargetPosition
	-- fast/slow表示位置
	local judgeTimingPosition
	
	-- 表示位置によってx値を変える
	local dpx
	local fpx
	if PROPERTY.isLeftPosition() then
		dpx = 520
		fpx = 520
	elseif PROPERTY.isRightPosition() then
		dpx = -140
		fpx = -113
	end
	
	-- 差分表示位置
	if PROPERTY.isDiffTargetOn() then
		if PROPERTY.isDiffTargetTypeA() then
			difftargetPosition = {165, 253}
		elseif PROPERTY.isDiffTargetTypeB() then
			difftargetPosition = {dpx, 160}
		elseif PROPERTY.isDiffTargetTypeC() then
			difftargetPosition = {dpx, -20}
		elseif PROPERTY.isDiffTargetTypeD() then
			difftargetPosition = {165, 123}
		end
	end
	if PROPERTY.isJudgeTimingOn() then
		if PROPERTY.isJudgeTimingTypeA() then
			judgeTimingPosition = {185, 250}
		elseif PROPERTY.isJudgeTimingTypeB() then
			judgeTimingPosition = {fpx, 190}
		elseif PROPERTY.isJudgeTimingTypeC() then
			judgeTimingPosition = {fpx, 10}
		elseif PROPERTY.isJudgeTimingTypeD() then
			judgeTimingPosition = {185, 120}
		end
	end
	if PROPERTY.isDiffTargetOn() then
		if PROPERTY.isJudgeTimingOn() then
			-- 両方TypeAで表示
			if PROPERTY.isDiffTargetTypeA() then
				if PROPERTY.isJudgeTimingTypeA() then
					difftargetPosition = {100, 253}
					judgeTimingPosition = {250, 253}
				end
			end
			-- 両方TypeDで表示
			if PROPERTY.isDiffTargetTypeD() then
				if PROPERTY.isJudgeTimingTypeD() then
					difftargetPosition = {100, 123}
					judgeTimingPosition = {250, 123}
				end
			end
		end
	end
	return difftargetPosition, judgeTimingPosition
end

local function load()
	local parts = {}
	
	parts.image = {
		-- FAST
		{id = "fast", src = 1, x = 1590, y = 410, w = 110, h = 20},
		-- SLOW
		{id = "slow", src = 1, x = 1590, y = 430, w = 110, h = 20},
	}
	
	parts.value = {
		-- マイベストとのEXSCORE差分
		-- zeropadding 1:0で埋める 2:裏0で埋める
		{id = "diffMybestTarget", src = 1, x = 1400, y = 201, w = 324, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_HIGHSCORE, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- ターゲットとのEXSCORE差分
		{id = "diffExscoreTarget", src = 1, x = 1400, y = 201, w = 324, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_TARGETSCORE, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- 判定タイミングのズレ（ミリ）
		{id = "judgeTiming-ms", src = 1, x = 1400, y = 121, w = 324, h = 40, divx = 12, divy = 2, digit = 4, ref = MAIN.NUM.JUDGE_1P_DURATION, zeropadding = MAIN.N_ZEROPADDING.ON},
	}
	
	parts.destination = {}
	
	do
		-- ターゲット差分
		local difftargetPosition, judgeTimingPosition = setDifTimPosition()
		if PROPERTY.isDiffTargetOn() then
			if PROPERTY.isTargetRank() then
				-- 目標ランク
				table.insert(parts.destination,	{
					id = "diffExscoreTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, dst = {
						{time = 0, x = BASE.playsidePositionX + difftargetPosition[1], y = BASE.NOTES_JUDGE_Y + difftargetPosition[2], w = 27, h = 20},
						{time = 500}
					}
				})
			elseif PROPERTY.isTargetMybest() then
				-- 自己べターゲット
				-- 自己べが存在しない場合はターゲット差分に
				table.insert(parts.destination,	{
					id = "diffExscoreTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, draw = function()
						return CUSTOM.OP.isFirstPlay2()
					end, dst = {
						{time = 0, x = BASE.playsidePositionX + difftargetPosition[1], y = BASE.NOTES_JUDGE_Y + difftargetPosition[2], w = 27, h = 20},
						{time = 500}
					}
				})
				table.insert(parts.destination,	{
					id = "diffMybestTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, draw = function()
						return CUSTOM.OP.isNotFirstPlay2()
					end, dst = {
						{time = 0, x = BASE.playsidePositionX + difftargetPosition[1], y = BASE.NOTES_JUDGE_Y + difftargetPosition[2], w = 27, h = 20},
						{time = 500}
					}
				})
			end
		end
		-- 判定タイミング表示
		if PROPERTY.isJudgeTimingOn() then
			if PROPERTY.isJudgeTimingWord() then
				-- FAST/SLOW
				table.insert(parts.destination,	{
					id = "fast", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.EARLY_1P, MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, dst = {
						{time = 0, x = BASE.playsidePositionX + judgeTimingPosition[1], y = BASE.NOTES_JUDGE_Y + judgeTimingPosition[2], w = 110, h = 20},
						{time = 500}
					}
				})
				table.insert(parts.destination,	{
					id = "slow", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.LATE_1P, MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, dst = {
						{time = 0, x = BASE.playsidePositionX + judgeTimingPosition[1], y = BASE.NOTES_JUDGE_Y + judgeTimingPosition[2], w = 110, h = 20},
						{time = 500}
					}
				})
			elseif PROPERTY.isJudgeTimingMs() then
				-- +-ms
				table.insert(parts.destination,	{
					id = "judgeTiming-ms", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, dst = {
						{time = 0, x = BASE.playsidePositionX + judgeTimingPosition[1], y = BASE.NOTES_JUDGE_Y + judgeTimingPosition[2], w = 27, h = 20},
						{time = 500}
					}
				})
			end
		end
	end
	
	return parts
end

return {
	load = load
}