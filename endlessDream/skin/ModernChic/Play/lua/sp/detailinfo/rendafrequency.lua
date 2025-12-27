local m = {}
local data = {}
local r_min = 1
local r_max = 2
local fine = 1
local max = 1
m.init = function(_fine, _min, _max)
    r_min = _min
    r_max = _max
    fine = _fine
    local size = (_max - _min) * _fine + 1
    for _ = 1, size do
        table.insert(data, 0)
    end
end

m.insert = function(frequency)
    local index
    if frequency < 1000000 / (r_max - 0.5 / fine) then
        index = #data
    elseif frequency >= 1000000 / (r_min + 0.5 / fine) then
        index = 1
    else
        index = math.floor(( ((1000000/frequency) - r_min) + 1.5 / fine ) * fine) - 1
    end
    data[index] = data[index] + 1
    if data[index] > max then
        max = data[index]
    end
end

m.getdata = function()
    return data
end

m.getmax = function()
    return max
end

return m