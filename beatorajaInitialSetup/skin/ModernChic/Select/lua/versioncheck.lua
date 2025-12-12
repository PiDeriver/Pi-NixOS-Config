--[[
	新バージョンがあるかどうかをチェックする
	@author : KASAKO
]]
local function exsistNewVersion()
	local http = require("Select.lua.require.http")
	local version = require("Root.version")
	local isNewVer = false
	if PROPERTY.isCheckNewVersionOn() then isNewVer = http.skinVersionCheck(version) end
	return isNewVer == true
end

local function load()
	local parts = {}
	local isExsistNewVersion = exsistNewVersion()
	parts.image = {
		-- 新バージョン宣伝
		{id = "newVerionUpdate", src = 5, x = 1400, y = 2250, w = 267, h = 40, divy = 2, cycle = 100},
		{id = "newVerionNone", src = 5, x = 1400, y = 2290, w = 267, h = 20},
	}
	parts.destination = {}
	-- 新バージョン宣伝
	table.insert(parts.destination, {id = "newVerionNone", loop = 0, dst = {{time = 0, x = 180, y = 1050, w = 267, h = 20}}})
	table.insert(parts.destination, {id = "newVerionUpdate", loop = 0, timer = timer_util.timer_observe_boolean(function() return isExsistNewVersion end), dst = {{time = 0, x = 180, y = 1050, w = 267, h = 20}}})
	return parts
end

return {
	load = load
}