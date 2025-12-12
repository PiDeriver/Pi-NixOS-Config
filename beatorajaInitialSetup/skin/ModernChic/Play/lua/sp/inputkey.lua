--[[
	SP用キー入力関連

	playsidePositionX
	notesPositionY : 判定ライン基準
	keyNum : 鍵盤数
	@author : KASAKO
]]

local function load(keyNum)
	local parts = {}

	-- 配置位置
	local posX = {}
	-- 鍵盤の種類
	local init = {}
	-- 鍵盤の横幅
	local width = {}
	-- キー入力タイマー
	local keyOnTimer = {}
	-- キー離しタイマー
	local keyOffTimer = {}
	-- 移動距離
	local move_x = {}

	if keyNum == 5 then
		init = {"w", "b", "w", "b", "w", "s"}
		width = {60, 48, 60, 48, 60, 108}
		keyOnTimer = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5, MAIN.TIMER.KEYON_1P_SCRATCH}
		keyOffTimer = {MAIN.TIMER.KEYOFF_1P_KEY1, MAIN.TIMER.KEYOFF_1P_KEY2, MAIN.TIMER.KEYOFF_1P_KEY3, MAIN.TIMER.KEYOFF_1P_KEY4, MAIN.TIMER.KEYOFF_1P_KEY5, MAIN.TIMER.KEYOFF_1P_SCRATCH}
		if PROPERTY.isLeftScratch() then
			posX = {114, 177, 228, 291, 342, 3}
			move_x = {144, 201, 258, 315, 372, 57}
		elseif PROPERTY.isRightScratch() then
			posX = {117, 180, 231, 294, 345, 407}
			move_x = {147, 204, 261, 318, 375, 461}
		end
	elseif keyNum == 7 then
		init = {"w", "b", "w", "b", "w", "b", "w", "s"}
		width = {60, 48, 60, 48, 60, 48, 60, 108}
		keyOnTimer = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5, MAIN.TIMER.KEYON_1P_KEY6, MAIN.TIMER.KEYON_1P_KEY7, MAIN.TIMER.KEYON_1P_SCRATCH}
		keyOffTimer = {MAIN.TIMER.KEYOFF_1P_KEY1, MAIN.TIMER.KEYOFF_1P_KEY2, MAIN.TIMER.KEYOFF_1P_KEY3, MAIN.TIMER.KEYOFF_1P_KEY4, MAIN.TIMER.KEYOFF_1P_KEY5, MAIN.TIMER.KEYOFF_1P_KEY6, MAIN.TIMER.KEYOFF_1P_KEY7, MAIN.TIMER.KEYOFF_1P_SCRATCH}
		if PROPERTY.isLeftScratch() then
			posX = {114, 177, 228, 291, 342, 405, 456, 3}
			move_x = {144, 201, 258, 315, 372, 429, 486, 57}
		elseif PROPERTY.isRightScratch() then
			posX = {3, 66, 117, 180, 231, 294, 345, 407}
			move_x = {33, 90, 147, 204, 261, 318, 375, 461}
		end
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
				table.insert(parts.destination,	{
					id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOnTimer[i], blend = MAIN.BLEND.ALPHA, dst = {
						{x = BASE.playsidePositionX + posX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height}
					}
				})
			end
			-- 皿
			table.insert(parts.destination,	{
				id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOnTimer[#init], blend = MAIN.BLEND.ALPHA, loop = -1, op = {MAIN.OP.AUTOPLAYOFF}, dst = {
					{time = 0, x = BASE.playsidePositionX + posX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = 0},
					{time = 50, h = keybeam_height},
					{time = 85},
					{time = 170, x = BASE.playsidePositionX + posX[#init] + 54, w = 0, a = 0}
				}
			})
			-- 皿（オートプレイ時）
			table.insert(parts.destination,	{
				id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOnTimer[#init], blend = MAIN.BLEND.ALPHA, op = {MAIN.OP.AUTOPLAYON}, dst = {
					{x = BASE.playsidePositionX + posX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height}
				}
			})
		end
		
		-- キーが離されたとき(1234567Sの順)-----------------------------------------
		do
			local time_keyoff = COMMONFUNC.setTimeKeyOff()
			if PROPERTY.isBeamDisappearanceTypeL() then
				-- TYPE-L
				for i = 1, #init - 1, 1 do
					table.insert(parts.destination,	{
						id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOffTimer[i], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, dst = {
							{time = 0, x = BASE.playsidePositionX + posX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
							{time = time_keyoff, a = 0}
						}
					})
				end
				-- 皿はオートプレイのみ適用
				table.insert(parts.destination,	{
					id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOffTimer[#init], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, op = {MAIN.OP.AUTOPLAYON}, dst = {
						{time = 0, x = BASE.playsidePositionX + posX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
						{time = time_keyoff, a = 0}
					}
				})
			elseif PROPERTY.isBeamDisappearanceTypeB() then
				for i = 1, #init - 1, 1 do
					table.insert(parts.destination,	{
						id = "keybeam-"..init[i], offset = MAIN.OFFSET.LIFT, timer = keyOffTimer[i], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, dst = {
							{time = 0, x = BASE.playsidePositionX + posX[i], y = BASE.NOTES_JUDGE_Y, w = width[i], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
							{time = time_keyoff, x = BASE.playsidePositionX + move_x[i], w = 0, a = 0}
						}
					})
				end
				-- 皿はオートのみ適用
				table.insert(parts.destination,	{
					id = "keybeam-"..init[#init], offset = MAIN.OFFSET.LIFT, timer = keyOffTimer[#init], blend = MAIN.BLEND.ALPHA, loop = time_keyoff, op = {MAIN.OP.AUTOPLAYON}, dst = {
						{time = 0, x = BASE.playsidePositionX + posX[#init], y = BASE.NOTES_JUDGE_Y, w = width[#init], h = keybeam_height, acc = MAIN.ACC.DECELERATE},
						{time = time_keyoff, x = BASE.playsidePositionX + move_x[#init], w = 0, a = 0}
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