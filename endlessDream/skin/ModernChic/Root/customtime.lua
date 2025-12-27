--[[
    時間関係
]]
local m = {}
-- 日付 yymmdd
m.DATE = os.date("%y%m%d")
-- 日付 yyyy-mm-dd
m.DATE2 = os.date("%Y/%m/%d")
-- 時間 hhmm
m.TIME = os.date("%H:%M:%S")
return m