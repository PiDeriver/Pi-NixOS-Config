--[[
	キー画像と対応するキーフラッシュを配置
	@author : KASAKO
--]]

local function frame(parts)
	table.insert(parts.image, {id = "keyBg", src = 15, x = 0, y = 0, w = 408, h = 114})
	table.insert(parts.image, {id = "keyFrame", src = 15, x = 0, y = 114, w = 408, h = 114})
	table.insert(parts.image, {id = "scratchBg", src = 15, x = 408, y = 0, w = 111, h = 114})
	table.insert(parts.image, {id = "scratchFrame", src = 15, x = 408, y = 114, w = 111, h = 114})
	table.insert(parts.image, {id = "scratchFrame2", src = 15, x = 408, y = 228, w = 111, h = 114})
	local red = CUSTOM.NUM.randNum(50, 155)
	local green = CUSTOM.NUM.randNum(50, 155)
	local blue = CUSTOM.NUM.randNum(50, 155)
	-- キー部分
	table.insert(parts.destination,	{
		id = "keyBg", dst = {
			{x = BASE.playsidePositionX + BASE.KEYFLASH.keyFramePosX, y = 110, w = 408, h = 114},
		}
	})
	table.insert(parts.destination,	{
		id = "keyFrame", dst = {
			{x = BASE.playsidePositionX + BASE.KEYFLASH.keyFramePosX, y = 110, w = 408, h = 114},
		}
	})
	-- 皿部分
	table.insert(parts.destination,	{
		id = "scratchBg", dst = {
			{x = BASE.playsidePositionX + BASE.KEYFLASH.scratchFramePosX, y = 110, w = 111, h = 114},
		}
	})
	table.insert(parts.destination,	{
		id = "scratchFrame", dst = {
			{x = BASE.playsidePositionX + BASE.KEYFLASH.scratchFramePosX, y = 110, w = 111, h = 114},
		}
	})
	table.insert(parts.destination,	{
		id = "scratchFrame2", loop = 1500, dst = {
			{time = 1000, x = BASE.playsidePositionX + BASE.KEYFLASH.scratchFramePosX, y = 110, w = 111, h = 114, r = red, g = green, b = blue, a = 0},
			{time = 1500, a = 255}
		}
	})
	-- ロード完了後に光るように
	table.insert(parts.destination,	{
		id = "scratchFrame2", op = {MAIN.OP.LOADED, MAIN.OP.AUTOPLAYOFF}, timer = MAIN.TIMER.KEYON_1P_SCRATCH, loop = -1, dst = {
			{time = 0, x = BASE.playsidePositionX + BASE.KEYFLASH.scratchFramePosX, y = 110, w = 111, h = 114, r = red + 100, g = green + 100, b = blue + 100},
			{time = 50, a = 0}
		}
	})
	-- オート
	table.insert(parts.destination,	{
		id = "scratchFrame2", op = {MAIN.OP.LOADED, MAIN.OP.AUTOPLAYON}, timer = MAIN.TIMER.KEYON_1P_SCRATCH, dst = {
			{time = 0, x = BASE.playsidePositionX + BASE.KEYFLASH.scratchFramePosX, y = 110, w = 111, h = 114, r = red + 100, g = green + 100, b = blue + 100},
			{time = 50, a = 0}
		}
	})
end

local function keyFlash(parts, key)
	table.insert(parts.image, {id = "keyflash_n", src = 16, x = 0, y = 0, w = BASE.KEYFLASH.normalWidth, h = BASE.KEYFLASH.normalHeight})
	table.insert(parts.image, {id = "scratchImage", src = 30, x = 0, y = 0, w = BASE.KEYFLASH.scratchWidth, h = BASE.KEYFLASH.scratchHeight})
	-- キーフラッシュ配置（鍵盤）
	for i = 1, key, 1 do
		table.insert(parts.destination,	{
			id = "keyflash_n", timer = BASE.KEYFLASH.flashTimer[i], blend = MAIN.BLEND.ADDITION, dst = {
				{x = BASE.playsidePositionX + BASE.KEYFLASH.KEY_X[i], y = BASE.KEYFLASH.KEY_Y[i], w = BASE.KEYFLASH.normalWidth, h = BASE.KEYFLASH.normalHeight},
			}
		})
	end
	-- 皿
	table.insert(parts.destination,	{
		id = "scratchImage", filter = MAIN.FILTER.ON, offset = MAIN.OFFSET.SCRATCHANGLE_1P, dst = {
			{x = BASE.playsidePositionX + BASE.KEYFLASH.scratchImagePosX, y = 122, w = BASE.KEYFLASH.scratchWidth - 2, h = BASE.KEYFLASH.scratchHeight - 2},
		}
	})
end

local function keyCover(parts)
	table.insert(parts.image, {id = "keyCoverTop", src = 15, x = 0, y = 228, w = 408, h = 57})
	table.insert(parts.image, {id = "keyCoverBottom", src = 15, x = 0, y = 285, w = 408, h = 57})
	-- プレイ詳細時にはカバーを開かない
	if PROPERTY.isDetailInfoSwitchOff() then
		table.insert(parts.destination, {
			id = "keyCoverTop", loop = -1, stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, dst = {
				{time = 0, x = BASE.playsidePositionX + BASE.KEYFLASH.keyFramePosX, y = 167, w = 408, h = 57, acc = MAIN.ACC.DECELERATE},
				{time = 1000},
				{time = 1300, y = 167 + 57, h = 0}
			}
		})
		table.insert(parts.destination, {
			id = "keyCoverBottom", loop = -1, stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, dst = {
				{time = 0, x = BASE.playsidePositionX + BASE.KEYFLASH.keyFramePosX, y = 110, w = 408, h = 57, acc = MAIN.ACC.DECELERATE},
				{time = 1000},
				{time = 1300, h = 0}
			}
		})
	elseif PROPERTY.isDetailInfoSwitchOn() then
		table.insert(parts.destination, {id = "keyCoverTop", stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, dst = {{x = BASE.playsidePositionX + BASE.KEYFLASH.keyFramePosX, y = 167, w = 408, h = 57}}})
		table.insert(parts.destination, {id = "keyCoverBottom", stretch = MAIN.STRETCH.FIT_WIDTH_TRIMMED, dst = {{0, x = BASE.playsidePositionX + BASE.KEYFLASH.keyFramePosX, y = 110, w = 408, h = 57}}})
	end
end

local function load(key)
	local parts = {}
	parts.image = {}
	parts.destination = {}
	frame(parts)
	keyFlash(parts, key)
	keyCover(parts)
	return parts
end

return {
	load = load
}