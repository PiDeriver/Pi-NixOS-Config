--[[
    関数集
    @author : KEH
]]
local m = {}

m.unpack = function(table, key)
    local exists = false
    if table[key] then
        for k, v in pairs(table[key]) do
            table[k] = v
        end
        table[key] = nil
        exists = true
    end
    return exists
end

m.merge = function(skinparts, id, imagedef)
    local exists = false
    for _, t in ipairs(skinparts) do
        if t.id == id then
            for k, v in pairs(imagedef) do
                t[k] = v
            end
            exists = true
            break
        end
    end
    return exists
end

--[[
    インクリメントアニメーション用
]]
m.number_increase = function(s_num, e_num, s_time, e_time, time)
    if time < s_time then
        return s_num
    end
    if e_time < time then
        return e_num
    end
    return s_num + (e_num - s_num) * (time - s_time) / (e_time - s_time)
end


return m