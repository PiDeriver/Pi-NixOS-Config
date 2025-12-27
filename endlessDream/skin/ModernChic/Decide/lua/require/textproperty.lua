--[[
    テキスト関連
    @author : KASAKO
]]
local module = {}

local function diffOutlineColor()
	if main_state.option(MAIN.OP.DIFFICULTY1) then
		return "165423ff"
	elseif main_state.option(MAIN.OP.DIFFICULTY2) then
		return "105e60ff"
	elseif main_state.option(MAIN.OP.DIFFICULTY3) then
		return "644f0fff"
	elseif main_state.option(MAIN.OP.DIFFICULTY4) then
		return "521313ff"
	elseif main_state.option(MAIN.OP.DIFFICULTY5) then
		return "401340ff"
	elseif main_state.option(MAIN.OP.DIFFICULTY0) then
		return "444444ff"
	end
end

local function createFullArtist()
    local fullArtist
    if main_state.text(MAIN.STRING.SUBARTIST) == "" then
        fullArtist = main_state.text(MAIN.STRING.ARTIST)
    else
        fullArtist = main_state.text(MAIN.STRING.ARTIST) .." " ..main_state.text(MAIN.STRING.SUBARTIST)
    end
    return fullArtist
end

local mainShadowOffset = 4
local subShadowOffset = 2
local color = diffOutlineColor()

if PROPERTY.isOutlineFont() then
    -- アウトラインフォント
    module.font =  {
        {id = 1, path = "Decide/font/ttf/mgenplus-1c-medium.ttf"},
        {id = 0, path = "Decide/font/ttf/mgenplus-1c-black.ttf"},
    }
    module.text = {
        {id = "tablename&tablelevel", font = 0, size = 35, ref = MAIN.STRING.TABLE_FULL, overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "genre", font = 1, size = 40, ref = MAIN.STRING.GENRE, overflow = 1,  align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "title", font = 0, size = 90, ref = MAIN.STRING.FULLTITLE, overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = mainShadowOffset, shadowOffsetY = mainShadowOffset},
        {id = "artist", font = 1, size = 40, overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, value = function()
            return createFullArtist()
        end},
        {id = "stage", font = 1, size = 50, overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, value = function()
            return "STAGE" ..CUSTOM.NUM.todaySongUpdateCount + 1
        end},
        {id = "tips", font = 1, size = 25, overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, constantText = CUSTOM.TEXT.choiceTips()},
    }
elseif PROPERTY.isBitmapFont() then
    -- ビットマップフォント（ちと重い）
    module.font =  {
        {id = 0, path = "Decide/font/fnt/main.fnt", type = 1},
        {id = 1, path = "Decide/font/fnt/sub.fnt", type = 1},
    }
    module.text = {
        {id = "tablename&tablelevel", font = 0, size = 35, ref = MAIN.STRING.TABLE_FULL, overflow = 1, outlineColor = color, outlineWidth = 1, align = MAIN.T_ALIGN.CENTER},
        {id = "genre", font = 1, size = 40, ref = MAIN.STRING.GENRE, overflow = 1, outlineColor = color, outlineWidth = 1, align = MAIN.T_ALIGN.CENTER},
        {id = "title", font = 0, size = 90, ref = MAIN.STRING.FULLTITLE, overflow = 1, outlineColor = color, outlineWidth = 1, align = MAIN.T_ALIGN.CENTER},
        {id = "artist", font = 1, size = 40, overflow = 1, outlineColor = color, outlineWidth = 1, align = MAIN.T_ALIGN.CENTER, value = function()
            return createFullArtist()
        end},
        {id = "stage", font = 1, size = 50, overflow = 1, outlineColor = color, outlineWidth = 1, align = MAIN.T_ALIGN.CENTER, value = function()
            return "STAGE" ..CUSTOM.NUM.todaySongUpdateCount + 1
        end},
        {id = "tips", font = 1, size = 25, overflow = 1, outlineColor = color, align = MAIN.T_ALIGN.CENTER, constantText = CUSTOM.TEXT.choiceTips()},
    }
end

return module