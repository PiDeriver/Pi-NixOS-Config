--[[
    インジケーター生成モジュール
    @author : KEH
]]

local function counterFactory()
    return {
        make = function()
            local count = 0
            return {
                increment = function()
                    count = count + 1
                end,
                get = function()
                    return count
                end
            }
        end
    }
end
local function adderFactory()
    return {
        make = function()
            local sum = 0
            return {
                add = function(x)
                    sum = sum + x
                end,
                get = function()
                    return sum
                end
            }
        end
    }
end
local function expdecayerFactory()
    return {
        make = function()
            local vel = 0
            local prevtime = 0
            return {
                increment = function()
                    vel = vel + 1
                end,
                decay = function(time)
                    local dt = (time - prevtime) / 1000000
                    vel = (1 - dt) * vel
                    prevtime = time
                end,
                get = function()
                    return vel
                end
            }
        end
    }
end
local function looseDecayerFactory()
    return {
        make = function()
            local vel = 0
            local dvel = 0
            local prevtime = 0
            return {
                increment = function()
                    dvel = dvel + 1
                    if vel < dvel then
                        vel = dvel
                    end
                end,
                decay = function(time)
                    local dt = (time - prevtime) / 1000000
                    prevtime = time
                    vel = (1-dt)*vel + dt*dvel
                    dvel = (1-dt)*dvel
                end,
                get = function()
                    return vel
                end
            }
        end
    }
end
local function delayedDecayerFactory()
    return {
        make = function(size)
            local vel = 0
            local prevtime = 0
            local delta_n = {}
            for _ = 1 ,size do
                table.insert(delta_n, 0)
            end
            local flag = false
            local dn_index = 1
            local start_index = 1
            return {
                increment = function()
                    if flag then
                        if dn_index ~= start_index then
                            local dn = 1 / (dn_index - start_index)
                            for i = start_index, dn_index - 1 do
                                delta_n[(i - 1) % size + 1] = delta_n[(i - 1) % size + 1] + dn
                            end
                        else
                            delta_n[(start_index - 1) % size + 1] = delta_n[(start_index - 1) % size + 1] + 1
                        end
                    else
                        flag = true
                    end
                    start_index = dn_index
                end,
                decay = function(time)
                    local dt = (time - prevtime) / 1000000
                    vel = (1 - dt) * vel + delta_n[dn_index % size + 1] -- 一番古いdelta_nを足す
                    delta_n[dn_index % size + 1] = 0 -- 一番古いdelta_nを0にする
                    prevtime = time

                    if flag and dn_index - start_index > #delta_n then
                        for i = 1, #delta_n do
                            delta_n[i] = 1 / #delta_n
                        end
                        flag = false
                    end
                    dn_index = dn_index + 1
                end,
                get = function()
                    return vel
                end,
                getdn = function() return delta_n end
            }
        end
    }
end

local function make_summabletable(indicatorFactory, count, size)
    local t = {
        sum = function(self, ist, ied)
            local sum = 0
            for i = ist or 1, ied or #self do
                sum = sum + self[i].get()
            end
            return sum
        end
    }
    for _ = 1, count do
        table.insert(t, indicatorFactory.make(size))
    end
    return t
end

local function load(keycount, delaysize)
    local module = {}
    local keys = keycount or 8
    local size = delaysize or 256
    module.counter = make_summabletable(counterFactory(), keys)
    module.adder = make_summabletable(adderFactory(), keys)
    module.decayer = make_summabletable(expdecayerFactory(), keys)
    module.looseDecayer = make_summabletable(looseDecayerFactory(), keys)
    module.delayedDecayer = make_summabletable(delayedDecayerFactory(), keys, size)

    module.decay = function(self, index, time)
        self.decayer[index].decay(time)
        self.looseDecayer[index].decay(time)
        self.delayedDecayer[index].decay(time)
    end
    module.increment = function(self, index)
        self.counter[index].increment()
        self.decayer[index].increment()
        self.looseDecayer[index].increment()
        self.delayedDecayer[index].increment()
    end
    return module
end

return {
    load = load
}