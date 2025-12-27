--[[
	白数字、緑数字
	スコア差分の配置
	@author : KASAKO
--]]

-- ターゲット差分とfast/slow表示位置の決定
-- playsSide 0:1P 1:2P
local function setDifTimPosition(playSide)
	-- ターゲット差分表示位置
	local difftargetPosition = {0, 0}
	-- fast/slow表示位置
	local judgeTimingPosition = {0, 0}

	local dpx = 0
	local fpx = 0
	
	-- 表示位置によってx値を変える
	if playSide == 0 then
		-- 左側（1P）
		if PROPERTY.isDiffTargetTypeB() then
			dpx = -165
		elseif PROPERTY.isDiffTargetTypeC() then
			dpx = 520
		end
		if PROPERTY.isJudgeTimingTypeB() then
			fpx = -140
		elseif PROPERTY.isJudgeTimingTypeC() then
			fpx = 535
		end
	elseif playSide == 1 then
		-- 右側（2P）
		if PROPERTY.isDiffTargetTypeB() then
			dpx = 565
		elseif PROPERTY.isDiffTargetTypeC() then
			-- 使わないが一応残す
			dpx = 0
		end
		if PROPERTY.isJudgeTimingTypeB() then
			fpx = 567
		elseif PROPERTY.isJudgeTimingTypeC() then
			fpx = -55
		end
	end

	-- 差分表示位置
	if PROPERTY.isDiffTargetOn() then
		if PROPERTY.isDiffTargetTypeA() then
			difftargetPosition = {195, 253}
		elseif PROPERTY.isDiffTargetTypeB() then
			difftargetPosition = {dpx, 170}
		elseif PROPERTY.isDiffTargetTypeC() then
			difftargetPosition = {dpx, 170}
		end
	end
	-- 判定タイミング位置
	if PROPERTY.isJudgeTimingOn() then
		if PROPERTY.isJudgeTimingTypeA() then
			judgeTimingPosition = {185, 250}
		elseif PROPERTY.isJudgeTimingTypeB() then
			judgeTimingPosition = {fpx, 200}
		elseif PROPERTY.isJudgeTimingTypeC() then
			judgeTimingPosition = {fpx, 200}
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
		end
	end
	return difftargetPosition, judgeTimingPosition
end

local function load()
	local parts = {}
	
	parts.image = {
		-- FAST(TYPEAのみ)
		{id = "fast", src = 1, x = 380, y = 1020, w = 95, h = 20},
		-- SLOW（TYPEAのみ）
		{id = "slow", src = 1, x = 380, y = 1040, w = 95, h = 20},

		-- FA（TYPEB,C）
		{id = "fa", src = 1, x = 407, y = 1060, w = 48, h = 20},
		-- SL（TYPEB,C）
		{id = "sl", src = 1, x = 407, y = 1080, w = 48, h = 20},
	}
	
	parts.value = {
		-- マイベストとのEXSCORE差分
		-- zeropadding 1:0で埋める 2:裏0で埋める
		{id = "diffMybestTarget", src = 1, x = 720, y = 1040, w = 288, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_HIGHSCORE, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- ターゲットとのEXSCORE差分
		{id = "diffExscoreTarget", src = 1, x = 720, y = 1040, w = 288, h = 40, divx = 12, divy = 2, digit = 5, ref = MAIN.NUM.DIFF_TARGETSCORE, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- 判定タイミングのズレ（ミリ）
		{id = "judgeTimingMsLeft", src = 1, x = 720, y = 1100, w = 288, h = 40, divx = 12, divy = 2, digit = 4, ref = MAIN.NUM.JUDGE_1P_DURATION, zeropadding = MAIN.N_ZEROPADDING.ON},
		{id = "judgeTimingMsRight", src = 1, x = 720, y = 1100, w = 288, h = 40, divx = 12, divy = 2, digit = 4, ref = MAIN.NUM.JUDGE_2P_DURATION, zeropadding = MAIN.N_ZEROPADDING.ON},
	}
	
	parts.destination = {}
	
	do
		-- ターゲット差分
		local difftargetPositionL, judgeTimingPositionL = setDifTimPosition(0)
		local difftargetPositionR, judgeTimingPositionR = setDifTimPosition(1)

		local timers = {MAIN.TIMER.JUDGE_1P, MAIN.TIMER.JUDGE_2P}
		local diffPosX = {BASE.laneLeftPosX + difftargetPositionL[1], BASE.laneRightPosX + difftargetPositionR[1]}
		local diffPosY = {BASE.NOTES_JUDGE_Y + difftargetPositionL[2], BASE.NOTES_JUDGE_Y + difftargetPositionR[2]}

		local timingPosX = {BASE.laneLeftPosX + judgeTimingPositionL[1], BASE.laneRightPosX + judgeTimingPositionR[1]}
		local timingPosY = {BASE.NOTES_JUDGE_Y + judgeTimingPositionL[2], BASE.NOTES_JUDGE_Y + judgeTimingPositionR[2]}
		local fastOp = {MAIN.OP.EARLY_1P, MAIN.OP.EARLY_2P}
		local slowOp = {MAIN.OP.LATE_1P, MAIN.OP.LATE_2P}

		if PROPERTY.isDiffTargetOn() then
			if PROPERTY.isTargetRank() then
				-- TYPECの場合は一つのみ
				if PROPERTY.isDiffTargetTypeC() then
					for i = 1, 2, 1 do
						table.insert(parts.destination,	{
							id = "diffExscoreTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = timers[i], dst = {
								{time = 0, x = BASE.laneLeftPosX + difftargetPositionL[1], y = BASE.NOTES_JUDGE_Y + difftargetPositionL[2], w = 24, h = 20},
								{time = 500}
							}
						})
					end
				elseif PROPERTY.isDiffTargetTypeA() or PROPERTY.isDiffTargetTypeB() then
					-- 目標ランク
					for i = 1, 2, 1 do
						table.insert(parts.destination,	{
							id = "diffExscoreTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = timers[i], dst = {
								{time = 0, x = diffPosX[i], y = diffPosY[i], w = 24, h = 20},
								{time = 500}
							}
						})
					end
				end
			elseif PROPERTY.isTargetMybest() then
				-- TYPECの場合は一つのみ
				-- 自己べが存在しない場合は目標ランクをターゲットに
				if PROPERTY.isDiffTargetTypeC() then
					for i = 1, 2, 1 do
						table.insert(parts.destination,	{
							id = "diffExscoreTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, loop = -1, timer = timers[i], draw = function()
								return CUSTOM.OP.isFirstPlay2()
							end, dst = {
								{time = 0, x = BASE.laneLeftPosX + difftargetPositionL[1], y = BASE.NOTES_JUDGE_Y + difftargetPositionL[2], w = 24, h = 20},
								{time = 500}
							}
						})
						table.insert(parts.destination,	{
							id = "diffMybestTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, loop = -1, timer = timers[i], draw = function()
								return CUSTOM.OP.isNotFirstPlay2()
							end, dst = {
								{time = 0, x = BASE.laneLeftPosX + difftargetPositionL[1], y = BASE.NOTES_JUDGE_Y + difftargetPositionL[2], w = 24, h = 20},
								{time = 500}
							}
						})
					end
				elseif PROPERTY.isDiffTargetTypeA() or PROPERTY.isDiffTargetTypeB() then
					-- 自己べターゲット
					-- 自己べが存在しない場合は目標ランクをターゲットに
					for i = 1, 2, 1 do
						table.insert(parts.destination,	{
							id = "diffExscoreTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, loop = -1, timer = timers[i], draw = function()
								return CUSTOM.OP.isFirstPlay2()
							end, dst = {
								{time = 0, x = diffPosX[i], y = diffPosY[i], w = 24, h = 20},
								{time = 500}
							}
						})
						table.insert(parts.destination,	{
							id = "diffMybestTarget", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, loop = -1, timer = timers[i], draw = function()
								return CUSTOM.OP.isNotFirstPlay2()
							end, dst = {
								{time = 0, x = diffPosX[i], y = diffPosY[i], w = 24, h = 20},
								{time = 500}
							}
						})
					end
				end
			end
		end
		-- 判定タイミング表示
		if PROPERTY.isJudgeTimingOn() then
			if PROPERTY.isJudgeTimingWord() then
				if PROPERTY.isJudgeTimingTypeC() then
					-- FA/SL
					for i = 1, 2, 1 do
						table.insert(parts.destination,	{
							id = "fa", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {fastOp[i], MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = timers[i], dst = {
								{time = 0, x = timingPosX[i], y = timingPosY[i], w = 48, h = 20},
								{time = 500}
							}
						})
						table.insert(parts.destination,	{
							id = "sl", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {slowOp[i], MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = timers[i], dst = {
								{time = 0, x = timingPosX[i], y = timingPosY[i], w = 48, h = 20},
								{time = 500}
							}
						})
					end
				elseif PROPERTY.isJudgeTimingTypeA() or PROPERTY.isJudgeTimingTypeB() then
					-- FAST/SLOW
					for i = 1, 2, 1 do
						table.insert(parts.destination,	{
							id = "fast", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {fastOp[i], MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = timers[i], dst = {
								{time = 0, x = timingPosX[i], y = timingPosY[i], w = 95, h = 20},
								{time = 500}
							}
						})
						table.insert(parts.destination,	{
							id = "slow", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {slowOp[i], MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = timers[i], dst = {
								{time = 0, x = timingPosX[i], y = timingPosY[i], w = 95, h = 20},
								{time = 500}
							}
						})
					end
				end
			elseif PROPERTY.isJudgeTimingMs() then
				-- +-ms
				if PROPERTY.isJudgeTimingTypeC() then
					-- 左
					table.insert(parts.destination,	{
						id = "judgeTimingMsLeft", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, dst = {
							{time = 0, x = BASE.laneLeftPosX + judgeTimingPositionL[1] - 10, y = BASE.NOTES_JUDGE_Y + judgeTimingPositionL[2], w = 13, h = 20},
							{time = 500}
						}
					})
					-- 右
					table.insert(parts.destination,	{
						id = "judgeTimingMsRight", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_2P, dst = {
							{time = 0, x = BASE.laneRightPosX + judgeTimingPositionR[1], y = BASE.NOTES_JUDGE_Y + judgeTimingPositionR[2], w = 13, h = 20},
							{time = 500}
						}
					})
				elseif PROPERTY.isJudgeTimingTypeA() or PROPERTY.isJudgeTimingTypeB() then
					-- 左
					table.insert(parts.destination,	{
						id = "judgeTimingMsLeft", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_1P, dst = {
							{time = 0, x = BASE.laneLeftPosX + judgeTimingPositionL[1], y = BASE.NOTES_JUDGE_Y + judgeTimingPositionL[2], w = 24, h = 20},
							{time = 500}
						}
					})
					-- 右
					table.insert(parts.destination,	{
						id = "judgeTimingMsRight", offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTarjudge.num}, op = {MAIN.OP.AUTOPLAYOFF}, loop = -1, timer = MAIN.TIMER.JUDGE_2P, dst = {
							{time = 0, x = BASE.laneRightPosX + judgeTimingPositionR[1], y = BASE.NOTES_JUDGE_Y + judgeTimingPositionR[2], w = 24, h = 20},
							{time = 500}
						}
					})
				end
			end
		end
	end
	
	return parts
end

return {
	load = load
}