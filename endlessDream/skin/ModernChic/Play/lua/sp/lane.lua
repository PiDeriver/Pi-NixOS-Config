--[[
	レーン・グローランプ
	@author : KASAKO
]]

local judgeHeight = COMMONFUNC.offsetJudgelineHeight(PROPERTY.offsetJudgelineHeight.height())
local function lane(parts)
	-- レーン(1P2P共通)
	table.insert(parts.image, {id = "lane", src = 1, x = 37, y = 0, w = 519, h = 857})
	-- レーンの仕切り
	table.insert(parts.image, {id = "lane_1P", src = 1, x = 30, y = 1160, w = 513, h = 10})
	table.insert(parts.image, {id = "lane_2P", src = 1, x = 600, y = 1160, w = 513, h = 10})
	-- レーン（基準点）
	table.insert(parts.destination,	{id = "lane", dst = {{x = BASE.playsidePositionX, y = BASE.NOTES_JUDGE_Y - 3, w = 519, h = 857}}})
	if PROPERTY.isLeftScratch() then
		table.insert(parts.destination,	{
			id = "lane_1P", loop = 1000, timer = MAIN.TIMER.READY, dst = {
				{time = 0, x = BASE.playsidePositionX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 1},
				{time = 1000, h = 854}
			}
		})
		-- プレビュー中はレーンを表示する
		table.insert(parts.destination,	{id = "lane_1P", timer = MAIN.TIMER.PREVIEW, dst = {{x = BASE.playsidePositionX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 854}}})
	elseif PROPERTY.isRightScratch() then
		table.insert(parts.destination,	{
			id = "lane_2P", loop = 1000, timer = MAIN.TIMER.READY, dst = {
				{time = 0, x = BASE.playsidePositionX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 1},
				{time = 1000, h = 854}
			}
		})
		-- プレビュー中はレーンを表示する
		table.insert(parts.destination,	{id = "lane_2P", timer = MAIN.TIMER.PREVIEW, dst = {{time = 0, x = BASE.playsidePositionX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 854}}})
	end
	-- レーンの明るさ調節
	table.insert(parts.destination,	{id = MAIN.IMAGE.BLACK, offsets = {PROPERTY.offsetLaneBrightness.num}, dst = {{x = BASE.playsidePositionX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 854, a = 0}}})
	table.insert(parts.destination,	{id = "preview", timer = MAIN.TIMER.PREVIEW, offsets = {MAIN.OFFSET.LIFT}, dst = {
		{time = 0, x = BASE.playsidePositionX + (513 / 2), y = 300, w = 513, h = 18, a = 80},
		{time = 3000, a = 50},
		{time = 6000, a = 80}
	}})
end
local function judgeLine(parts)
	-- 判定ライン
	table.insert(parts.image, {id = "judge_line", src = 5, x = 0, y = 0, w = 513, h = 12})
	table.insert(parts.destination,	{
		id = "judge_line", loop = 1000, offset = MAIN.OFFSET.LIFT, dst = {
			{time = 500, x = BASE.playsidePositionX + 3 + (513 / 2), y = BASE.NOTES_JUDGE_Y, w = 0, h = judgeHeight},
			{time = 1000, x = BASE.playsidePositionX + 3, w = 513},
		}
	})
end
local function glowLamp(parts)
	local glowHeight = COMMONFUNC.offsetGlowlampHeight(PROPERTY.offsetGlowlampHeight.height())
	table.insert(parts.image, {id = "glow", src = 9, x = 0, y = 0, w = 431, h = 48})
	-- timer:140 RHYHM（1000を一拍とする）
	if PROPERTY.isGlowLampOn() then
		table.insert(parts.destination, {
			id = "glow", offset = MAIN.OFFSET.LIFT, timer = MAIN.TIMER.RHYTHM, blend = MAIN.BLEND.ADDITION, filter = MAIN.FILTER.OFF, dst = {
				{time = 0, x = BASE.playsidePositionX + 3, y = BASE.NOTES_JUDGE_Y + judgeHeight, w = 513, h = glowHeight, a = 255},
				{time = 1000, a = 0}
			}
		})
		-- 初期グロー
		table.insert(parts.destination,	{
			id = "glow", offset = MAIN.OFFSET.LIFT, blend = MAIN.BLEND.ADDITION, filter = MAIN.FILTER.OFF, loop = 1500, dst = {
				{time = 1000, x = BASE.playsidePositionX + 3, y = BASE.NOTES_JUDGE_Y + judgeHeight, w = 513, h = glowHeight, a = 0},
				{time = 1500, a = 120}
			}
		})
	end
end

local function load()
	local parts = {}
	parts.image = {}
	parts.destination = {}
	lane(parts)
	glowLamp(parts)
	judgeLine(parts)
	return parts
end

return {
	load = load
}