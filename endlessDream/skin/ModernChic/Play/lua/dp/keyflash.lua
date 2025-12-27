--[[
	キー画像と対応するキーフラッシュを配置
	@author : KASAKO
--]]

local function init(key)
	local init = {}
	init.keyflashNormalWidth = 67
	init.keyflashNormalHeight = 73
	init.keyflashScratchWidth = 92
	init.keyflashScratchHeight = 92
	init.whitePosY = 137
	init.blackPosY = 147
	init.flash = {}
	if key == 10 then
		init.flash.leftTimer = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5}
		init.flash.rightTimer = {MAIN.TIMER.KEYON_2P_KEY1, MAIN.TIMER.KEYON_2P_KEY2, MAIN.TIMER.KEYON_2P_KEY3, MAIN.TIMER.KEYON_2P_KEY4, MAIN.TIMER.KEYON_2P_KEY5}
		init.flash.leftPosX = {110, 167, 224, 281, 338}
		init.flash.rightPosX = {113, 170, 227, 284, 341}
		init.flash.num = 5
	elseif key == 14 then
		init.flash.leftTimer = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5, MAIN.TIMER.KEYON_1P_KEY6, MAIN.TIMER.KEYON_1P_KEY7}
		init.flash.rightTimer = {MAIN.TIMER.KEYON_2P_KEY1, MAIN.TIMER.KEYON_2P_KEY2, MAIN.TIMER.KEYON_2P_KEY3, MAIN.TIMER.KEYON_2P_KEY4, MAIN.TIMER.KEYON_2P_KEY5, MAIN.TIMER.KEYON_2P_KEY6, MAIN.TIMER.KEYON_2P_KEY7}
		init.flash.leftPosX = {110, 167, 224, 281, 338, 395, 452}
		init.flash.rightPosX = {-1, 56, 113, 170, 227, 284, 341}
		init.flash.num = 7
	end
	return init
end

local function frame(parts)
	local red = CUSTOM.NUM.randNum(50, 155)
	local green = CUSTOM.NUM.randNum(50, 155)
	local blue = CUSTOM.NUM.randNum(50, 155)
	local scratchTimer = {100, 110}
	local framePos = {
		keyBg = {BASE.laneLeftPosX + 111, BASE.laneRightPosX},
		keyFrame = {BASE.laneLeftPosX + 111, BASE.laneRightPosX},
		scratchBg = {BASE.laneLeftPosX, BASE.laneRightPosX + 408},
		scratchFrame = {BASE.laneLeftPosX, BASE.laneRightPosX + 408},
		scratchFrame2 = {BASE.laneLeftPosX, BASE.laneRightPosX + 408}
	}
	table.insert(parts.image, {id = "keyBg", src = 15, x = 0, y = 0, w = 408, h = 114})
	table.insert(parts.image, {id = "keyFrame", src = 15, x = 0, y = 114, w = 408, h = 114})
	table.insert(parts.image, {id = "scratchBg", src = 15, x = 408, y = 0, w = 111, h = 114})
	table.insert(parts.image, {id = "scratchFrame", src = 15, x = 408, y = 114, w = 111, h = 114})
	table.insert(parts.image, {id = "scratchFrame2", src = 15, x = 408, y = 228, w = 111, h = 114})
	
	-- 1P2Pフレーム
	for i = 1, 2, 1 do
		table.insert(parts.destination,	{
			id = "keyBg", dst = {
				{x = framePos.keyBg[i], y = 110, w = 408, h = 114},
			}
		})
		table.insert(parts.destination,	{
			id = "keyFrame", dst = {
				{x = framePos.keyFrame[i], y = 110, w = 408, h = 114},
			}
		})
		table.insert(parts.destination,	{
			id = "scratchBg", dst = {
				{x = framePos.scratchBg[i], y = 110, w = 111, h = 114},
			}
		})
		table.insert(parts.destination,	{
			id = "scratchFrame", dst = {
				{x = framePos.scratchFrame[i], y = 110, w = 111, h = 114},
			}
		})
		table.insert(parts.destination,	{
			id = "scratchFrame2", loop = 1500, dst = {
				{time = 1000, x = framePos.scratchFrame2[i], y = 110, w = 111, h = 114, r = red, g = green, b = blue, a = 0},
				{time = 1500, a = 255}
			}
		})
		-- ロード完了後に光るように
		table.insert(parts.destination,	{
			id = "scratchFrame2", op = {MAIN.OP.LOADED, MAIN.OP.AUTOPLAYOFF},timer = scratchTimer[i], loop = -1, dst = {
				{time = 0, x = framePos.scratchFrame2[i], y = 110, w = 111, h = 114, r = red + 100, g = green + 100, b = blue + 100},
				{time = 50, a = 0}
			}
		})
		-- オート用
		table.insert(parts.destination,	{
			id = "scratchFrame2", op = {MAIN.OP.LOADED, MAIN.OP.AUTOPLAYON},timer = scratchTimer[i], dst = {
				{time = 0, x = framePos.scratchFrame2[i], y = 110, w = 111, h = 114, r = red + 100, g = green + 100, b = blue + 100},
				{time = 50, a = 0}
			}
		})
	end
end

local function keyFlash(parts, info)
	local flashLeftPosY = {info.whitePosY, info.blackPosY, info.whitePosY, info.blackPosY, info.whitePosY, info.blackPosY, info.whitePosY}
	local flashRightPosY = {info.whitePosY, info.blackPosY, info.whitePosY, info.blackPosY, info.whitePosY, info.blackPosY, info.whitePosY}
	local scratchflashPosX = {10, 508}
	table.insert(parts.image, {id = "keyflash_n", src = 16, x = 0, y = 0, w = info.keyflashNormalWidth, h = info.keyflashNormalHeight})
	table.insert(parts.image, {id = "scratchImage", src = 30, x = 0, y = 0, w = info.keyflashScratchWidth, h = info.keyflashScratchHeight})
	-- キーフラッシュ配置（鍵盤）
	for i = 1, info.flash.num, 1 do
		-- 左
		table.insert(parts.destination,	{
			id = "keyflash_n", timer = info.flash.leftTimer[i], blend = MAIN.BLEND.ADDITION, dst = {
				{x = BASE.laneLeftPosX + info.flash.leftPosX[i], y = flashLeftPosY[i], w = info.keyflashNormalWidth, h = info.keyflashNormalHeight},
			}
		})
		-- 右
		table.insert(parts.destination,	{
			id = "keyflash_n", timer = info.flash.rightTimer[i], blend = MAIN.BLEND.ADDITION, dst = {
				{x = BASE.laneRightPosX + info.flash.rightPosX[i], y = flashRightPosY[i], w = info.keyflashNormalWidth, h = info.keyflashNormalHeight},
			}
		})
	end
	-- 皿
	table.insert(parts.destination,	{
		id = "scratchImage", filter = MAIN.FILTER.ON, offset = MAIN.OFFSET.SCRATCHANGLE_1P, dst = {
			{x = BASE.laneLeftPosX + scratchflashPosX[1], y = 122, w = info.keyflashScratchWidth - 2, h = info.keyflashScratchHeight - 2},
		}
	})
	table.insert(parts.destination,	{
		id = "scratchImage", filter = MAIN.FILTER.ON, offset = MAIN.OFFSET.SCRATCHANGLE_2P, dst = {
			{x = BASE.laneRightPosX + scratchflashPosX[2], y = 122, w = -(info.keyflashScratchWidth - 2), h = info.keyflashScratchHeight - 2},
		}
	})
end

local function keyCover(parts)
	table.insert(parts.image, {id = "keyCoverTop", src = 15, x = 0, y = 228, w = 408, h = 57})
	table.insert(parts.image, {id = "keyCoverBottom", src = 15, x = 0, y = 285, w = 408, h = 57})
	table.insert(parts.destination, {
		id = "keyCoverTop", stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, loop = -1, dst = {
			{time = 0, x = BASE.laneLeftPosX + 112, y = 167, w = 408, h = 57, acc = MAIN.ACC.DECELERATE},
			{time = 1000},
			{time = 1300, y = 167 + 57, h = 0}
		}
	})
	table.insert(parts.destination, {
		id = "keyCoverTop", stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, loop = -1, dst = {
			{time = 0, x = BASE.laneRightPosX, y = 167, w = 408, h = 57, acc = MAIN.ACC.DECELERATE},
			{time = 1000},
			{time = 1300, y = 167 + 57, h = 0}
		}
	})
	table.insert(parts.destination, {
		id = "keyCoverBottom", stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, loop = -1, dst = {
			{time = 0, x = BASE.laneLeftPosX + 112, y = 110, w = 408, h = 57, acc = MAIN.ACC.DECELERATE},
			{time = 1000},
			{time = 1300, h = 0}
		}
	})
	table.insert(parts.destination, {
		id = "keyCoverBottom", stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, loop = -1, dst = {
			{time = 0, x = BASE.laneRightPosX, y = 110, w = 408, h = 57, acc = MAIN.ACC.DECELERATE},
			{time = 1000},
			{time = 1300, h = 0}
		}
	})
end

local function load(key)
	local info = init(key)
	local parts = {}
	parts.image = {}
	parts.destination = {}
	frame(parts)
	keyFlash(parts, info)
	keyCover(parts)
	return parts
end

return {
	load = load
}