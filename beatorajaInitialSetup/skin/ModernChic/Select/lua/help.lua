--[[
	ヘルプ画面
	@author : KASAKO
]]

local function load()
	local parts = {}
	local isMenuOpen = false

	-- help開閉切り替え
	local function menuSwitch()
		isMenuOpen = not isMenuOpen
		CUSTOM.SOUND.helpMotionSound(isMenuOpen)
	end
	
	parts.image = {}
	table.insert(parts.image, {id = "helpBtn", src = 5, x = 1570, y = 2230, w = 168, h = 20, act = function() return menuSwitch() end})
	table.insert(parts.image, {id = "helpScene", src = 10, x = 0, y = 0, w = 1920, h = 1080, act = function() return menuSwitch() end})
	
	parts.destination = {}
	table.insert(parts.destination, {id = "helpBtn", dst = {{x = 10, y = 1050, w = 168, h = 20}}})

	table.insert(parts.destination, {
		id = "helpScene", loop = 200, timer = timer_util.timer_observe_boolean(function() return isMenuOpen end), dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},
			{time = 200, a = 255}
		}
	})
	table.insert(parts.destination, {
		id = "helpScene", loop = -1, timer = timer_util.timer_observe_boolean(function() return not isMenuOpen end), dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 1080},
			{time = 200, a = 0}
		}
	})

	return parts
end

return {
	load = load
}