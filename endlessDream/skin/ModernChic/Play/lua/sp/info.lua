--[[
	プレイ情報部分
	@author : KASAKO
--]]

-- フレーム
local function frame(parts)
	table.insert(parts.image, {id = "infoTitleFrame", src = 2, x = 0, y = BASE.titleFramePosY, w = 1350, h = 46})
	table.insert(parts.image, {id = "infoFrame", src = 2, x = 0, y = 110, w = 1350, h = 811})
	-- タイトルフレーム
	table.insert(parts.destination,{
		id = "infoTitleFrame", dst = {
			{x = BASE.infoPositionX, y = 1026, w = 1350, h = 46},
		}
	})
	-- BGA,score,bpm,combo用フレーム
	table.insert(parts.destination,{
		id = "infoFrame", dst = {
			{x = BASE.infoPositionX, y = 209, w = 1350, h = 811},
		}
	})
end

-- タイトル、アーティスト、ジャンルループ
local function title(parts)
	-- 難易度によって色を変えてみる
	local RGB = COMMONFUNC.setRGB()
	-- 中央寄せ（align:1）なのでx値は中心位置
	if main_state.text(MAIN.STRING.TABLE_FULL) == "" then
		table.insert(parts.destination,	{
			id = "title", loop = 0, dst = {
				{time = 0, x = BASE.infoPositionX + BASE.topInfoPosX, y = 1033, w = 1040, h = 25, a = 0, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = 2000, a = 255},
				{time = 7000},
				{time = 9000, a = 0},
				{time = 27000}
			}
		})
		table.insert(parts.destination,	{
			id = "artist", loop = 0, dst = {
				{time = 9000, x = BASE.infoPositionX + BASE.topInfoPosX, y = 1033, w = 1040, h = 25, a = 0, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = 11000, a = 255},
				{time = 16000},
				{time = 18000, a = 0},
				{time = 27000}
			}
		})
		table.insert(parts.destination,	{
			id = "genre", loop = 0, dst = {
				{time = 18000, x = BASE.infoPositionX + BASE.topInfoPosX, y = 1033, w = 1040, h = 25, a = 0, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = 20000, a = 255},
				{time = 25000},
				{time = 27000, a = 0},
			}
		})
	else
		table.insert(parts.destination,	{
			id = "title", loop = 0, dst = {
				{time = 0, x = BASE.infoPositionX + BASE.topInfoPosX, y = 1033, w = 1040, h = 25, a = 0, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = 2000, a = 255},
				{time = 7000},
				{time = 9000, a = 0},
				{time = 36000}
			}
		})
		table.insert(parts.destination,	{
			id = "artist", loop = 0, dst = {
				{time = 9000, x = BASE.infoPositionX + BASE.topInfoPosX, y = 1033, w = 1040, h = 25, a = 0, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = 11000, a = 255},
				{time = 16000},
				{time = 18000, a = 0},
				{time = 36000}
			}
		})
		table.insert(parts.destination,	{
			id = "genre", loop = 0, dst = {
				{time = 18000, x = BASE.infoPositionX + BASE.topInfoPosX, y = 1033, w = 1040, h = 25, a = 0, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = 20000, a = 255},
				{time = 25000},
				{time = 27000, a = 0},
				{time = 36000},
			}
		})
		table.insert(parts.destination,	{
			id = "difftbl", loop = 0, dst = {
				{time = 27000, x = BASE.infoPositionX + BASE.topInfoPosX, y = 1033, w = 1040, h = 25, a = 0, r = RGB[1], g = RGB[2], b = RGB[3]},
				{time = 29000, a = 255},
				{time = 34000},
				{time = 36000, a = 0},
			}
		})
	end
end

-- 残り時間
local function remainTime(parts)
	table.insert(parts.value, {id = "min_time", src = 1, x = 1400, y = 81, w = 297, h = 20, divx = 11, divy = 1, digit = 2, ref = MAIN.NUM.TIMELEFT_MINUTE})
	table.insert(parts.value, {id = "sec_time", src = 1, x = 1400, y = 81, w = 297, h = 20, divx = 11, divy = 1, digit = 2, ref = MAIN.NUM.TIMELEFT_SECOND})
	table.insert(parts.destination,	{
		id = "min_time", draw = function() return not CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = BASE.infoPositionX + BASE.minPosX, y = 1031, w = 27, h = 20},
		}
	})
	table.insert(parts.destination,	{
		id = "sec_time", draw = function() return not CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = BASE.infoPositionX + BASE.secPosX, y = 1031, w = 27, h = 20},
		}
	})
	-- 残り時間が60秒を切ると色を変える
	table.insert(parts.destination,	{
		id = "min_time", draw = function() return CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = BASE.infoPositionX + BASE.minPosX, y = 1031, w = 27, h = 20, r = 253, g = 126, b = 0},
		}
	})
	table.insert(parts.destination,	{
		id = "sec_time", draw = function() return CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = BASE.infoPositionX + BASE.secPosX, y = 1031, w = 27, h = 20, r = 253, g = 126, b = 0},
		}
	})
end

-- スコア、コンボ
local function score(parts)
	table.insert(parts.value, {id = "maxcombo", src = 1, x = 0, y = 950, w = 308, h = 36, divx = 11, divy = 1, digit = 5, ref = MAIN.NUM.MAXCOMBO2})
	table.insert(parts.value, {id = "nowscore", src = 1, x = 0, y = 950, w = 308, h = 36, divx = 11, divy = 1, digit = 6, ref = MAIN.NUM.POINT, zeropadding = 1})
	table.insert(parts.value, {id = "nowexscore", src = 1, x = 1400, y = 101, w = 270, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.SCORE2, zeropadding = 1})
	table.insert(parts.destination,	{
		id = "maxcombo", dst = {
			{x = BASE.infoPositionX + 950, y = 222, w = 28, h = 36},
		}
	})
	-- 現在のスコア
	table.insert(parts.destination,	{
		id = "nowscore", dst = {
			{x = BASE.infoPositionX + 250, y = 222, w = 28, h = 36},
		}
	})
	if PROPERTY.isscoreNumberFlapSwitchOn() then
		-- スコアの数字ぐるぐる
		table.insert(parts.image, {id = "roulette_number_1", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, cycle = 100})
		table.insert(parts.image, {id = "roulette_number_2", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, cycle = 200})
		table.insert(parts.image, {id = "roulette_number_3", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, cycle = 400})
		local num = 8
		local timer = {MAIN.TIMER.BOMB_1P_SCRATCH, MAIN.TIMER.BOMB_1P_KEY1, MAIN.TIMER.BOMB_1P_KEY2, MAIN.TIMER.BOMB_1P_KEY3, MAIN.TIMER.BOMB_1P_KEY4, MAIN.TIMER.BOMB_1P_KEY5, MAIN.TIMER.BOMB_1P_KEY6, MAIN.TIMER.BOMB_1P_KEY7}
		local duration = 400
		for i = 1, num, 1 do
			-- 1桁目
			table.insert(parts.destination, {
				id = "roulette_number_1", timer = timer[i], loop = -1, dst = {
					{time = 0, x = BASE.infoPositionX + 390, y = 222, w = 28, h = 36},
					{time = duration}
				}
			})
			-- 2桁目
			table.insert(parts.destination, {
				id = "roulette_number_2", timer = timer[i], loop = -1, dst = {
					{time = 0, x = BASE.infoPositionX + 362, y = 222, w = 28, h = 36},
					{time = duration}
				}
			})
			-- 3桁目
			table.insert(parts.destination, {
				id = "roulette_number_3", timer = timer[i], loop = -1, dst = {
					{time = 0, x = BASE.infoPositionX + 334, y = 222, w = 28, h = 36},
					{time = duration}
				}
			})
		end
	end
end
-- BPM関連
local function bpm(parts)
	table.insert(parts.value, {id = "maxbpm", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM, align = MAIN.N_ALIGN.CENTER})
	table.insert(parts.value, {id = "nowbpm", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.NOWBPM, align = MAIN.N_ALIGN.CENTER})
	table.insert(parts.value, {id = "minbpm", src = 1, x = 0, y = 950, w = 280, h = 36, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM, align = MAIN.N_ALIGN.CENTER})
	table.insert(parts.destination,	{
		id = "maxbpm", op = {MAIN.OP.BPMCHANGE}, dst = {
			{x = BASE.infoPositionX + 763, y = 232, w = 21, h = 27},
		}
	})
	table.insert(parts.destination,	{
		id = "nowbpm", draw = not CUSTOM.OP.isMainBpm, dst = {
			{x = BASE.infoPositionX + 621, y = 232, w = 28, h = 36},
		}
	})
	table.insert(parts.destination,	{
		id = "nowbpm", draw = CUSTOM.OP.isMainBpm, dst = {
			{x = BASE.infoPositionX + 621, y = 232, w = 28, h = 36, r = 147, g = 204, b = 44},
		}
	})
	table.insert(parts.destination,	{
		id = "minbpm", op = {MAIN.OP.BPMCHANGE}, dst = {
			{x = BASE.infoPositionX + 507, y = 232, w = 21, h = 27},
		}
	})
end
-- BGA
local function bga(parts)
	if PROPERTY.isNoBGA() then
		-- soundonly画像
		table.insert(parts.destination,{
			id = "soundonly", op = {MAIN.OP.BGA}, timer = MAIN.TIMER.PLAY, blend = MAIN.BLEND.ADDITION, dst = {
				{x = BASE.infoPositionX + 376, y = 451, w = 600, h = 350}
			}
		})
	else
		local num
		local posX = {}
		local posY = {}
		local width
		local height
		if PROPERTY.isBgaPattern1_1() then
			num = 1
			posX = {316}
			posY = {290}
			width = 720
			height = 720
		elseif PROPERTY.isBgaPattern16_9() then
			num = 1
			posX = {36}
			posY = {290}
			width = 1280
			height = 720
		elseif PROPERTY.isBgaPattern1_1_x2() then
			num = 2
			posX = {43, 679}
			posY = {335, 335}
			width = 630
			height = 630
		elseif PROPERTY.isBgaPattern16_9_x4() then
			num = 4
			posX = {50, 679, 50, 679}
			posY = {297, 297, 652, 652}
			width = 624
			height = 351
		end
		-- 配置
		if PROPERTY.isBgaPattern16_9() then
			table.insert(parts.destination, {
				id = "bga", op = {MAIN.OP.BGA}, stretch = MAIN.STRETCH.FIT_OUTER_TRIMMED, dst = {
					{x = BASE.infoPositionX + 36, y = 290, w = 1280, h = 720, a = 100}
				}
			})
		end
		if PROPERTY.isBgaPattern16_9_x4() then
			for i = 1, num, 1 do
				table.insert(parts.destination, {
					id = "bga", op = {MAIN.OP.BGA}, stretch = MAIN.STRETCH.FIT_OUTER_TRIMMED, dst = {
						{x = BASE.infoPositionX + posX[i], y = posY[i], w = width, h = height, a = 100}
					}
				})
			end
		end
		for i = 1, num, 1 do
			table.insert(parts.destination, {
				id = "bga", op = {MAIN.OP.BGA}, dst = {
					{x = BASE.infoPositionX + posX[i], y = posY[i], w = width, h = height}
				}
			})
		end
	end
end
-- 汎用BGA
local function generalBGA(parts)
	if main_state.option(MAIN.OP.NO_BGA) and PROPERTY.isHanyoTypeMovie() then
		table.insert(parts.image,{
			id = "bga_hanyo", src = 23, x = 0, y = 0, w = 1280, h = 720
		})
		table.insert(parts.destination,	{
			id = "bga_hanyo", timer = MAIN.TIMER.PLAY, dst = {
				{x = BASE.infoPositionX + 36, y = 290, w = 1280, h = 720}
			}
		})
	elseif main_state.option(MAIN.OP.NO_BGA) and PROPERTY.isHanyoTypeImage() then
		table.insert(parts.image,{
			id = "bga_hanyo", src = 27, x = 0, y = 0, w = 1280, h = 720
		})
		table.insert(parts.destination,	{
			id = "bga_hanyo", timer = MAIN.TIMER.PLAY, dst = {
				{x = BASE.infoPositionX + 36, y = 290, w = 1280, h = 720}
			}
		})
	elseif main_state.option(MAIN.OP.NO_BGA) and PROPERTY.isHanyoDisable() then
		-- soundonly画像
		table.insert(parts.image, {id = "soundonly", src = 1, x = 570, y = 270, w = 600, h = 350})
		table.insert(parts.destination,{
			id = "soundonly", timer = MAIN.TIMER.PLAY, blend = MAIN.BLEND.ADDITION, dst = {
				{x = BASE.infoPositionX + 376, y = 451, w = 600, h = 350}
			}
		})
	end
end
-- BGA明るさ調整
local function bgaBrightness(parts)
	-- プレイ詳細時にはBGAを強制的に暗くさせる
	if PROPERTY.isDetailInfoSwitchOff() then
		table.insert(parts.destination,	{
			id = MAIN.IMAGE.BLACK, offsets = {PROPERTY.offsetBgaBrightness.num}, dst = {
				{x = BASE.infoPositionX + 36, y = 290, w = 1280, h = 720, a = 0},
			}
		})
	elseif PROPERTY.isDetailInfoSwitchOn() then
		table.insert(parts.destination, {
			id = MAIN.IMAGE.BLACK, timer = MAIN.TIMER.PLAY, dst = {
				{x = BASE.infoPositionX + 36, y = 290, w = 1280, h = 720, a = CONFIG.play.detailInfoAlfa},
			}
		})
	end
end
-- エフェクター
local function effecter(parts)
	table.insert(parts.image, {id = "effecter_frame", src = 1, x = 810, y = 1050, w = 308, h = 37})
	table.insert(parts.image, {id = "effecter_nonactive", src = 1, x = 600, y = 0, w = 227, h = 28})
	table.insert(parts.image, {id = "effecter_active", src = 1, x = 830, y = 0, w = 227, h = 28})
	table.insert(parts.image, {id = "btn-lnmode_nonactive", src = 1, x = 600, y = 28, w = 227, h = 84, divy = 3, len = 3, ref = MAIN.BUTTON.LNMODE})
	table.insert(parts.image, {id = "btn-lnmode_active", src = 1, x = 830, y = 28, w = 227, h = 84, divy = 3, len = 3, ref = MAIN.BUTTON.LNMODE})
	table.insert(parts.destination,	{
		id = "effecter_frame", dst = {
			{x = BASE.infoPositionX + 522, y = 279, w = 308, h = 37},
		}
	})
	if main_state.option(MAIN.OP.NO_LN) then
		table.insert(parts.destination,	{
			id = "effecter_nonactive", dst = {
				{x = BASE.infoPositionX + 563, y = 283, w = 227, h = 28}
			}
		})
		table.insert(parts.destination,	{
			id = "effecter_active", timer = MAIN.TIMER.RHYTHM, dst = {
				{time = 0, x = BASE.infoPositionX + 563, y = 283, w = 227, h = 28},
				{time = 1000, a = 50}
			}
		})
	elseif main_state.option(MAIN.OP.LN) then
		-- LNがある場合はエフェクターを変える
		table.insert(parts.destination,	{
			id = "btn-lnmode_nonactive", dst = {
				{x = BASE.infoPositionX + 563, y = 283, w = 227, h = 28}
			}
		})
		table.insert(parts.destination,	{
			id = "btn-lnmode_active", timer = MAIN.TIMER.RHYTHM, dst = {
				{time = 0, x = BASE.infoPositionX + 563, y = 283, w = 227, h = 28},
				{time = 1000, a = 50}
			}
		})
	end
end
-- 修飾
local function modification(parts)
	local num = 2
	local posX = {38, 1164}
	table.insert(parts.image, {id = "lamp_rhythm", src = 24, x = 0, y = 0, w = 152, h = 108})
	table.insert(parts.image, {id = "lamp_gaugeinclease", src = 24, x = 0, y = 0, w = 152, h = 216, divy = 2, cycle = 50, timer = MAIN.TIMER.GAUGE_INCLEASE_1P})
	table.insert(parts.image, {id = "lamp_maxgauge", src = 24, x = 0, y = 0, w = 152, h = 216, divy = 2, cycle = 50, timer = MAIN.TIMER.GAUGE_MAX_1P})
	for i = 1, num, 1 do
		table.insert(parts.destination,	{
			id = "lamp", dst = {
				{x = BASE.infoPositionX + posX[i], y = 180, w = 152, h = 108}
			}
		})
		-- 修飾（リズムタイマー）
		if PROPERTY.isGaugeMaxIndicatorOn() then
			table.insert(parts.destination,	{
				id = "lamp_rhythm", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.GAUGE_1P_100}, dst = {
					{time = 0, x = BASE.infoPositionX + posX[i], y = 180, w = 152, h = 108},
					{time = 1000, a = 150}
				}
			})
			-- 修飾(ゲージMAX)
			table.insert(parts.destination,	{
				id = "lamp_maxgauge", timer = MAIN.TIMER.GAUGE_MAX_1P, dst = {
					{x = BASE.infoPositionX + posX[i], y = 180, w = 152, h = 108}
				}
			})
		end
	end
end

-- 演奏時間を4つの区間に分けその区間での自スコアとライバルとの差分を表示していく機能
local function sectionScore(parts)
	if CONFIG.play.sectionScore.sw and main_state.option(MAIN.OP.AUTOPLAYOFF) and PROPERTY.isDetailInfoSwitchOff() then
		table.insert(parts.image, {id = "sectionFrame", src = 1, x = 1200, y = 1230, w = 330, h = 160})
		table.insert(parts.value, {id = "section1-4_score", src = 1, x = 1400, y = 101, w = 27 * 11, h = 40, divx = 11, divy = 2, digit = 4, value = function() return CUSTOM.NUM.sectionScore1_4()[1] end})
		table.insert(parts.value, {id = "section1-4_diff", src = 1, x = 1400, y = 121, w = 27 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore1_4()[2] end})
		table.insert(parts.value, {id = "section2-4_score", src = 1, x = 1400, y = 101, w = 27 * 11, h = 40, divx = 11, divy = 2, digit = 4, value = function() return CUSTOM.NUM.sectionScore2_4()[1] end})
		table.insert(parts.value, {id = "section2-4_diff", src = 1, x = 1400, y = 121, w = 27 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore2_4()[2] end})
		table.insert(parts.value, {id = "section3-4_score", src = 1, x = 1400, y = 101, w = 27 * 11, h = 40, divx = 11, divy = 2, digit = 4, value = function() return CUSTOM.NUM.sectionScore3_4()[1] end})
		table.insert(parts.value, {id = "section3-4_diff", src = 1, x = 1400, y = 121, w = 27 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore3_4()[2] end})
		table.insert(parts.value, {id = "section4-4_score", src = 1, x = 1400, y = 101, w = 27 * 11, h = 40, divx = 11, divy = 2, digit = 4, value = function() return CUSTOM.NUM.sectionScore4_4()[1] end})
		table.insert(parts.value, {id = "section4-4_diff", src = 1, x = 1400, y = 121, w = 27 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore4_4()[2] end})
		table.insert(parts.value, {id = "section1-4_min", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(1, 4)[1] end})
		table.insert(parts.value, {id = "section1-4_sec", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(1, 4)[2] end})
		table.insert(parts.value, {id = "section2-4_min", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(2, 4)[1] end})
		table.insert(parts.value, {id = "section2-4_sec", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(2, 4)[2] end})
		table.insert(parts.value, {id = "section3-4_min", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(3, 4)[1] end})
		table.insert(parts.value, {id = "section3-4_sec", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(3, 4)[2] end})
		table.insert(parts.value, {id = "section4-4_min", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(4, 4)[1] end})
		table.insert(parts.value, {id = "section4-4_sec", src = 1, x = 1400, y = 81, w = 27 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(4, 4)[2] end})
		table.insert(parts.destination, {id = "sectionFrame", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x, y = BASE.sectionScoreFrame.y, w = 330, h = 160},}})
		local num = 4
		local posY = BASE.sectionScoreFrame.y + 70
		for i = 1, num, 1 do
			table.insert(parts.destination, {id = "section" ..i .."-4_min", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 15, y = posY, w = 20, h = 20}}})
			table.insert(parts.destination, {id = "section" ..i .."-4_sec", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 65, y = posY, w = 20, h = 20}}})
			table.insert(parts.destination, {id = "section" ..i .."-4_score", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 130, y = posY, w = 20, h = 20}}})
			table.insert(parts.destination, {id = "section" ..i .."-4_diff", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 220, y = posY, w = 20, h = 20}}})
			posY = posY - 20
		end
		-- 経過グラフ
		table.insert(parts.graph, {id = "gra_section", src = 1, x = 0, y = 1, w = 1, h = 1, angle = MAIN.G_ANGLE.RIGHT, value = function() return CUSTOM.GRAPH.sectionRemainRate() end})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.fourFour.gFlg end, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 216, g = 27, b = 0}}})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.threeFour.gFlg end, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 255, g = 151, b = 0}}})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.twoFour.gFlg end, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 0, g = 178, b = 255}}})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.oneFour.gFlg end, dst = {{x = BASE.infoPositionX + BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 33, g = 251, b = 88}}})
		if CONFIG.play.sectionScore.sound.sw then
			CUSTOM.SOUND.initSectionSE()
			table.insert(parts.destination, {id = MAIN.IMAGE.BLACK, draw = function() return CUSTOM.SOUND.sectionScoreEffect() end, dst = {{x = 0, y = 0, w = 1, h = 1, a = 0}}})
		end
	end
end

local function charAnimation(parts)
	if CONFIG.bpmLinkChar.sw and PROPERTY.isDetailInfoSwitchOff() then
		local char = CUSTOM.FUNC.selectBpmLinkChar()
		table.insert(parts.source, {id = "char", path = "Root/image/" ..char ..".png"})
		table.insert(parts.image, {id = "char", src = "char", timer = MAIN.TIMER.PLAY, x = 0, y = 0, w = 400, h = 610, divx = 2, divy = 2, cycle = CUSTOM.NUM.oneBeat(4)})
		if CONFIG.bpmLinkChar.type == 1 then
			table.insert(parts.destination, {
				id = "char", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.NO_BPMCHANGE}, dst = {
					{time = 0, x = BASE.infoPositionX + BASE.charAnimation.x, y = BASE.charAnimation.y, w = 200, h = 305},
					{time = 500, y = BASE.charAnimation.y + 2},
					{time = 1000, y = BASE.charAnimation.y},
				}
			})
		elseif CONFIG.bpmLinkChar.type == 2 then
			table.insert(parts.destination, {
				id = "char", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.NO_BPMCHANGE}, dst = {
					{time = 0, x = BASE.infoPositionX + BASE.charAnimation.x, y = BASE.charAnimation.y, w = 200, h = 305},
					{time = 500, y = BASE.charAnimation.y + 2, h = 280},
					{time = 1000, x = BASE.infoPositionX + BASE.charAnimation.x + 200, y = BASE.charAnimation.y, w = -200, h = 305},
					{time = 1500, y = BASE.charAnimation.y + 2, h = 280},
					{time = 2000, x = BASE.infoPositionX + BASE.charAnimation.x, y = BASE.charAnimation.y, w = 200, h = 305}
				}
			})
		end
	end
end

local function load()
	local parts = {}
	parts.source = {}
	parts.image = {}
	parts.value = {}
	parts.graph = {}
	parts.destination = {}
	frame(parts)
	title(parts)
	remainTime(parts)
	score(parts)
	bpm(parts)
	bga(parts)
	generalBGA(parts)
	bgaBrightness(parts)
	effecter(parts)
	modification(parts)
	charAnimation(parts)
	sectionScore(parts)
	return parts
end

return {
	load = load
}