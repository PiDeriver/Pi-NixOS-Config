--[[
    基準点の作成
    @author : KASAKO
]]
local m = {}

m.createBasePosition = function()
    local base = {}
    base.MAIN_POS_X = 0
    base.SUB_POS_X = 0
    base.SCROLLBAR_POS_X = 0
    base.CENTER_POS_X = 700
    if PROPERTY.isMainmenuLeft() then
        base.MAIN_POS_X = 35
        base.SUB_POS_X = 1220
        base.SCROLLBAR_POS_X = 1885
    elseif PROPERTY.isMainmenuRight() then
        base.MAIN_POS_X = 1220
        base.SUB_POS_X = 35
        base.SCROLLBAR_POS_X = 7
    end
    return base
end

m.addSource = function(skin)
    table.insert(skin.source, {id = 0, path = "Result/parts/ring.png"})
    table.insert(skin.source, {id = 1, path = "Result/parts/irmask/*.png"})
    table.insert(skin.source, {id = 2, path = "Result/parts/system.png"})
    table.insert(skin.source, {id = 3, path = "Result/parts/prepare.png"})
    table.insert(skin.source, {id = 4, path = "Result/parts/number.png"})
    table.insert(skin.source, {id = 5, path = "Result/parts/lamp.png"})
    table.insert(skin.source, {id = 6, path = "Result/parts/parts.png"})
    table.insert(skin.source, {id = 7, path = "Result/parts/rank/*.png"})
    table.insert(skin.source, {id = 8, path = "Result/parts/gauge/*.png"})
end

return m