--[[
	中央部情報
	flg 0:通常 1:コース
	@author : KASAKO
]]
--DEBUG = true

local function createBasePosition(flg)
	local base = {
		diffFramePosY = 50,
		remainNotesFramePosY = 115,
		nextStageFramePosY = 115,
		chartBtnPosY = 1010
	}
	if flg == 0 then
		base.timeStampPosY = 910
	else
		base.timeStampPosY = 970
	end
	return base
end

-- モードと難易度カテゴリ
local function modeCategory(parts)
	table.insert(parts.image, {id = "diffFrame", src = 6, x = 0, y = 320, w = 520, h = 60})
	table.insert(parts.destination, {
		id = "diffFrame", dst = {
			{x = RESULT_BASE.CENTER_POS_X, y = parts.pos.diffFramePosY, w = 520, h = 60},
		}
	})
	do
		-- モード
		local wd = {"5keys", "7keys", "10keys", "14keys", "9keys", "24keys", "48keys"}
		local op = {MAIN.OP.SONG5KEY, MAIN.OP.SONG7KEY, MAIN.OP.SONG10KEY, MAIN.OP.SONG14KEY, MAIN.OP.SONG9KEY, MAIN.OP.SONG24KEY, MAIN.OP.SONG24KEYDP}
		local posY = 40
		for i = 1, 7, 1 do
			table.insert(parts.image, {id = wd[i], src = 6, x = 0, y = posY, w = 190, h = 40})
			posY = posY + 40
		end
		for i = 1, 7, 1 do
			table.insert(parts.destination, {
				id = wd[i], op = {op[i]}, dst = {
					{x = RESULT_BASE.CENTER_POS_X + 40, y = parts.pos.diffFramePosY + 8, w = 190, h = 40},
				}
			})
		end
	end
	do
		-- カテゴリくん
		local wd = {"unknown", "beginner", "normal", "hyper", "another", "insane"}
		local op = {MAIN.OP.DIFFICULTY0, MAIN.OP.DIFFICULTY1, MAIN.OP.DIFFICULTY2, MAIN.OP.DIFFICULTY3, MAIN.OP.DIFFICULTY4, MAIN.OP.DIFFICULTY5}
		local posY = 0
		for i = 1, 6, 1 do
			table.insert(parts.image, {id = wd[i], src = 6, x = 190, y = posY, w = 250, h = 40})
			posY = posY + 40
		end
		for i = 1, 6, 1 do
			table.insert(parts.destination, {
				id = wd[i], op = {op[i]}, dst = {
					{x = RESULT_BASE.CENTER_POS_X + 250, y = parts.pos.diffFramePosY + 8, w = 250, h = 40},
				}
			})
		end
	end
end

-- タイムスタンプ機能
local function timeStamp(parts)
	if PROPERTY.isTimestampOn() then
		-- 日付
		table.insert(parts.destination, {
			id = "dete", dst = {
				{x = RESULT_BASE.CENTER_POS_X + 520 / 2, y = parts.pos.timeStampPosY + 65, w = 520, h = 30},
			}
		})
		-- プレイヤー名
		table.insert(parts.destination, {
			id = "playerName", dst = {
				{x = RESULT_BASE.CENTER_POS_X + 520 / 2, y = parts.pos.timeStampPosY + 25, w = 520, h = 30},
			}
		})
	end
end

-- ステージファイル表示（残りノート数に被せるかは検討）
local function showStageFile(parts)
	if PROPERTY.isStageFileOn() then
		local stageFile = {w = 280, h = 210}
		table.insert(parts.destination, {
			id = MAIN.IMAGE.STAGEFILE, op = {MAIN.OP.STAGEFILE}, dst = {
				{x = (1920 / 2) - (stageFile.w / 2), y = 120, w = stageFile.w, h = stageFile.h},
			}
		})
	end
end

-- 閉店時は残りノート数を表示
local function showRemainNotes(parts)
	table.insert(parts.image, {id = "remainNotesFrame", src = 6, x = 0, y = 600, w = 526, h = 126})
	-- あと○○ノート
	table.insert(parts.value, {
		id = "remainNotes", src = 4, x = 440, y = 276, w = 310, h = 36, divx = 10, digit = 5, align = 2, value = function()
			return main_state.number(MAIN.NUM.TOTALNOTES) - (main_state.number(MAIN.NUM.PERFECT) + main_state.number(MAIN.NUM.GREAT) + main_state.number(MAIN.NUM.GOOD) + main_state.number(MAIN.NUM.BAD) + main_state.number(MAIN.NUM.POOR))
		end,
	})
	table.insert(parts.destination, {
		id = "remainNotesFrame", draw = function()
			return CUSTOM.OP.isInTheMiddleFailed()
		end, dst = {
			{x = RESULT_BASE.CENTER_POS_X - 3, y = parts.pos.remainNotesFramePosY, w = 526, h = 126},
		}
	})
	table.insert(parts.destination, {
		id = "remainNotes", draw = function()
			return CUSTOM.OP.isInTheMiddleFailed()
		end, dst = {
			{time = 0, x = RESULT_BASE.CENTER_POS_X + 237, y = parts.pos.remainNotesFramePosY + 47, w = 30, h = 36},
			{time = 500, a = 150},
			{time = 1000, a = 255}
		}
	})
end

-- お気に入りボタンは通常リザルトのみで表示
local function favButton(parts)
	if parts.flg == 0 then
		table.insert(parts.image, {id = "chartBtn", src = 6, x = 0, y = 852, w = 330, h = 192, divy = 3, len = 3, ref = MAIN.BUTTON.FAVORITTE_CHART, act = MAIN.BUTTON.FAVORITTE_CHART})
		table.insert(parts.destination, {
			id = "chartBtn", dst = {
				{x = (1920 / 2) - (330 / 2), y = parts.pos.chartBtnPosY, w = 330, h = 64},
			}
		})
	end
end

-- コース途中は次の曲名を表示
local function nextSongInfo(parts)
	if parts.flg == 0 then
		table.insert(parts.image, {id = "nextStageFrame", src = 6, x = 0, y = 726, w = 526, h = 126})
		-- 現状STAGE4までしかオプションが反映されない（そのうち改善したい）
		for i = 1, 3, 1 do
			table.insert(parts.destination, {
				id = "nextStageFrame", op = {279 + i, -MAIN.OP.COURSE_STAGE_FINAL, MAIN.OP.MODE_COURSE, MAIN.OP.RESULT_CLEAR}, dst = {
					{x = RESULT_BASE.CENTER_POS_X - 3, y = parts.pos.nextStageFramePosY, w = 526, h = 126}
				}
			})
			table.insert(parts.destination, {
				id = "course" ..i + 1, op = {279 + i, -MAIN.OP.COURSE_STAGE_FINAL, MAIN.OP.MODE_COURSE, MAIN.OP.RESULT_CLEAR}, dst = {
					{x = RESULT_BASE.CENTER_POS_X + 10 + (500 / 2), y = parts.pos.nextStageFramePosY + 30, w = 500, h = 30},
					{time = 500, a = 200},
					{time = 1000, a = 255}
				}
			})
		end
	end
end

-- 背景キャラクター表示切り替えスイッチ
local function charDisplay(parts)
	if PROPERTY.isCharOn() then
		-- 表示スイッチ
		table.insert(parts.image, {id = "charswitch", src = 6, x = 560, y = 650, w = 60, h = 50, act = function()
			CUSTOM.OP.isCharDisplayOn = not CUSTOM.OP.isCharDisplayOn
		end})
		table.insert(parts.destination, {id = "charswitch", dst = {
			{time = 0, x = 1920 - 120, y = 0, w = 60, h = 50},
			{time = 2000, a = 100},
			{time = 4000, a = 255}
		}})
	end
end

local function load(flg)
	local parts = {}
	parts.flg = flg
	parts.pos = createBasePosition(flg)
	parts.image = {}
	parts.value = {
		{id = "year", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 4, ref = MAIN.NUM.TIME_YEAR, align = 0},
		{id = "month", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.TIME_MONTH, align = 0},
		{id = "day", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.TIME_DAY, align = 0},
		{id = "hour", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.TIME_HOUR, align = 0},
		{id = "min", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.TIME_MINUTE, align = 0},
		{id = "sec", src = 4, x = 440, y = 348, w = 341, h = 36, divx = 11, digit = 2, ref = MAIN.NUM.TIME_SECOND, align = 0},
	}
	parts.destination = {}
	timeStamp(parts)
	showStageFile(parts)
	showRemainNotes(parts)
	modeCategory(parts)
	favButton(parts)
	nextSongInfo(parts)
	charDisplay(parts)
	return parts
end

return {
	load = load
}