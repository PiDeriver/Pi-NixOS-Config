--[[
    テキスト関連
    @author : KASAKO
]]

local function createMagnification()
    if PROPERTY.isTDGMagnificationLow() then
        return "+-225ms"
    elseif PROPERTY.isTDGMagnificationNormal() then
        return "+-150ms"
    elseif PROPERTY.isTDGMagnificationHigh() then
        return "+-75ms"
    end
end

local module = {}

local mainShadowOffset = 4
local subShadowOffset = 2
local bottomResult = main_state.text(MAIN.STRING.FULLTITLE) .." / " ..main_state.text(MAIN.STRING.ARTIST) .." / " ..main_state.text(MAIN.STRING.GENRE) .." / " ..main_state.text(MAIN.STRING.TABLE_FULL)
local bottomCourse = main_state.text(MAIN.STRING.FULLTITLE)
local playerName = "Player : " ..main_state.text(MAIN.STRING.PLAYER)
local courseRef = {150, 151, 152, 153, 154, 155, 156, 157, 158, 159}
local irRankerRef = {120, 121, 122, 123, 124, 125, 126, 127, 128, 129}
local dete = main_state.number(MAIN.NUM.TIME_YEAR) .." / " ..main_state.number(MAIN.NUM.TIME_MONTH) .." / " ..main_state.number(MAIN.NUM.TIME_DAY)

if PROPERTY.isOutlineFont() then
    -- 画像フォントなし
    module.font = {
        {id = 0, path = "Result/font/ttf/mgenplus-1c-black.ttf"},
        {id = 1, path = "Result/font/ttf/mgenplus-1c-medium.ttf"}
    }
    module.text = {
        {id = "bottomResult", font = 0, size = 30, constantText = bottomResult, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "bottomCourse", font = 0, size = 30, constantText = bottomCourse, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "playerName", font = 0, size = 30, constantText = playerName, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = 2, shadowOffsetY = 2},
        {id = "dete", font = 0, size = 30, constantText = dete, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = 2, shadowOffsetY = 2},
        {id = "magnification", font = 0, size = 18, constantText = createMagnification(), overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.LEFT},
        {id = "repositoryname", font = 0, size = 25, ref = MAIN.STRING.IR_NAME, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = subShadowOffset, shadowOffsetY = subShadowOffset},
        {id = "wd_song", font = 0, size = 18, constantText = "SONG", overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "wd_bga", font = 0, size = 18, constantText = "BGA", overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "wd_etc", font = 0, size = 18, constantText = "ETC", overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
    }
    -- コース名
    for i = 1, 10, 1 do
        table.insert(module.text, {id = "course" ..i, font = 1, size = 30, ref = courseRef[i], align = MAIN.T_ALIGN.CENTER, overflow = 1, shadowOffsetX = 1, shadowOffsetY = 1})
    end
    -- Top10のプレイヤー名
    for i = 1, 10, 1 do
        table.insert(module.text,{id = "irRankName"..i, font = 1, size = 30, ref = irRankerRef[i], align = 0, overflow = 1, shadowOffsetX = 1, shadowOffsetY = 1})
    end
elseif PROPERTY.isBitmapFont() then
    -- 画像フォントあり
    module.font = {
        {id = 0, path = "Result/font/fnt/main.fnt"},
        {id = 1, path = "Result/font/fnt/sub.fnt"}
    }
    module.text = {
        {id = "bottomResult", font = 0, size = 30, constantText = bottomResult, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "bottomCourse", font = 0, size = 30, constantText = bottomCourse, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "playerName", font = 0, size = 30, constantText = playerName, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "dete", font = 0, size = 30, constantText = dete, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "magnification", font = 0, size = 18, constantText = createMagnification(), overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.LEFT},
        {id = "repositoryname", font = 0, size = 25, ref = MAIN.STRING.IR_NAME, overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.RIGHT},
        {id = "wd_song", font = 0, size = 18, constantText = "SONG", overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "wd_bga", font = 0, size = 18, constantText = "BGA", overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
        {id = "wd_etc", font = 0, size = 18, constantText = "ETC", overflow = MAIN.T_OVERFLOW.SHRINK, align = MAIN.T_ALIGN.CENTER},
    }
    -- コース名
    for i = 1, 10, 1 do
        table.insert(module.text, {
            id = "course" ..i, font = 0, size = 30, ref = courseRef[i], overflow = 1, align = MAIN.T_ALIGN.CENTER
        })
    end
    -- Top10のプレイヤー名
    for i = 1, 10, 1 do
        table.insert(module.text,{id = "irRankName"..i, font = 1, size = 30, ref = irRankerRef[i], align = MAIN.T_ALIGN.LEFT, overflow = 1})
    end
end

return module