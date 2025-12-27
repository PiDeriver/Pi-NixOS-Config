--[[
    スキン基本情報
    @author : KASAKO
]]
local ver = require("Root.version")
local author = require("Root.author")
local property = {
    ver = ver,
    type = 5,
    name = "ModernChicSelect-" ..ver,
    w = 1920,
    h = 1080,
    fadeout = 500,
    scene = 3000,
    input = 500,
	property = PROPERTY.property,
	filepath = PROPERTY.filepath,
	offset = PROPERTY.offset,
	category = PROPERTY.category,
    author = author
}

return property