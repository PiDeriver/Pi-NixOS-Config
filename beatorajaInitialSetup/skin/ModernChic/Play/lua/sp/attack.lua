--[[
    攻撃モーション用
    @author : KASAKO
]]

local function createCascadeTimersPGreat(timer, max_count)
    local current_value = main_state.timer_off_value
    local current_index = 0
    local timers = {}
    for i = 0, max_count - 1 do
        local self_value = main_state.timer_off_value
        table.insert(timers, function()
            local value = main_state.timer(timer)
            if value ~= current_value and current_index == i and main_state.option(MAIN.OP.PERFECT_1P) then
                current_index = (current_index + 1) % max_count
                current_value = value
                self_value = value
            end
            return self_value
        end)
    end
    return timers
end

local function createCascadeTimersGreat(timer, max_count)
    local current_value = main_state.timer_off_value
    local current_index = 0
    local timers = {}
    for i = 0, max_count - 1 do
        local self_value = main_state.timer_off_value
        table.insert(timers, function()
            local value = main_state.timer(timer)
            if value ~= current_value and current_index == i and (main_state.option(MAIN.OP.EARLY_1P) or main_state.option(MAIN.OP.LATE_1P)) then
                current_index = (current_index + 1) % max_count
                current_value = value
                self_value = value
            end
            return self_value
        end)
    end
    return timers
end

local function randPos(min, max)
    return math.random(min, max)
end

local function load()
    local parts = {}
    local bombCycle = 1000
    parts.image = {
        {id = "hpFrame", src = "parts_back", x = 0, y = 720, w = 720, h = 40}
    }
    parts.value = {
        -- 最大HP(総ノート数*2)
        {id = "numMaxHP", src = 1, x = 1400, y = 81, w = 297, h = 20, divx = 11, divy = 1, digit = 5, value = function()
            return CUSTOM.NUM.maxExscore()
        end},
        -- 現在のHP（最大HP-現在のEXSCORE）
        {id = "numNowHP", src = 1, x = 1400, y = 81, w = 297, h = 20, divx = 11, divy = 1, digit = 5, value = function()
            if main_state.number(MAIN.NUM.SCORE2) == -2147483648 then
                return CUSTOM.NUM.maxExscore()
            else
                return CUSTOM.NUM.maxExscore() - main_state.number(MAIN.NUM.SCORE2)
            end
        end},
    }
    parts.graph = {
        -- 体力ゲージ
        {id = "gra_hp", src = "parts_back", x = 0, y = 760, w = 716, h = 12, angle = MAIN.G_ANGLE.RIGHT, value = function()
            local max = CUSTOM.NUM.maxExscore()
            local now = CUSTOM.NUM.maxExscore() - main_state.number(MAIN.NUM.SCORE2)
            local rate = now / max
            if rate >= 1 then
                return 1
            else
                return rate
            end
        end}
    }
    parts.destination = {}

    -- 攻撃モーション用背景
    do
        local imagePosX = 0
        for i = 1, 5, 1 do
            table.insert(parts.image, {id = "attackBg-" ..i, src = "parts_back", x = imagePosX, y = 0, w = 720, h = 720})
            imagePosX = imagePosX + 720
        end
        table.insert(parts.destination, {
            id = "attackBg-1", blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PLAY, dst = {
                {time = 0, x = BASE.infoPositionX + 310, y = 300, w = 720, h = 720, a = 50},
                {time = 25000, angle = -360}
            }
        })
        table.insert(parts.destination, {
            id = "attackBg-2", blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PLAY, dst = {
                {time = 0, x = BASE.infoPositionX + 310, y = 300, w = 720, h = 720, a = 50},
                {time = 20000, angle = 360}
            }
        })
        table.insert(parts.destination, {
            id = "attackBg-3", blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PLAY, dst = {
                {time = 0, x = BASE.infoPositionX + 310, y = 300, w = 720, h = 720, a = 50, acc = MAIN.ACC.DECELERATE, angle = -45},
                {time = 5000, angle = 45},
                {time = 15000, angle = -45},
            }
        })
        table.insert(parts.destination, {
            id = "attackBg-4", blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PLAY, dst = {
                {time = 0, x = BASE.infoPositionX + 310, y = 300, w = 720, h = 720, a = 50},
                {time = 10000, angle = 360}
            }
        })
        table.insert(parts.destination, {
            id = "attackBg-5", blend = MAIN.BLEND.ADDITION, timer = MAIN.TIMER.PLAY, dst = {
                {time = 0, x = BASE.infoPositionX + 310, y = 300, w = 720, h = 720, a = 50},
                {time = 25000, angle = -360}
            }
        })
    end

    -- HP部分
    do
        local framePosX = 315
        local framePosY = 970
        table.insert(parts.destination, {
            id = "hpFrame", timer = MAIN.TIMER.PLAY, dst = {
                {x = BASE.infoPositionX + framePosX, y = framePosY, w = 720, h = 40},
            }
        })
        -- 数値
        table.insert(parts.destination, {
            id = "numMaxHP", timer = MAIN.TIMER.PLAY, dst = {
                {x = BASE.infoPositionX + framePosX + 235, y = framePosY + 18, w = 27, h = 20},
            }
        })
        table.insert(parts.destination, {
            id = "numNowHP", timer = MAIN.TIMER.PLAY, dst = {
                {x = BASE.infoPositionX + framePosX + 68, y = framePosY + 18, w = 27, h = 20},
            }
        })
        -- ゲージ部分（緑）
        table.insert(parts.destination, {
            id = "gra_hp", timer = MAIN.TIMER.PLAY, draw = function()
                local maxHP = CUSTOM.NUM.maxExscore()
                local nowHP
                if main_state.number(MAIN.NUM.SCORE2) == -2147483648 then
                    nowHP = CUSTOM.NUM.maxExscore()
                else
                    nowHP = CUSTOM.NUM.maxExscore() - main_state.number(MAIN.NUM.SCORE2)
                end
                local rate = nowHP / maxHP
                return rate > 0.6
            end, dst = {
                {x = BASE.infoPositionX + framePosX + 2, y = framePosY + 2, w = 716, h = 12, r = 100, g = 142, b = 0},
            }
        })
        -- ゲージ部分（黄）
        table.insert(parts.destination, {
            id = "gra_hp", timer = MAIN.TIMER.PLAY, draw = function()
                local maxHP = CUSTOM.NUM.maxExscore()
                local nowHP
                if main_state.number(MAIN.NUM.SCORE2) == -2147483648 then
                    nowHP = CUSTOM.NUM.maxExscore()
                else
                    nowHP = CUSTOM.NUM.maxExscore() - main_state.number(MAIN.NUM.SCORE2)
                end
                local rate = nowHP / maxHP
                return (rate <= 0.6) and (rate > 0.3)
            end, dst = {
                {x = BASE.infoPositionX + framePosX + 2, y = framePosY + 2, w = 716, h = 12, r = 189, g = 173, b = 0},
            }
        })
        -- ゲージ部分（赤）
        table.insert(parts.destination, {
            id = "gra_hp", timer = MAIN.TIMER.PLAY, draw = function()
                local maxHP = CUSTOM.NUM.maxExscore()
                local nowHP
                if main_state.number(MAIN.NUM.SCORE2) == -2147483648 then
                    nowHP = CUSTOM.NUM.maxExscore()
                else
                    nowHP = CUSTOM.NUM.maxExscore() - main_state.number(MAIN.NUM.SCORE2)
                end
                local rate = nowHP / maxHP
                return rate <= 0.3
            end, dst = {
                {x = BASE.infoPositionX + framePosX + 2, y = framePosY + 2, w = 716, h = 12, r = 189, g = 13, b = 0},
            }
        })
    end

    -- 攻撃モーション
    for i = 1, 8, 1 do
        local pgTimers = createCascadeTimersPGreat(49 + i, 10)
        local gTimers = createCascadeTimersGreat(49 + i, 10)
        for j = 1, 10, 1 do
            local id_PG = "pAttack_" ..i .."_" ..j
            local id_G = "gAttack_" ..i .."_" ..j
            -- イメージ
            table.insert(parts.image, {
                id = id_PG, src = "parts_attack", x = 0, y = 0, w = 1000, h = 1200, divx = 5, divy = 6, cycle = bombCycle, timer = pgTimers[j]
            })
            table.insert(parts.image, {
                id = id_G, src = "parts_attack", x = 1000, y = 0, w = 1000, h = 1200, divx = 5, divy = 6, cycle = bombCycle, timer = gTimers[j]
            })
            -- 配置（左）
            table.insert(parts.destination, {
                id = id_PG, timer = pgTimers[j], loop = -1, blend = MAIN.BLEND.ADDITION, dst = {
                    {time = 0, x = BASE.infoPositionX + 200, y = 500, w = 200, h = 200},
                    {time = bombCycle / 4, x = BASE.infoPositionX + randPos(300, 600), y = randPos(300, 800)},
                    {time = bombCycle - 1},
                    {time = bombCycle, a = 0}
                }
            })
            table.insert(parts.destination, {
                id = id_G, timer = gTimers[j], loop = -1, blend = MAIN.BLEND.ADDITION, dst = {
                    {time = 0, x = BASE.infoPositionX + 200, y = 500, w = 200, h = 200},
                    {time = bombCycle / 4, x = BASE.infoPositionX + randPos(300, 600), y = randPos(300, 800)},
                    {time = bombCycle - 1},
                    {time = bombCycle, a = 0}
                }
            })
            -- 配置（右）
            table.insert(parts.destination, {
                id = id_PG, timer = pgTimers[j], loop = -1, blend = MAIN.BLEND.ADDITION, dst = {
                    {time = 0, x = BASE.infoPositionX + 950, y = 500, w = 200, h = 200},
                    {time = bombCycle / 4, x = BASE.infoPositionX + randPos(500, 800), y = randPos(300, 800)},
                    {time = bombCycle - 1},
                    {time = bombCycle, a = 0}
                }
            })
            table.insert(parts.destination, {
                id = id_G, timer = gTimers[j], loop = -1, blend = MAIN.BLEND.ADDITION, dst = {
                    {time = 0, x = BASE.infoPositionX + 950, y = 500, w = 200, h = 200},
                    {time = bombCycle / 4, x = BASE.infoPositionX + randPos(500, 800), y = randPos(300, 800)},
                    {time = bombCycle - 1},
                    {time = bombCycle, a = 0}
                }
            })
        end
    end

    return parts
end

return {
    load = load
}