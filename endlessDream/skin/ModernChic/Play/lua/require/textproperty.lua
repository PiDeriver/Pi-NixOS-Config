--[[
    テキスト関連
    @author : KASAKO
]]
local module = {}

local mainShadowOffset = 4
local subShadowOffset = 2

local function createFullArtist()
    local fullArtist
    if main_state.text(MAIN.STRING.SUBARTIST) == "" then
        fullArtist = main_state.text(MAIN.STRING.ARTIST)
    else
        fullArtist = main_state.text(MAIN.STRING.ARTIST) .." " ..main_state.text(MAIN.STRING.SUBARTIST)
    end
    return fullArtist
end

if PROPERTY.isOutlineFont() then
    local mainNum = 0
    local subNum = 1

    module.font = {
        {id = 0, path = "Play/font/ttf/mgenplus-1c-black.ttf"},
        {id = 1, path = "Play/font/ttf/mgenplus-1c-medium.ttf"}
    }
    module.text = {
        {id = "rivalname", font = subNum, size = 25, ref = MAIN.STRING.RIVAL, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "genre", font = subNum, size = 25, ref = MAIN.STRING.GENRE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "title", font = subNum, size = 25, ref = MAIN.STRING.FULLTITLE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "artist", font = subNum, size = 25, ref = MAIN.STRING.ARTIST, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "difftbl", font = subNum, size = 25, ref = MAIN.STRING.TABLE_FULL, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "pretitle", font = mainNum, size = 90, ref = MAIN.STRING.FULLTITLE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = mainShadowOffset, shadowOffsetY = mainShadowOffset},
        {id = "pregenre", font = subNum, size = 40, ref = MAIN.STRING.GENRE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "preartist", font = subNum, size = 40, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, value = function() return createFullArtist() end},
        -- contstantText:任意の文字を扱える
        {id = "from", font = subNum, size = 18, constantText = "~", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "per", font = subNum, size = 18, constantText = "%", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "slash", font = subNum, size = 18, constantText = "/", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "laneCoverCount", font = subNum, size = 18, constantText = "LANECOVER", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "preview", font = subNum, size = 18, constantText = "Pattern Preview...", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
    }
elseif PROPERTY.isBitmapFont() then
    module.font = {
        {id = 0, path = "Play/font/fnt/title.fnt"},
        {id = 1, path = "Play/font/fnt/info.fnt"},
        {id = 2, path = "Play/font/fnt/top.fnt"}
    }
    module.text = {
        {id = "rivalname", font = 1, size = 25, ref = MAIN.STRING.RIVAL, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "genre", font = 2, size = 25, ref = MAIN.STRING.GENRE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "title", font = 2, size = 25, ref = MAIN.STRING.FULLTITLE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "artist", font = 2, size = 25, ref = MAIN.STRING.ARTIST, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "difftbl", font = 2, size = 25, ref = MAIN.STRING.TABLE_FULL, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "pretitle", font = 0, size = 90, ref = MAIN.STRING.FULLTITLE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "pregenre", font = 1, size = 40, ref = MAIN.STRING.GENRE, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "preartist", font = 1, size = 40, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, value = function() return createFullArtist() end},
        -- contstantText:任意の文字を扱える
        {id = "from", font = 1, size = 18, constantText = "~", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "per", font = 1, size = 18, constantText = "%", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "slash", font = 1, size = 18, constantText = "/", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "laneCoverCount", font = 1, size = 18, constantText = "LANECOVER", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
        {id = "preview", font = 1, size = 18, constantText = "Pattern Preview...", align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset, shadowColor = "00000000"},
    }
end

return module