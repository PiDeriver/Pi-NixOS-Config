--[[
	ボタン関係
	@author : KASAKO
--]]
local function load()
	local parts = {}
	local mouseRectRGB = {216, 255, 0}
	
	parts.image = {
		-- ボタン類
		{id = "tex-autoplay", src = 5, x = 350, y = 1350, w = 110, h = 11},
		{id = "tex-practice", src = 5, x = 350, y = 1361, w = 110, h = 11},
		{id = "tex-text", src = 5, x = 350, y = 1372, w = 110, h = 11},
		{id = "tex-replay", src = 5, x = 350, y = 1383, w = 110, h = 11},
		{id = "tex-lnmode", src = 5, x = 350, y = 1394, w = 110, h = 11},
		{id = "tex-keymode", src = 5, x = 350, y = 1405, w = 110, h = 11},
		{id = "tex-sortmode", src = 5, x = 350, y = 1416, w = 110, h = 11},
		{id = "btn-autoplay", src = 5, x = 0, y = 1470, w = 104, h = 91},
		{id = "btn-autoplay-rect", src = 5, x = 0, y = 1470, w = 104, h = 91, act = MAIN.BUTTON.AUTOPLAY},
		{id = "btn-practice", src = 5, x = 104, y = 1470, w = 104, h = 91},
		{id = "btn-practice-rect", src = 5, x = 104, y = 1470, w = 104, h = 91, act = MAIN.BUTTON.PRACTICE},
		{id = "btn-no-text", src = 5, x = 208, y = 1470, w = 104, h = 91},
		{id = "btn-text", src = 5, x = 208, y = 1561, w = 104, h = 91},
		{id = "btn-text-rect", src = 5, x = 208, y = 1561, w = 104, h = 91, act = 17},
		{id = "btn-lnmode", src = 5, x = 312, y = 1470, w = 104, h = 273, divy = 3, len = 3, ref = MAIN.BUTTON.LNMODE, act = MAIN.BUTTON.LNMODE},
		{id = "btn-keymode", src = 5, x = 416, y = 1470, w = 104, h = 730, divy = 8, len = 8, ref = MAIN.BUTTON.MODE, act = MAIN.BUTTON.MODE},
		{id = "btn-sortmode", src = 5, x = 520, y = 1470, w = 104, h = 730, divy = 8, len = 8, ref = MAIN.BUTTON.SORT, act = MAIN.BUTTON.SORT},
		{id = "btn-replay1-on", src = 5, x = 630, y = 1470, w = 53, h = 46, act = MAIN.BUTTON.REPLAY},
		{id = "btn-replay1-off", src = 5, x = 630, y = 1516, w = 53, h = 46},
		{id = "btn-replay1-rect", src = 5, x = 630, y = 1562, w = 53, h = 46},
		{id = "btn-replay1-select", src = 5, x = 630, y = 1562, w = 53, h = 46},
		{id = "btn-replay2-on", src = 5, x = 683, y = 1470, w = 53, h = 46, act = MAIN.BUTTON.REPLAY2},
		{id = "btn-replay2-off", src = 5, x = 683, y = 1516, w = 53, h = 46},
		{id = "btn-replay2-rect", src = 5, x = 683, y = 1562, w = 53, h = 46},
		{id = "btn-replay2-select", src = 5, x = 683, y = 1562, w = 53, h = 46},
		{id = "btn-replay3-on", src = 5, x = 736, y = 1470, w = 53, h = 46, act = MAIN.BUTTON.REPLAY3},
		{id = "btn-replay3-off", src = 5, x = 736, y = 1516, w = 53, h = 46},
		{id = "btn-replay3-rect", src = 5, x = 736, y = 1562, w = 53, h = 46},
		{id = "btn-replay3-select", src = 5, x = 736, y = 1562, w = 53, h = 46},
		{id = "btn-replay4-on", src = 5, x = 789, y = 1470, w = 53, h = 46, act = MAIN.BUTTON.REPLAY4},
		{id = "btn-replay4-off", src = 5, x = 789, y = 1516, w = 53, h = 46},
		{id = "btn-replay4-rect", src = 5, x = 789, y = 1562, w = 53, h = 46},
		{id = "btn-replay4-select", src = 5, x = 789, y = 1562, w = 53, h = 46},
	}
	
	parts.destination = {}
	
	-- オートプレイ
	table.insert(parts.destination, {
		id = "btn-autoplay", dst = {
			{x = 1074, y = 956, w = 104, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "btn-autoplay-rect", dst = {
			{x = 1074, y = 956, w = 104, h = 91, r = mouseRectRGB[1], g = mouseRectRGB[2], b = mouseRectRGB[3]},
		}, mouseRect = {x = 0, y = 0, w = 104, h = 91}
	})
	table.insert(parts.destination, {
		id = "tex-autoplay", dst = {
			{x = 1074, y = 937, w = 110, h = 11},
		}
	})

	-- 練習
	table.insert(parts.destination, {
		id = "btn-practice", dst = {
			{x = 1194, y = 956, w = 104, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "btn-practice-rect", dst = {
			{x = 1194, y = 956, w = 104, h = 91, r = mouseRectRGB[1], g = mouseRectRGB[2], b = mouseRectRGB[3]},
		}, mouseRect = {x = 0, y = 0, w = 104, h = 91}
	})
	table.insert(parts.destination, {
		id = "tex-practice", dst = {
			{x = 1202, y = 937, w = 110, h = 11},
		}
	})

	-- テキスト
	table.insert(parts.destination, {
		id = "btn-no-text", dst = {
			{x = 1315, y = 956, w = 104, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "btn-text", op = {MAIN.OP.TEXT}, dst = {
			{x = 1315, y = 956, w = 104, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "btn-text-rect", op = {MAIN.OP.TEXT}, dst = {
			{x = 1315, y = 956, w = 104, h = 91, r = mouseRectRGB[1], g = mouseRectRGB[2], b = mouseRectRGB[3]},
		}, mouseRect = {x = 0, y = 0, w = 104, h = 91}
	})
	table.insert(parts.destination, {
		id = "tex-text", dst = {
			{x = 1343, y = 937, w = 110, h = 11},
		}
	})

	-- リプレイ
	table.insert(parts.destination, {
		id = "btn-replay1-off", dst = {
			{x = 1433, y = 1004, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay1-on", op = {MAIN.OP.REPLAYDATA}, dst = {
			{x = 1433, y = 1004, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay1-rect", op = {MAIN.OP.REPLAYDATA}, dst = {
			{x = 1433, y = 1004, w = 53, h = 46},
		}, mouseRect = {x = 0, y = 0, w = 53, h = 46}
	})
	table.insert(parts.destination, {
		id = "btn-replay1-select", op = {MAIN.OP.SELECT_REPLAYDATA}, dst = {
			{x = 1433, y = 1004, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay2-off", dst = {
			{x = 1490, y = 1004, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay2-on", op = {MAIN.OP.REPLAYDATA2}, dst = {
			{x = 1490, y = 1004, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay2-rect", op = {MAIN.OP.REPLAYDATA2}, dst = {
			{x = 1490, y = 1004, w = 53, h = 46},
		}, mouseRect = {x = 0, y = 0, w = 53, h = 46}
	})
	table.insert(parts.destination, {
		id = "btn-replay2-select", op = {MAIN.OP.SELECT_REPLAYDATA2}, dst = {
			{x = 1490, y = 1004, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay3-off", dst = {
			{x = 1433, y = 953, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay3-on", op = {MAIN.OP.REPLAYDATA3}, dst = {
			{x = 1433, y = 953, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay3-rect", op = {MAIN.OP.REPLAYDATA3}, dst = {
			{x = 1433, y = 953, w = 53, h = 46},
		}, mouseRect = {x = 0, y = 0, w = 53, h = 46}
	})
	table.insert(parts.destination, {
		id = "btn-replay3-select", op = {MAIN.OP.SELECT_REPLAYDATA3}, dst = {
			{x = 1433, y = 953, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay4-off", dst = {
			{x = 1490, y = 953, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay4-on", op = {MAIN.OP.REPLAYDATA4}, dst = {
			{x = 1490, y = 953, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "btn-replay4-rect", op = {MAIN.OP.REPLAYDATA4}, dst = {
			{x = 1490, y = 953, w = 53, h = 46},
		}, mouseRect = {x = 0, y = 0, w = 53, h = 46}
	})
	table.insert(parts.destination, {
		id = "btn-replay4-select", op = {MAIN.OP.SELECT_REPLAYDATA4}, dst = {
			{x = 1490, y = 953, w = 53, h = 46},
		}
	})
	table.insert(parts.destination, {
		id = "tex-replay", dst = {
			{x = 1452, y = 937, w = 110, h = 11},
		}
	})

	-- LNモード切り替え
	table.insert(parts.destination, {
		id = "btn-lnmode", dst = {
			{x = 1555, y = 956, w = 104, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "btn-lnmode", dst = {
			{x = 1555, y = 956, w = 104, h = 91, r = mouseRectRGB[1], g = mouseRectRGB[2], b = mouseRectRGB[3]},
		}, mouseRect = {x = 0, y = 0, w = 104, h = 91}
	})
	table.insert(parts.destination, {
		id = "tex-lnmode", dst = {
			{x = 1568, y = 937, w = 110, h = 11},
		}
	})
	table.insert(parts.destination, {
		id = "btn-keymode", dst = {
			{x = 1675, y = 956, w = 104, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "btn-keymode", dst = {
			{x = 1675, y = 956, w = 104, h = 91, r = mouseRectRGB[1], g = mouseRectRGB[2], b = mouseRectRGB[3]},
		}, mouseRect = {x = 0, y = 0, w = 104, h = 91}
	})
	table.insert(parts.destination, {
		id = "tex-keymode", dst = {
			{x = 1682, y = 937, w = 110, h = 11},
		}
	})
	table.insert(parts.destination, {
		id = "btn-sortmode", dst = {
			{x = 1795, y = 956, w = 104, h = 91},
		}
	})
	table.insert(parts.destination, {
		id = "btn-sortmode", dst = {
			{x = 1795, y = 956, w = 104, h = 91, r = mouseRectRGB[1], g = mouseRectRGB[2], b = mouseRectRGB[3]},
		}, mouseRect = {x = 0, y = 0, w = 104, h = 91}
	})
	table.insert(parts.destination, {
		id = "tex-sortmode", dst = {
			{x = 1796, y = 937, w = 110, h = 11},
		}
	})
	return parts
end

return {
	load = load
}