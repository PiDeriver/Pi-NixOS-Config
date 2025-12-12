--[[
    カスタムタイマー用
    DATE:21/09/11
    @author : KASAKO
]]
local m = {}
local CUSTOMTIMER_ID = 9999
-- タイマー値をインクリメント
m.GET_CUSTOMTIMER_ID = function()
	CUSTOMTIMER_ID = CUSTOMTIMER_ID + 1
	return CUSTOMTIMER_ID
end

return m