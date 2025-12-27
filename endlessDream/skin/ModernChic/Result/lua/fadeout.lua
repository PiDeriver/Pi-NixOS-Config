--[[
    フェードアウト処理
	@author : KASAKO
]]
local function load()
    local parts = {}
    parts.image = {
        -- フェードアウト時の文字
		{id = "finishClear", src = 2, x = 0, y = 1808, w = 1200, h = 50},
		{id = "finishFailed", src = 2, x = 0, y = 1858, w = 1200, h = 50},
    }
    parts.destination = {}

	-- ボタンが押されたら発動
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, timer = MAIN.TIMER.FADEOUT, loop = 1000, dst = {
			{time = 0, x = 0, y = 540, w = 1920, h = 0},
			{time = 500, y = 0, h = 1080},
			{time = 1000}
		}
	})
	table.insert(parts.destination, {
		id = "finishClear", timer = MAIN.TIMER.FADEOUT, op = {MAIN.OP.RESULT_CLEAR}, loop = -1, dst = {
			{time = 300, x =  375, y = 513, w = 1200, h = 50, a = 0},
			{time = 600, a = 255},
			{time = 1000}
		}
	})
	table.insert(parts.destination, {
		id = "finishFailed", timer = MAIN.TIMER.FADEOUT, op = {MAIN.OP.RESULT_FAIL}, loop = -1, dst = {
			{time = 300, x =  375, y = 513, w = 1200, h = 50, a = 0},
			{time = 600, a = 255},
			{time = 1000}
		}
	})

    return parts
end

return {
    load = load
}