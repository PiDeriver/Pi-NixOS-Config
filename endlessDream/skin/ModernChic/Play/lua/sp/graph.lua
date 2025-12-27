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
	local drawDecay = 0
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
    local posX
    local judgegraphPosX
    if PROPERTY.isInfoDisplayTypeA() then
        posX = 808
        judgegraphPosX = 832
    elseif PROPERTY.isInfoDisplayTypeB() then
        posX = 23
        judgegraphPosX = 47
    end
    if PROPERTY.isnotesDistributionCoverOff() then
        table.insert(parts.image, {id = "infoNotesDistributionFrame", src = 2, x = 808, y = 926, w = 519, h = 142})
        table.insert(parts.destination,{
            id = "infoNotesDistributionFrame", dst = {
                {x = BASE.infoPositionX + posX, y = 62, w = 519, h = 142},
            }
        })
        -- プレイ詳細時は強制的にノート構成に
        if PROPERTY.isDetailInfoSwitchOn() then
            table.insert(parts.judgegraph, {id = "judgegraph", type = MAIN.JUDGEGRAPH.TYPE.NOTES, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF})
        elseif PROPERTY.isnotesDistributionTypeA() then
            table.insert(parts.judgegraph, {id = "judgegraph", type = MAIN.JUDGEGRAPH.TYPE.JUDGE, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF})
        elseif PROPERTY.isnotesDistributionTypeB() then
            table.insert(parts.judgegraph, {id = "judgegraph", type = MAIN.JUDGEGRAPH.TYPE.FASTSLOW, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF})
        elseif PROPERTY.isnotesDistributionTypeC() then
            table.insert(parts.judgegraph, {id = "judgegraph", type = MAIN.JUDGEGRAPH.TYPE.NOTES, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.OFF})
        end
        table.insert(parts.bpmgraph, {id = "bpmgraph"})
        table.insert(parts.destination,	{
            id = "judgegraph", dst = {
                {time = 0, x = BASE.infoPositionX + judgegraphPosX, y = 71, w = 472, h = 107}
            }
        })
        table.insert(parts.destination,	{
            id = "bpmgraph", dst = {
                {time = 0, x = BASE.infoPositionX + judgegraphPosX, y = 71, w = 472, h = 107}
            }
        })
    elseif PROPERTY.isnotesDistributionCoverOn() then
        table.insert(parts.image, {id = "notesCover", src = 2, x = 780, y = 1130, w = 519, h = 140})
        table.insert(parts.destination,	{
            id = "notesCover", dst = {
                {x = BASE.infoPositionX + posX, y = 62, w = 519, h = 140},
            }
        })
    end
end
-- タイミンググラフ
local function infoJudgegraph(parts)
    -- 基準点
    local posX
    local judgegraphPosX
    if PROPERTY.isInfoDisplayTypeA() then
        posX = 808
        judgegraphPosX = 832
    elseif PROPERTY.isInfoDisplayTypeB() then
        posX = 23
        judgegraphPosX = 47
    end
    if PROPERTY.isTiminggraphCoverOff() then
        table.insert(parts.image, {id = "infoJudgegraphFrame", src = 2, x = 808, y = 1072, w = 519, h = 54})
        table.insert(parts.destination,{
            id = "infoJudgegraphFrame", dst = {
                {x = BASE.infoPositionX + posX , y = 4, w = 519, h = 54},
            }
        })
        if PROPERTY.isTiminggraphTypeA() then
            createTimingVisualizer(parts.timingvisualizer)
            createHitErrorVisualizer(parts.hiterrorvisualizer)
            table.insert(parts.destination, {
                id = MAIN.IMAGE.BLACK, dst = {
                    {x = BASE.infoPositionX + judgegraphPosX, y = 8, w = 472, h = 30},
                }
            })
            local judge = {
                wd = {"veryeasy", "easy", "normal", "hard", "veryhard"},
                op = {MAIN.OP.JUDGE_VERYEASY, MAIN.OP.JUDGE_EASY, MAIN.OP.JUDGE_NORMAL, MAIN.OP.JUDGE_HARD, MAIN.OP.JUDGE_VERYHARD},
                posy = 180
            }
            for i = 1, 5, 1 do
                table.insert(parts.image, {id = judge.wd[i], src = 22, x = 200, y = judge.posy, w = 210, h = 30})
                judge.posy = judge.posy + 30
                table.insert(parts.destination, {
                    id = judge.wd[i], op = {MAIN.OP.NOW_LOADING, judge.op[i]}, dst = {
                        {x = BASE.infoPositionX + judgegraphPosX + ((472 - 210) / 2), y = 8, w = 210, h = 30},
                    }
                })
            end
            if PROPERTY.isTiminggraphDisplayTypeA() then
                table.insert(parts.destination,	{
                    id = "timing", timer = MAIN.TIMER.PLAY, dst = {
                        {time = 0, x = BASE.infoPositionX + judgegraphPosX, y = 8, w = 472, h = 30}
                    }
                })
                table.insert(parts.destination, {
                    id = "hrv", timer = MAIN.TIMER.PLAY, dst = {
                        {time = 0, x = BASE.infoPositionX + judgegraphPosX + 472, y = 8, w = -472, h = 30}
                    }
                })
            elseif PROPERTY.isTiminggraphDisplayTypeB() then
                -- プレイ側
                local laneWidth = 518
                local graphWidth = 472
                local ad = (laneWidth - graphWidth) / 2
                table.insert(parts.destination,	{
                    id = "timing", timer = MAIN.TIMER.PLAY, offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTiminggraph.num}, dst = {
                        {time = 0, x = BASE.playsidePositionX + ad, y = 310, w = graphWidth, h = 30}
                    }
                })
                table.insert(parts.destination, {
                    id = "hrv", timer = MAIN.TIMER.PLAY, offsets = {MAIN.OFFSET.LIFT, PROPERTY.offsetTiminggraph.num}, dst = {
                        {time = 0, x = BASE.playsidePositionX + ad + graphWidth, y = 310, w = -graphWidth, h = 30}
                    }
                })
            end
        elseif PROPERTY.isTiminggraphTypeB() then
            -- タイミンググラフ・棒グラフタイプ
            table.insert(parts.image, {id = "tgBFrame", src = 1, x = 600, y = 630, w = 472, h = 30})
            table.insert(parts.image, {id = "tgBFrame2", src = 1, x = 600, y = 660, w = 472, h = 30})
            table.insert(parts.graph, {
                id = "gra_fastRate", src = 1, x = 600, y = 690, w = 468, h = 26, angle = 0, value = function()
                    return CUSTOM.GRAPH.FastRate()
                end
            })
            table.insert(parts.graph, {
                id = "gra_slowRate", src = 1, x = 600, y = 716, w = 468, h = 26, angle = 0, value = function()
                    return CUSTOM.GRAPH.SlowRate()
                end
            })
            table.insert(parts.destination, {
                id = "tgBFrame", dst = {
                    {x = BASE.infoPositionX + judgegraphPosX, y = 8, w = 472, h = 30},
                }
            })
            table.insert(parts.destination, {
                id = "gra_fastRate", dst = {
                    {x = BASE.infoPositionX + judgegraphPosX + 2, y = 10, w = 468, h = 26},
                }
            })
            table.insert(parts.destination, {
                id = "gra_slowRate", dst = {
                    {x = BASE.infoPositionX + judgegraphPosX + 470, y = 10, w = -468, h = 26},
                }
            })
            table.insert(parts.destination, {
                id = "tgBFrame2", dst = {
                    {x = BASE.infoPositionX + judgegraphPosX, y = 8, w = 472, h = 30},
                }
            })
        end
        -- judgetimingnum
        table.insert(parts.value, {id = "judgeTimingNum", src = 1, x = 1400, y = 121, w = 324, h = 40, divx = 12, divy = 2, digit = 4, ref = MAIN.NUM.JUDGETIMING, zeropadding = MAIN.N_ZEROPADDING.OFF, align = MAIN.N_ALIGN.CENTER})
        table.insert(parts.destination, {
            id = "judgeTimingNum", dst = {
                {x = BASE.infoPositionX + judgegraphPosX, y = 37, w = 27, h = 20},
            }
        })
        table.insert(parts.destination, {
            id = "judgeTimingNum", dst = {
                {x = BASE.infoPositionX + judgegraphPosX + 350, y = 37, w = 27, h = 20},
            }
        })
        -- タイミング調節ボタン
        table.insert(parts.image, {id = "timingAdjustBtn", src = 1, x = 2, y = 0, w = 1, h = 1, act = MAIN.BUTTON.JUDGE_TIMING})
        table.insert(parts.destination, {
            id = "timingAdjustBtn", dst = {
                {x = BASE.infoPositionX + judgegraphPosX, y = 4, w = 519, h = 54},
            }
        })
    elseif PROPERTY.isTiminggraphCoverOn() then
        -- タイミンググラフカバー
        table.insert(parts.image, {id = "timingCover", src = 2, x = 780, y = 1280, w = 519, h = 54})
        table.insert(parts.destination,	{
            id = "timingCover", dst = {
                {x = BASE.infoPositionX + posX, y = 4, w = 519, h = 54},
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