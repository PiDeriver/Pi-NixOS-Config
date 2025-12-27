--[[
    プレイ履歴表示機能
    @author : KASAKO
]]

local baseX = {play = 190, clear = 330, score = 580, miss = 830}
local padding = 2

-- 本日の日時とか
local function displayTodayInfo(parts)
    table.insert(parts.value, {id = "year", src = 5, x = 2401, y = 525, w = 242, h = 15, divx = 11, digit = 2, ref = MAIN.NUM.TIME_YEAR})
    table.insert(parts.value, {id = "month", src = 5, x = 2401, y = 525, w = 242, h = 15, divx = 11, digit = 2, ref = MAIN.NUM.TIME_MONTH})
    table.insert(parts.value, {id = "day", src = 5, x = 2401, y = 525, w = 242, h = 15, divx = 11, digit = 2, ref = MAIN.NUM.TIME_DAY})
    table.insert(parts.destination, {
		id = "year", dst = {
			{x = 10, y = 938, w = 21, h = 15},
		}
	})
    table.insert(parts.destination, {
		id = "sepa", dst = {
			{x = 55, y = 937, w = 21, h = 15},
		}
	})
    table.insert(parts.destination, {
		id = "month", dst = {
			{x = 65, y = 938, w = 21, h = 15},
		}
	})
    table.insert(parts.destination, {
		id = "sepa", dst = {
			{x = 115, y = 937, w = 21, h = 15},
		}
	})
    table.insert(parts.destination, {
		id = "day", dst = {
			{x = 125, y = 938, w = 21, h = 15},
		}
	})
end

-- 本日のプレイ曲数を取得
local function displayTodayHistoryCount(parts)
    table.insert(parts.image, {
        id = "todayPlayCountFrame", src = 9, x = 1037, y = 80, w = 66, h = 19
    })
    table.insert(parts.value, {
        id = "todayPlayCount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, value = function()
            return CUSTOM.NUM.todaySongUpdateCount
        end
    })
    table.insert(parts.destination, {
		id = "todayPlayCountFrame", dst = {
			{x = baseX.play, y = 937, w = 66, h = 19},
		}
	})
    table.insert(parts.destination, {
		id = "todayPlayCount", dst = {
			{x = baseX.play + 66 + padding , y = 938, w = 21, h = 15},
		}
	})
end

-- 本日のランプ更新曲数を取得
local function displayTodayClearUpdateHistoryCount(parts)
    table.insert(parts.image, {
        id = "todayClearCountFrame", src = 9, x = 1037, y = 99, w = 175, h = 19
    })
    table.insert(parts.value, {
        id = "todayClearCount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, value = function()
            return CUSTOM.NUM.todayClearUpdateCount
        end
    })
    table.insert(parts.destination, {
		id = "todayClearCountFrame", dst = {
			{x = baseX.clear, y = 937, w = 175, h = 19},
		}
	})
    table.insert(parts.destination, {
		id = "todayClearCount", dst = {
			{x = baseX.clear + 175 + padding, y = 938, w = 21, h = 15},
		}
	})
end
-- 本日のスコア更新曲数を取得
local function displayTodayScoreUpdateHistoryCount(parts)
    table.insert(parts.image, {
        id = "todayScoreCountFrame", src = 9, x = 1037, y = 118, w = 175, h = 19
    })
    table.insert(parts.value, {
        id = "todayScoreCount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, value = function()
            return CUSTOM.NUM.todayScoreUpdateCount
        end
    })
    table.insert(parts.destination, {
		id = "todayScoreCountFrame", dst = {
			{x = baseX.score, y = 937, w = 175, h = 19},
		}
	})
    table.insert(parts.destination, {
		id = "todayScoreCount", dst = {
			{x = baseX.score + 175 + padding, y = 938, w = 21, h = 15},
		}
	})
end
-- 本日のミスカン更新曲数を取得
local function displayTodayMisscountUpdateHistoryCount(parts)
    table.insert(parts.image, {
        id = "todayMissCountFrame", src = 9, x = 1037, y = 137, w = 131, h = 19
    })
    table.insert(parts.value, {
        id = "todayMissCount", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, value = function()
            return CUSTOM.NUM.todayMissUpdateCount
        end
    })
    table.insert(parts.destination, {
		id = "todayMissCountFrame", dst = {
			{x = baseX.miss, y = 937, w = 131, h = 19},
		}
	})
    table.insert(parts.destination, {
		id = "todayMissCount", dst = {
			{x = baseX.miss + 131 + padding, y = 938, w = 21, h = 15},
		}
	})
end

local function load()
    local parts = {}
    parts.image = {}
    parts.value = {}
    parts.destination = {}
    displayTodayInfo(parts)
    displayTodayHistoryCount(parts)
    displayTodayClearUpdateHistoryCount(parts)
    displayTodayScoreUpdateHistoryCount(parts)
    displayTodayMisscountUpdateHistoryCount(parts)
    return parts
end

return {
    load = load
}