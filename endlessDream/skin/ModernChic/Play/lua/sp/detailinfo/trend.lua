--[[
    データの履歴を収集する
    @author : KEH
]]
local trendfactory ={}
trendfactory.create = function(length)
    local index = 1
    local l = length
    local datas = {}
    local max, avg = 0, 0
    local flg = false
    for _ = 1, l do
        table.insert(datas, 0)
    end
    return {
        insert = function(data)
            datas[index] = data
            if max < data then
                max = data
                flg = true
            else
                flg = false
            end
            index = index + 1
            if index == length + 1 then
                index = 1
            end
            avg = avg + (data - datas[index]) / l
        end,
        getdatas = function()
            return index, datas
        end,
        getnowdata = function()
            return datas[index]
        end,
        getdata = function(i)
            local ii = index + i - 1
            if ii > length then
                ii = ii - length
            end
            return datas[ii]
        end,
        getmax = function()
            return max
        end,
        getavg = function()
            return avg
        end,
        getmaxupdateflg = function()
            return flg
        end
    }
end

return trendfactory