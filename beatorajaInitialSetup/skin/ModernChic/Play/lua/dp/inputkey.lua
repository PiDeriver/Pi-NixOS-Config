--[[
	DP用キー入力関連

	BASE.laneLeftPosX : 1P側基準
	LaneRightPosX : 2P側基準
	BASE.NOTES_JUDGE_Y : 判定ライン基準
	keyNum : 鍵盤数
	@author : KASAKO
]]

local function load(keyNum)
	local parts = {}

	-- 鍵盤の種類
	local init = {}
	-- 配置位置
	local keyLeftPosX = {}
	local keyRightPosX = {}
	-- 鍵盤の横幅
	local width = {}
	-- キー入力タイマー
	local keyOnTimerLeft = {}
	local keyOnTimerRight = {}
	-- キー離しタイマー
	local keyOffTimerLeft = {}
	local keyOffTimerRight = {}
	-- 移動距離
	local movePosxLeft = {}
	local movePosxRight = {}

	if keyNum == 10 then
		init = {"w", "b", "w", "b", "w", "s"}
		keyLeftPosX = {114, 177, 228, 291, 342, 3}
		keyRightPosX = {117, 180, 231, 294, 345, 407}
		width = {60, 48, 60, 48, 60, 108}
		keyOnTimerLeft = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5, MAIN.TIMER.KEYON_1P_SCRATCH}
		keyOnTimerRight = {MAIN.TIMER.KEYON_2P_KEY1, MAIN.TIMER.KEYON_2P_KEY2, MAIN.TIMER.KEYON_2P_KEY3, MAIN.TIMER.KEYON_2P_KEY4, MAIN.TIMER.KEYON_2P_KEY5, MAIN.TIMER.KEYON_2P_SCRATCH}
		keyOffTimerLeft = {MAIN.TIMER.KEYOFF_1P_KEY1, MAIN.TIMER.KEYOFF_1P_KEY2, MAIN.TIMER.KEYOFF_1P_KEY3, MAIN.TIMER.KEYOFF_1P_KEY4, MAIN.TIMER.KEYOFF_1P_KEY5, MAIN.TIMER.KEYOFF_1P_SCRATCH}
		keyOffTimerRight = {MAIN.TIMER.KEYOFF_2P_KEY1, MAIN.TIMER.KEYOFF_2P_KEY2, MAIN.TIMER.KEYOFF_2P_KEY3, MAIN.TIMER.KEYOFF_2P_KEY4, MAIN.TIMER.KEYOFF_2P_KEY5, MAIN.TIMER.KEYOFF_2P_SCRATCH}
		movePosxLeft = {144, 201, 258, 315, 372, 57}
		movePosxRight = {147, 204, 261, 318, 375, 461}
	elseif keyNum == 14 then
		init = {"w", "b", "w", "b", "w", "b", "w", "s"}
		keyLeftPosX = {114, 177, 228, 291, 342, 405, 456, 3}
		keyRightPosX = {3, 66, 117, 180, 231, 294, 345, 407}
		width = {60, 48, 60, 48, 60, 48, 60, 108}
		keyOnTimerLeft = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5, MAIN.TIMER.KEYON_1P_KEY6, MAIN.TIMER.KEYON_1P_KEY7, MAIN.TIMER.KEYON_1P_SCRATCH}
		keyOnTimerRight = {MAIN.TIMER.KEYON_2P_KEY1, MAIN.TIMER.KEYON_2P_KEY2, MAIN.TIMER.KEYON_2P_KEY3, MAIN.TIMER.KEYON_2P_KEY4, MAIN.TIMER.KEYON_2P_KEY5, MAIN.TIMER.KEYON_2P_KEY6, MAIN.TIMER.KEYON_2P_KEY7, MAIN.TIMER.KEYON_2P_SCRATCH}
		keyOffTimerLeft = {MAIN.TIMER.KEYOFF_1P_KEY1, MAIN.TIMER.KEYOFF_1P_KEY2, MAIN.TIMER.KEYOFF_1P_KEY3, MAIN.TIMER.KEYOFF_1P_KEY4, MAIN.TIMER.KEYOFF_1P_KEY5, MAIN.TIMER.KEYOFF_1P_KEY6, MAIN.TIMER.KEYOFF_1P_KEY7, MAIN.TIMER.KEYOFF_1P_SCRATCH}
		keyOffTimerRight = {MAIN.TIMER.KEYOFF_2P_KEY1, MAIN.TIMER.KEYOFF_2P_KEY2, MAIN.TIMER.KEYOFF_2P_KEY3, MAIN.TIMER.KEYOFF_2P_KEY4, MAIN.TIMER.KEYOFF_2P_KEY5, MAIN.TIMER.KEYOFF_2P_KEY6, MAIN.TIMER.KEYOFF_2P_KEY7, MAIN.TIMER.KEYOFF_2P_SCRATCH}
		movePosxLeft = {144, 201, 258, 315, 372, 429, 486, 57}
		movePosxRight = {33, 90, 147, 204, 261, 318, 375, 461}
	end
	
	parts.image = {
		-- キービーム
		{id = "keybeam-w", src = 14, x = 0, y = 0, w = 60, h = 564},
		{id = "keybeam-b", src = 14, x = 70, y = 0, w = 48, h = 564},
		{id = "keybeam-s", src = 14, x = 130, y = 0, w = 108, h = 564},
	}
	
	parts.destination = {}
	do
		-- キービームの長さ
		local keybeam_height = COMMONFUNC.setKeybeamHeight()
		
		-- キーが押されたとき-----------------------------------------------------
		do

			for i = 1, #init - 1, 1 do
				-- 左
				table.insert(parts.destination,	{
					id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOnTimerLeft[i], blend = MAIN.BLEND.ALPHA, dst = {
						{x = BASE.laneLeftPosX + keyLeftPosX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height}
					}
				})
				-- 右
				table.insert(parts.destination,	{
					id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOnTimerRight[i], blend = MAIN.BLEND.ALPHA, dst = {
						{x = BASE.laneRightPosX + keyRightPosX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height}
					}
				})
			end
			-- 左皿
			table.insert(parts.destination,	{
				id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOnTimerLeft[#init], blend = MAIN.BLEND.ALPHA, loop = -1, op = {MAIN.OP.AUTOPLAYOFF}, dst = {
					{time = 0, x = BASE.laneLeftPosX + keyLeftPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = 0},
					{time = 50, h = keybeam_height},
					{time = 85},
					{time = 170, x = BASE.laneLeftPosX + keyLeftPosX[#init] + 54, w = 0, a = 0}
				}
			})
			-- 右皿
			table.insert(parts.destination,	{
				id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOnTimerRight[#init], blend = MAIN.BLEND.ALPHA, loop = -1, op = {MAIN.OP.AUTOPLAYOFF}, dst = {
					{time = 0, x = BASE.laneRightPosX + keyRightPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = 0},
					{time = 50, h = keybeam_height},
					{time = 85},
					{time = 170, x = BASE.laneRightPosX + keyRightPosX[#init] + 54, w = 0, a = 0}
				}
			})
			-- 左皿（オートプレイ時）
			table.insert(parts.destination,	{
				id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOnTimerLeft[#init], blend = MAIN.BLEND.ALPHA, op = {MAIN.OP.AUTOPLAYON}, dst = {
					{x = BASE.laneLeftPosX + keyLeftPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height}
				}
			})
			-- 右皿（オートプレイ時）
			table.insert(parts.destination,	{
				id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOnTimerRight[#init], blend = MAIN.BLEND.ALPHA, op = {MAIN.OP.AUTOPLAYON}, dst = {
					{x = BASE.laneRightPosX + keyRightPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height}
				}
			})
		end

		-- キーが離されたとき(1234567Sの順)-----------------------------------------
		do
			local time_keyoff = COMMONFUNC.setTimeKeyOff()
			if PROPERTY.isBeamDisappearanceTypeL() then
				-- TYPE-L
				for i = 1, #init - 1, 1 do
					-- 左
					table.insert(parts.destination,	{
						id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerLeft[i], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, dst = {
							{time = 0, x = BASE.laneLeftPosX + keyLeftPosX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
							{time = time_keyoff, a = 0}
						}
					})
					-- 右
					table.insert(parts.destination,	{
						id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerRight[i], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, dst = {
							{time = 0, x = BASE.laneRightPosX + keyRightPosX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
							{time = time_keyoff, a = 0}
						}
					})
				end
				-- 皿はオートプレイのみ適用
				table.insert(parts.destination,	{
					id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerLeft[#init], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, op = {33}, dst = {
						{time = 0, x = BASE.laneLeftPosX + keyLeftPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
						{time = time_keyoff, a = 0}
					}
				})
				table.insert(parts.destination,	{
					id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerRight[#init], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, op = {33}, dst = {
						{time = 0, x = BASE.laneRightPosX + keyRightPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
						{time = time_keyoff, a = 0}
					}
				})
			elseif PROPERTY.isBeamDisappearanceTypeB() then
				for i = 1, #init - 1, 1 do
					-- 左
					table.insert(parts.destination,	{
						id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerLeft[i], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, dst = {
							{time = 0, x = BASE.laneLeftPosX + keyLeftPosX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
							{time = time_keyoff, x = BASE.laneLeftPosX + movePosxLeft[i], w = 0, a = 0}
						}
					})
					-- 右
					table.insert(parts.destination,	{
						id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerRight[i], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, dst = {
							{time = 0, x = BASE.laneRightPosX + keyRightPosX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
							{time = time_keyoff, x = BASE.laneRightPosX + movePosxRight[i], w = 0, a = 0}
						}
					})
				end
				-- 皿はオートのみ適用
				table.insert(parts.destination,	{
					id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerLeft[#init], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, op = {MAIN.OP.AUTOPLAYON}, dst = {
						{time = 0, x = BASE.laneLeftPosX + keyLeftPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
						{time = time_keyoff, x = BASE.laneLeftPosX + movePosxLeft[#init], w = 0, a = 0}
					}
				})
				table.insert(parts.destination,	{
					id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOffTimerRight[#init], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, op = {MAIN.OP.AUTOPLAYON}, dst = {
						{time = 0, x = BASE.laneRightPosX + keyRightPosX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
						{time = time_keyoff, x = BASE.laneRightPosX + movePosxRight[#init], w = 0, a = 0}
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