--[[
    タイミンググラフ関連
    @author : KASAKO
]]

local function createHitErrorVisualizer(contents)
	local judgeWidthMillis = nil
	local emaMode = nil
	-- 倍率
	if PROPERTY.isTiminggraphMagnificationLow() then
		judgeWidthMillis = 225
	elseif PROPERTY.isTiminggraphMagnificationNormal() then
		judgeWidthMillis = 150
	elseif PROPERTY.isTiminggraphMagnificationHigh() then
		judgeWidthMillis = 75
	end
	-- 表示パターン
	if PROPERTY.isHitErrorVisualizerPatternNormal() then
		emaMode = 1
	elseif PROPERTY.isHitErrorVisualizerPatternTriangle() then
		emaMode = 2
	elseif PROPERTY.isHitErrorVisualizerPatternEmphasis() then
		emaMode = 3
	end
	table.insert(contents,{
		id = "hrv",
		width = 300,
		judgeWidthMillis = judgeWidthMillis,
		lineWidth = 1,
		colorMode = 1,
		hiterrorMode = 0,
		emaMode = emaMode,
		lineColor = "99CCFF80",
		centerColor = "FFFFFFFF",
		PGColor = "99CCFF80",
		GRColor = "F2CB3080",
		GDColor = "14CC8f80",
		BDColor = "FF1AB380",
		PRColor = "CC292980",
		emaColor = "FF0000FF",
		windowLength = 30,
		transparent = 1,
		drawDecay = 1,
	})
end

local function createTimingVisualizer(contents)
	local width = 300
	local judgeWidthMillis = nil
	local lineWidth = 1
	local lineColor = "00FF00FF"
	local centerColor = "FFFFFFFF"
	local PGColor = "00008855"
	local GRColor = "00880055"
	local GDColor = "88880055"
	local BDColor = "88000055"
	local PRColor = "00000055"
	local transparent = 0
	local drawDecay = 1
	-- 倍率
	if PROPERTY.isTiminggraphMagnificationLow() then
		-- +-225ms
		judgeWidthMillis = 225
	elseif PROPERTY.isTiminggraphMagnificationNormal() then
		-- +-150ms
		judgeWidthMillis = 150
	elseif PROPERTY.isTiminggraphMagnificationHigh() then
		-- +-75ms
		judgeWidthMillis = 75
	end
	-- カラーパターン
	if PROPERTY.isTiminggraphColorRed() then
		lineColor = "E286A7FF"
		PGColor = "44000055"
		GRColor = "99000055"
		GDColor = "44000055"
		BDColor = "99000055"
		PRColor = "00000055"
	elseif PROPERTY.isTiminggraphColorGreen() then
		lineColor = "86E088FF"
		PGColor = "00440055"
		GRColor = "00880055"
		GDColor = "00440055"
		BDColor = "00880055"
		PRColor = "00000055"
	elseif PROPERTY.isTiminggraphColorBlue() then
		lineColor = "89DDDCFF"
		PGColor = "22224455"
		GRColor = "22229955"
		GDColor = "22224455"
		BDColor = "22229955"
		PRColor = "00000055"
	end

	table.insert(contents, {
		id = "timing",
		width = width,
		judgeWidthMillis = judgeWidthMillis,
		lineWidth = lineWidth,
		lineColor = lineColor,
		centerColor = centerColor,
		PGColor = PGColor,
		GRColor = GRColor,
		GDColor = GDColor,
		BDColor = BDColor,
		PRColor = PRColor,
		transparent = transparent,
		drawDecay = drawDecay
	})
end

 -- ノート分布グラフ
local function infoNotesDistribution(parts)
    local pos = {x = BASE.subPosX[1], y = 90}
    if PROPERTY.isnotesDistributionCoverOff() then
        table.insert(parts.image, {id = "notesgraphFrame", src = 1, x = 380, y = 250, w = 331, h = 140})
        table.insert(parts.bpmgraph, {id = "bpmgraph"})
        if PROPERTY.isnotesDistributionTypeA() then
            table.insert(parts.judgegraph, {id = "judgegraph", type = MAIN.JUDGEGRAPH.TYPE.JUDGE, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF})
        elseif PROPERTY.isnotesDistributionTypeB() then
            table.insert(parts.judgegraph, {id = "judgegraph", type = MAIN.JUDGEGRAPH.TYPE.FASTSLOW, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF})
        elseif PROPERTY.isnotesDistributionTypeC() then
            table.insert(parts.judgegraph, {id = "judgegraph", type = MAIN.JUDGEGRAPH.TYPE.NOTES, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF})
        end
        table.insert(parts.destination, {
            id = "notesgraphFrame", dst = {
                {x = pos.x, y = pos.y, w = 331, h = 140},
            }
        })
        table.insert(parts.destination, {
            id = "judgegraph", dst = {
                {x = pos.x + 10, y = pos.y + 10, w = 311, h = 108},
            }
        })
        table.insert(parts.destination, {
            id = "bpmgraph", dst = {
                {x = pos.x + 10, y = pos.y + 10, w = 311, h = 108},
            }
        })
    elseif PROPERTY.isnotesDistributionCoverOn() then
        table.insert(parts.image, {id = "notesCover", src = 1, x = 0, y = 1270, w = 331, h = 140})
        table.insert(parts.destination, {
            id = "notesCover", dst = {
                {x = pos.x, y = pos.y, w = 331, h = 140},
            }
        })
    end
end

-- タイミンググラフ
local function infoJudgegraph(parts)
    local pos = {x = BASE.subPosX[1], y = 23}
    if PROPERTY.isTiminggraphCoverOff() then
        table.insert(parts.image, {id = "timinggraphFrame", src = 1, x = 380, y = 400, w = 331, h = 54})
        table.insert(parts.image, {id = "timingAdjustBtn", src = 1, x = 529, y = 0, w = 1, h = 1, act = MAIN.BUTTON.JUDGE_TIMING})
        table.insert(parts.value, {id = "judgeTimingNum", src = 1, x = 720, y = 1100, w = 288, h = 40, divx = 12, divy = 2, digit = 4, ref = MAIN.NUM.JUDGETIMING, zeropadding = MAIN.N_ZEROPADDING.OFF, align = MAIN.N_ALIGN.CENTER})
        createTimingVisualizer(parts.timingvisualizer)
        createHitErrorVisualizer(parts.hiterrorvisualizer)
        table.insert(parts.destination, {
            id = "timinggraphFrame", dst = {
                {x = pos.x, y = pos.y, w = 331, h = 54},
            }
        })
        table.insert(parts.destination, {
            id = MAIN.IMAGE.BLACK, dst = {
                {x = pos.x + 10, y = pos.y + 5, w = 311, h = 30},
            }
        })
        if PROPERTY.isTiminggraphDisplayTypeA() then
            table.insert(parts.destination, {
                id = "timing", dst = {
                    {x = pos.x + 10, y = pos.y + 5, w = 311, h = 30},
                }
            })
            table.insert(parts.destination, {
                id = "hrv", dst = {
                    {x = pos.x + 10 + 311, y = pos.y + 5, w = -311, h = 30},
                }
            })
        elseif PROPERTY.isTiminggraphDisplayTypeB() then
            local laneWidth = 518
            local graphWidth = 472
            local ad = (laneWidth - graphWidth) / 2
            local posX = {BASE.laneLeftPosX, BASE.laneRightPosX}
            for i = 1, 2, 1 do
                table.insert(parts.destination, {
                    id = "timing", timer = MAIN.TIMER.PLAY, offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTiminggraph.num}, dst = {
                        {x = posX[i] + ad, y = 310, w = graphWidth, h = 30},
                    }
                })
                table.insert(parts.destination, {
                    id = "hrv", timer = MAIN.TIMER.PLAY, offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTiminggraph.num}, dst = {
                        {x = posX[i] + ad + graphWidth, y = 310, w = -graphWidth, h = 30},
                    }
                })
            end
        end
        -- judgetimingnum
        table.insert(parts.destination, {
            id = "judgeTimingNum", dst = {
                {x = pos.x - 5, y = 60, w = 18, h = 15},
            }
        })
        table.insert(parts.destination, {
            id = "judgeTimingNum", dst = {
                {x = pos.x + 255, y = 60, w = 18, h = 15},
            }
        })
        -- タイミング調節ボタン
        table.insert(parts.destination, {
            id = "timingAdjustBtn", dst = {
                {x = pos.x, y = pos.y, w = 331 , h = 54},
            }
        })
    elseif PROPERTY.isTiminggraphCoverOn() then
        table.insert(parts.image, {id = "timingCover", src = 1, x = 0, y = 1420, w = 331, h = 54})
        table.insert(parts.destination, {
            id = "timingCover", dst = {
                {x = pos.x, y = pos.y, w = 331, h = 54},
            }
        })
    end
end

local function load()
    local parts = {}
    parts.image = {}
    parts.value = {}
    parts.judgegraph = {}
    parts.bpmgraph = {}
	parts.timingvisualizer = {}
	parts.hiterrorvisualizer = {}
	parts.graph = {}
    parts.destination = {}

    -- 判定グラフ
    infoNotesDistribution(parts)
    -- タイミンググラフ
    infoJudgegraph(parts)
    return parts
end

return{
    load = load
}