--[[
    テキスト関連
    @author : KASAKO
]]

local function createFullArtist()
    local fullArtist
    if main_state.text(MAIN.STRING.SUBARTIST) == "" then
        fullArtist = main_state.text(MAIN.STRING.ARTIST)
    else
        fullArtist = main_state.text(MAIN.STRING.ARTIST) .." " ..main_state.text(MAIN.STRING.SUBARTIST)
    end
    return fullArtist
end

local function load(version)
    local module = {}
    local version = "Ver " ..version
    local courseRef = {150, 151, 152, 153, 154, 155, 156, 157, 158, 159}
    local irRankNameRef = {120, 121, 122, 123, 124, 125, 126, 127, 128, 129}
    local rivalForwardRef = {MAIN.STRING.TARGET_FORWARD1, MAIN.STRING.TARGET_FORWARD2, MAIN.STRING.TARGET_FORWARD3, MAIN.STRING.TARGET_FORWARD4, MAIN.STRING.TARGET_FORWARD5, MAIN.STRING.TARGET_FORWARD6, MAIN.STRING.TARGET_FORWARD7, MAIN.STRING.TARGET_FORWARD8, MAIN.STRING.TARGET_FORWARD9, MAIN.STRING.TARGET_FORWARD10}
    local rivalBackwardRef = {MAIN.STRING.TARGET_BACKWARD1, MAIN.STRING.TARGET_BACKWARD2, MAIN.STRING.TARGET_BACKWARD3, MAIN.STRING.TARGET_BACKWARD4, MAIN.STRING.TARGET_BACKWARD5, MAIN.STRING.TARGET_BACKWARD6, MAIN.STRING.TARGET_BACKWARD7, MAIN.STRING.TARGET_BACKWARD8, MAIN.STRING.TARGET_BACKWARD9, MAIN.STRING.TARGET_BACKWARD10}

    if PROPERTY.isOutlineFont() then
        -- 画像フォント未使用
        local main = {shadowOffsetX = 4, shadowOffsetY = 4}
        local sub = {shadowOffsetX = 2, shadowOffsetY = 2}
        module.font = {
            {id = 0, path = "Select/font/ttf/mgenplus-1c-black.ttf"},
            {id = 1, path = "Select/font/ttf/mgenplus-1c-medium.ttf"},
        }
        module.text = {
            {id = "title", font = 0, size = 70, ref = MAIN.STRING.TITLE, overflow = 1, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = main.shadowOffsetX, shadowOffsetY = main.shadowOffsetY},
            {id = "subtitle", font = 0, size = 170, ref = MAIN.STRING.SUBTITLE, overflow = 1},
            {id = "artist", font = 1, size = 30, ref = MAIN.STRING.ARTIST, overflow = 1, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "subartist", font = 1, size = 30, ref = MAIN.STRING.SUBARTIST, overflow = 1, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "fullArtist", font = 1, size = 30, overflow = 1, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY, value = function() return createFullArtist() end},
            {id = "genre", font = 1, size = 30, ref = MAIN.STRING.GENRE, overflow = 1, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "bartext", font = 1, size = 35, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "search", font = 1, size = 30, ref = MAIN.STRING.SEARCHWORD},
            {id = "yourname", font = 1, size = 35, ref = MAIN.STRING.PLAYER, overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "rivalname", font = 1, size = 35, ref = MAIN.STRING.RIVAL, overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "directory", font = 1, size = 25, ref = MAIN.STRING.DIRECTORY, overflow = 1, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "version", font = 0, size = 16, constantText = version, overflow = 1},
            {id = "repositoryname", font = 1, size = 20, ref = MAIN.STRING.IR_NAME, overflow = 1, align = MAIN.T_ALIGN.RIGHT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
            {id = "sepa", font = 0, size = 15, constantText = "/", overflow = 1},
        }
        -- コース名
        for i = 1, 10, 1 do
            table.insert(module.text, {
                id = "course" ..i, font = 1, size = 30, ref = courseRef[i], overflow = 1, align = MAIN.T_ALIGN.CENTER, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY,
            })
        end
        -- IRTOP10
        for i = 1, 10, 1 do
            table.insert(module.text, {
                id = "irRankName"..i, font = 1, size = 16, ref = irRankNameRef[i], align = MAIN.T_ALIGN.LEFT, overflow = 1
            })
        end
        -- IRTOP10（サイドメニュー用）
        for i = 1, 10, 1 do
            table.insert(module.text, {
                id = "s_irRankName"..i, font = 1, size = 25, ref = irRankNameRef[i], align = MAIN.T_ALIGN.LEFT, overflow = 1, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY
            })
        end
        -- ライバル枠
        table.insert(module.text, {id = "s_rival", font = 1, size = 20, ref = MAIN.STRING.SELECTED_TARGET, align = MAIN.T_ALIGN.LEFT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY})
        for i = 1, 10, 1 do
            table.insert(module.text, {id = "f_rival" ..i, font = 1, size = 20, ref = rivalForwardRef[i], align = MAIN.T_ALIGN.LEFT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY})
            table.insert(module.text, {id = "b_rival" ..i, font = 1, size = 20, ref = rivalBackwardRef[i], align = MAIN.T_ALIGN.LEFT, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY})
        end
    elseif  PROPERTY.isBitmapFont() then
        -- 画像フォント使用
        local main = {outlineColor = "111111ff", outlineWidth = 0.8}
        local sub = {outlineColor = "222222ff", outlineWidth = 1}

        module.font = {
            {id = 0, path = "Select/font/fnt/bartext.fnt"},
            {id = 1, path = "Select/font/fnt/main.fnt", type = 1},
            {id = 2, path = "Select/font/fnt/sub.fnt", type = 1}
        }
        module.text = {
            {id = "title", font = 1, size = 70, ref = MAIN.STRING.TITLE, overflow = 1, outlineColor = main.outlineColor, outlineWidth = main.outlineWidth, align = MAIN.T_ALIGN.RIGHT},
            {id = "subtitle", font = 1, size = 170, ref = MAIN.STRING.SUBTITLE, overflow = 1},
            {id = "artist", font = 2, size = 30, ref = MAIN.STRING.ARTIST, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = MAIN.T_ALIGN.RIGHT},
            {id = "subartist", font = 2, size = 30, ref = MAIN.STRING.SUBARTIST, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = MAIN.T_ALIGN.RIGHT},
            {id = "fullArtist", font = 2, size = 30, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = MAIN.T_ALIGN.RIGHT, value = function() return createFullArtist() end},
            {id = "genre", font = 2, size = 30, ref = MAIN.STRING.GENRE, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = MAIN.T_ALIGN.RIGHT},
            {id = "bartext", font = 0, size = 35},
            {id = "search", font = 2, size = 30, ref = MAIN.STRING.SEARCHWORD},
            {id = "yourname", font = 2, size = 35, ref = MAIN.STRING.PLAYER, overflow = 1, align = MAIN.T_ALIGN.CENTER, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth},
            {id = "rivalname", font = 2, size = 35, ref = MAIN.STRING.RIVAL, overflow = 1, align = MAIN.T_ALIGN.CENTER, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth},
            {id = "directory", font = 2, size = 25, ref = MAIN.STRING.DIRECTORY, overflow = 1, align = MAIN.T_ALIGN.RIGHT, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth},
            {id = "version", font = 1, size = 16, constantText = version, overflow = 1, outlineColor = main.outlineColor, outlineWidth = main.outlineWidth},
            {id = "repositoryname", font = 2, size = 20, ref = MAIN.STRING.IR_NAME, overflow = 1, align = MAIN.T_ALIGN.RIGHT, outlineColor = main.outlineColor, outlineWidth = main.outlineWidth},
            {id = "sepa", font = 1, size = 15, constantText = "/", overflow = 1, outlineColor = main.outlineColor, outlineWidth = main.outlineWidth},
        }
        -- コース名
        for i = 1, 10, 1 do
            table.insert(module.text, {
                id = "course" ..i, font = 0, size = 30, ref = courseRef[i], overflow = 1, align = MAIN.T_ALIGN.CENTER
            })
        end
        -- IRTOP10
        for i = 1, 10, 1 do
            table.insert(
                module.text,{id = "irRankName"..i, font = 2, size = 16, ref = irRankNameRef[i], align = MAIN.T_ALIGN.LEFT, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth
            })
        end
        -- IRTOP10（サイドメニュー用）
        for i = 1, 10, 1 do
            table.insert(module.text,{
                id = "s_irRankName"..i, font = 2, size = 25, ref = irRankNameRef[i], align = MAIN.T_ALIGN.LEFT, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, overflow = 1
            })
        end
        -- ライバル枠
        table.insert(module.text, {id = "s_rival", font = 1, size = 20, ref = MAIN.STRING.SELECTED_TARGET, align = MAIN.T_ALIGN.LEFT, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth})
        for i = 1, 10, 1 do
            table.insert(module.text, {id = "f_rival" ..i, font = 1, size = 20, ref = rivalForwardRef[i], align = MAIN.T_ALIGN.LEFT, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth})
            table.insert(module.text, {id = "b_rival" ..i, font = 1, size = 20, ref = rivalBackwardRef[i], align = MAIN.T_ALIGN.LEFT, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth})
        end
    end
    return module
end

return {
    load = load
}