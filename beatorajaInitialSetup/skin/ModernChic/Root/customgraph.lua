--[[
    カスタムグラフを定義する場合はここに記述
    graph定義のvalueプロパティで使用
    グラフは1を100％として表示
    @author : KASAKO
]]

local m = {}
-- SLOW割合
m.SlowRate = function()
    local slowNum = main_state.number(MAIN.NUM.TOTALLATE)
    local fastNum = main_state.number(MAIN.NUM.TOTALEARLY)
    local allNum = slowNum + fastNum
    return slowNum / allNum
end
-- FAST割合
m.FastRate = function()
    local slowNum = main_state.number(MAIN.NUM.TOTALLATE)
    local fastNum = main_state.number(MAIN.NUM.TOTALEARLY)
    local allNum = slowNum + fastNum
    return fastNum / allNum
end
-- 指定区間の割合（プレイスキン）
m.sectionRemainRate = function()
    -- 区間タイム
    local songLimitSec = (((main_state.number(MAIN.NUM.SONGLENGTH_MINUTE) * 60) + main_state.number(MAIN.NUM.SONGLENGTH_SECOND)) / 4) * 1
    -- 経過時間
    local nowSec = CUSTOM.NUM.elapsedTimeFromStart()
    if CUSTOM.sectionScore.oneFour.gFlg then
        local rate = 1 - (nowSec / songLimitSec)
        if (rate <= 1) and (rate > 0) then
            return rate
        else
            CUSTOM.sectionScore.oneFour.gFlg = not CUSTOM.sectionScore.oneFour.gFlg
            return 0
        end
    elseif CUSTOM.sectionScore.twoFour.gFlg then
        local rate = 1 - ((nowSec - (songLimitSec * 1)) / songLimitSec)
        if (rate <= 1) and (rate > 0) then
            return rate
        else
            CUSTOM.sectionScore.twoFour.gFlg = not CUSTOM.sectionScore.twoFour.gFlg
            return 0
        end
    elseif CUSTOM.sectionScore.threeFour.gFlg then
        local rate = 1 - ((nowSec - (songLimitSec * 2)) / songLimitSec)
        if (rate <= 1) and (rate > 0) then
            return rate
        else
            CUSTOM.sectionScore.threeFour.gFlg = not CUSTOM.sectionScore.threeFour.gFlg
            return 0
        end
    elseif CUSTOM.sectionScore.fourFour.gFlg then
        local rate = 1 - ((nowSec - (songLimitSec * 3)) / songLimitSec)
        if (rate <= 1) and (rate > 0) then
            return rate
        else
            CUSTOM.sectionScore.oneFour.gFlg = not CUSTOM.sectionScore.oneFour.gFlg
            return 0
        end
    else
        return 0
    end
end
return m