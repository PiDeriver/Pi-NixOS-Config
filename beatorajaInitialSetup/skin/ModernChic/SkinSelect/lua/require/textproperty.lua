--[[
    テキスト関連
    @author : KASAKO
]]
local module = {}

local function skinName(parts)
    table.insert(parts.text, {id = "t_skinName", font = "medium", size = 35, ref = MAIN.STRING.SKIN_NAME, overflow = MAIN.T_OVERFLOW.SHRINK,  align = MAIN.T_ALIGN.CENTER})
end

local function skinAuthor(parts)
    table.insert(parts.text, {id = "t_skinAuthor", font = "medium", size = 22, ref = MAIN.STRING.SKIN_AUTHOR, overflow = MAIN.T_OVERFLOW.SHRINK,  align = MAIN.T_ALIGN.CENTER})
end

local function items(parts)
    local c_ref = {MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY1, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY2, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY3, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY4, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY5, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY6, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY7, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY8, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY9, MAIN.STRING.SKIN_CUSTOMIZE_CATEGORY10}
    local i_ref = {MAIN.STRING.SKIN_CUSTOMIZE_ITEM1, MAIN.STRING.SKIN_CUSTOMIZE_ITEM2, MAIN.STRING.SKIN_CUSTOMIZE_ITEM3, MAIN.STRING.SKIN_CUSTOMIZE_ITEM4, MAIN.STRING.SKIN_CUSTOMIZE_ITEM5, MAIN.STRING.SKIN_CUSTOMIZE_ITEM6, MAIN.STRING.SKIN_CUSTOMIZE_ITEM7, MAIN.STRING.SKIN_CUSTOMIZE_ITEM8, MAIN.STRING.SKIN_CUSTOMIZE_ITEM9, MAIN.STRING.SKIN_CUSTOMIZE_ITEM10}
    for i = 1, 10, 1 do
        table.insert(parts.text, {id = "t_category" ..i, font = "medium", size = 25, ref = c_ref[i], overflow = MAIN.T_OVERFLOW.SHRINK,  align = MAIN.T_ALIGN.CENTER})
        table.insert(parts.text, {id = "t_item" ..i, font = "medium", size = 25, ref = i_ref[i], overflow = MAIN.T_OVERFLOW.SHRINK,  align = MAIN.T_ALIGN.CENTER})
    end
end

-- アウトラインフォント
module.font =  {
    {id = "medium", path = "SkinSelect/font/ttf/mgenplus-1c-medium.ttf"},
    {id = "black", path = "SkinSelect/font/ttf/mgenplus-1c-black.ttf"},
}
module.text = {}

skinName(module)
skinAuthor(module)
items(module)

return module