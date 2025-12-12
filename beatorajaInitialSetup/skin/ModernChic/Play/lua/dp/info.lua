--[[
	プレイ情報部分
	@author : KASAKO
--]]
local RGB = COMMONFUNC.setRGB()
local function mainFrame(parts)
	table.insert(parts.destination, {
		id = "centerFrame", dst = {
			{x = BASE.laneLeftPosX + 519, y = 180, w = 126, h = 900},
		}
	})
	table.insert(parts.destination, {
		id = "bottomFrame", dst = {
			{x = BASE.laneLeftPosX, y = 0, w = 1164, h = 180},
		}
	})
end
local function title(parts)
	-- タイトル
	local posx = BASE.subPosX[1]
	local posy = 969
	table.insert(parts.destination, {
		id = "titleFrame", dst = {
			{x = posx, y = posy, w = 331, h = 92},
		}
	})
	table.insert(parts.destination, {
		id = "title", loop = 0, dst = {
			{time = 0, x = (posx + 10) + 311 / 2, y = posy + 25, w = 311, h = 25, r = RGB[1], g = RGB[2], b = RGB[3], a = 0},
			{time = 2000, a = 255},
			{time = 7000},
			{time = 9000, a = 0},
			{time = 18000},
		}
	})
	table.insert(parts.destination, {
		id = "genre", loop = 0, dst = {
			{time = 9000, x = (posx + 10) + 311 / 2, y = posy + 25, w = 311, h = 25, r = RGB[1], g = RGB[2], b = RGB[3], a = 0},
			{time = 11000, a = 255},
			{time = 16000},
			{time = 18000, a = 0},
		}
	})
end
local function artist(parts)
	local posx = BASE.subPosX[2]
	local posy = 969
	table.insert(parts.destination, {
		id = "artistFrame", dst = {
			{x = posx, y = posy, w = 331, h = 92},
		}
	})
	table.insert(parts.destination, {
		id = "artist", dst = {
			{x = (posx + 10) + 311 / 2, y = posy + 25, w =  311, h = 25, r = RGB[1], g = RGB[2], b = RGB[3]},
		}
	})
end
local function information(parts)
	local posx = BASE.subPosX[2]
	local posy = 5
	table.insert(parts.destination, {
		id = "infoFrame", dst = {
			{x = posx, y = posy, w = 328, h = 225},
		}
	})
	-- 時間（残り時間60秒で色が変化）
	table.insert(parts.destination, {
		id = "min_time", draw = function() return not CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = posx + 82, y = posy + 200, w = 20, h = 20},
		}
	})
	table.insert(parts.destination, {
		id = "sec_time", draw = function() return not CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = posx + 140, y = posy + 200, w = 20, h = 20},
		}
	})
	table.insert(parts.destination, {
		id = "min_time", draw = function() return CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = posx + 82, y = posy + 200, w = 20, h = 20, r = 253, g = 126, b = 0},
		}
	})
	table.insert(parts.destination, {
		id = "sec_time", draw = function() return CUSTOM.OP.isRemainSec(60) end,
		dst = {
			{x = posx + 140, y = posy + 200, w = 20, h = 20, r = 253, g = 126, b = 0},
		}
	})
	-- 総ノート
	table.insert(parts.destination, {
		id = "totalNotes", dst = {
			{x = posx + 77, y = posy + 168, w = 20, h = 20},
		}
	})
	-- 判定カウンタ
	for i = 1, 13, 1 do
		local wd = {"pg","gr", "gr-early", "gr-late", "gd", "gd-early", "gd-late", "bd", "bd-early", "bd-late", "pr", "pr-early", "pr-late"}
		local adjustx = {77, 77, 160, 244, 77, 160, 244, 77, 160, 244, 77, 160, 244}
		local adjusty = {137, 106, 106, 106, 73, 73, 73, 41, 41, 41, 10, 10, 10}
		table.insert(parts.destination, {
			id = "count_"..wd[i], dst = {
				{x = posx + adjustx[i], y = posy + adjusty[i], w = 20, h = 20},
			}
		})
	end
end
local function bga(parts)
	if (PROPERTY.isRightPosition() or PROPERTY.isLeftPosition()) and PROPERTY.isGraphareaNone() then
		table.insert(parts.destination, {
			id = "bgaFrame1_1", dst = {
				{x = BASE.subPosX[1], y = 278, w = 670, h = 670},
			}
		})
		table.insert(parts.destination, {
			id = "bga", op = {-MAIN.OP.STATE_PRACTICE, MAIN.OP.LOADED}, stretch = MAIN.STRETCH.FIT_OUTER_TRIMMED, dst = {
				{x = BASE.subPosX[1] + 11, y = 289, w = 648, h = 648, a = 100},
			}
		})
		table.insert(parts.destination, {
			id = "bga", op = {-MAIN.OP.STATE_PRACTICE, MAIN.OP.LOADED}, dst = {
				{x = BASE.subPosX[1] + 11, y = 289, w = 648, h = 648},
			}
		})
		-- bgaなし
		table.insert(parts.destination, {
			id = "soundOnly1_1", op = {MAIN.OP.NO_BGA}, dst = {
				{time = 0, x = BASE.subPosX[1] + 11 + 162, y = 289 + 162, w = 324, h = 324},
				{time = 3000, a = 120},
				{time = 6000, a = 255}
			}
		})
		-- BGA明るさ調整
		table.insert(parts.destination,	{
			id = MAIN.IMAGE.BLACK, offsets = {PROPERTY.offsetBgaBrightness.num}, dst = {
				{x = BASE.subPosX[1] + 11, y = 289, w = 648, h = 648, a = 0},
			}
		})
	elseif PROPERTY.isBgaPattern16_9() then
		local posx = {BASE.subPosX[1], BASE.subPosX[1], BASE.subPosX[1], BASE.subPosX[2], BASE.subPosX[2], BASE.subPosX[2]}
		local posy = {760, 516, 272, 760, 516, 272}
		for i = 1, 6, 1 do
			table.insert(parts.destination, {
				id = "bgaFrame16_9", dst = {
					{x = posx[i], y = posy[i], w = 331, h = 191},
				}
			})
			table.insert(parts.destination, {
				id = "bga", op = {-MAIN.OP.STATE_PRACTICE, MAIN.OP.LOADED}, stretch = MAIN.STRETCH.FIT_OUTER_TRIMMED, dst = {
					{x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 181, a = 100},
				}
			})
			table.insert(parts.destination, {
				id = "bga", op = {-MAIN.OP.STATE_PRACTICE, MAIN.OP.LOADED}, dst = {
					{x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 181},
				}
			})
			-- bgaなし
			table.insert(parts.destination, {
				id = "soundOnly16_9", op = {MAIN.OP.NO_BGA}, dst = {
					{time = 0,x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 181},
					{time = 3000, a = 120},
					{time = 6000, a = 255}
				}
			})
			-- BGA明るさ調整
			table.insert(parts.destination,	{
				id = MAIN.IMAGE.BLACK, offsets = {PROPERTY.offsetBgaBrightness.num}, dst = {
					{x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 181, a = 0},
				}
			})
		end
	elseif PROPERTY.isBgaPattern1_1() then
		local posx = {BASE.subPosX[1], BASE.subPosX[1], BASE.subPosX[2], BASE.subPosX[2]}
		local posy = {620, 272, 620, 272}
		for i = 1, 4, 1 do
			table.insert(parts.destination, {
				id = "bgaFrame1_1", dst = {
					{x = posx[i], y = posy[i], w = 331, h = 331},
				}
			})
			table.insert(parts.destination, {
				id = "bga", op = {-MAIN.OP.STATE_PRACTICE, MAIN.OP.LOADED}, stretch = MAIN.STRETCH.FIT_OUTER_TRIMMED, dst = {
					{x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 321, a = 100},
				}
			})
			table.insert(parts.destination, {
				id = "bga", op = {-MAIN.OP.STATE_PRACTICE, MAIN.OP.LOADED}, dst = {
					{x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 321},
				}
			})
			-- bgaなし
			table.insert(parts.destination, {
				id = "soundOnly1_1", op = {MAIN.OP.NO_BGA}, dst = {
					{time = 0, x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 321},
					{time = 3000, a = 120},
					{time = 6000, a = 255}
				}
			})
			-- BGA明るさ調整
			table.insert(parts.destination,	{
				id = MAIN.IMAGE.BLACK, offsets = {PROPERTY.offsetBgaBrightness.num}, dst = {
					{x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 321, a = 0},
				}
			})
		end
	elseif PROPERTY.isNoBGA() then
		local posx = {BASE.subPosX[1], BASE.subPosX[1], BASE.subPosX[2], BASE.subPosX[2]}
		local posy = {620, 272, 620, 272}
		for i = 1, 4, 1 do
			table.insert(parts.destination, {
				id = "bgaFrame1_1", dst = {
					{x = posx[i], y = posy[i], w = 331, h = 331},
				}
			})
			table.insert(parts.destination, {
				id = "soundOnly1_1", dst = {
					{time = 0, x = posx[i] + 5, y = posy[i] + 5, w = 321, h = 321},
					{time = 3000, a = 120},
					{time = 6000, a = 255}
				}
			})
		end
	end
end
local function effector(parts)
	if main_state.option(MAIN.OP.NO_LN) then
		table.insert(parts.destination,	{
			id = "effecter_nonactive", dst = {
				{x = BASE.laneLeftPosX + 470, y = 6, w = 227, h = 28}
			}
		})
		table.insert(parts.destination,	{
			id = "effecter_active", timer = MAIN.TIMER.RHYTHM, dst = {
				{time = 0, x = BASE.laneLeftPosX + 470, y = 6, w = 227, h = 28},
				{time = 1000, a = 50}
			}
		})
	elseif main_state.option(MAIN.OP.LN) then
		table.insert(parts.destination,	{
			id = "btn-lnmode_nonactive", dst = {
				{x = BASE.laneLeftPosX + 470, y = 6, w = 227, h = 28}
			}
		})
		table.insert(parts.destination,	{
			id = "btn-lnmode_active", timer = MAIN.TIMER.RHYTHM, dst = {
				{time = 0, x = BASE.laneLeftPosX + 470, y = 6, w = 227, h = 28},
				{time = 1000, a = 50}
			}
		})
	end
end
local function lamp(parts)
	-- 修飾
	local num = 2
	local posx = {BASE.laneLeftPosX - 18, BASE.laneLeftPosX + 1008}
	local posy = 0
	for i = 1, num, 1 do
		table.insert(parts.destination,	{
			id = "lamp", dst = {
				{x = posx[i], y = posy, w = 152, h = 108}
			}
		})
		-- 修飾（リズムタイマー）
		if PROPERTY.isGaugeMaxIndicatorOn() then
			table.insert(parts.destination,	{
				id = "lamp_rhythm", timer = MAIN.TIMER.RHYTHM, op = {-MAIN.OP.GAUGE_1P_100}, dst = {
					{time = 0, x = posx[i], y = posy, w = 152, h = 108},
					{time = 1000, a = 150}
				}
			})
			-- 修飾(ゲージMAX)
			table.insert(parts.destination,	{
				id = "lamp_maxgauge", timer = MAIN.TIMER.GAUGE_MAX_1P, dst = {
					{x = posx[i], y = posy, w = 152, h = 108}
				}
			})
		end
	end
end
local function level(parts)
	local wd = {"biginner", "normal", "hyper", "another", "insame", "unknown"}
	local op = {MAIN.OP.DIFFICULTY1, MAIN.OP.DIFFICULTY2, MAIN.OP.DIFFICULTY3, MAIN.OP.DIFFICULTY4, MAIN.OP.DIFFICULTY5, MAIN.OP.DIFFICULTY0}
	for i = 1, 6, 1 do
		table.insert(parts.destination, {
			id = "lev_"..wd[i], op = {op[i]}, dst = {
				{x = BASE.laneLeftPosX + 22, y = 117, w = 165, h = 20}
			}
		})
	end
	table.insert(parts.destination, {
		id = "playlevel", dst = {
			{x = BASE.laneLeftPosX + 257, y = 119, w = 24, h = 20},
		}
	})
end
local function useOption(parts)
	local wd = {"Assist", "Easy", "Normal", "Hard", "ExHard", "Hazard", "StandardGrade", "ExGrade", "ExHardGrade"}
	for i = 1, 9, 1 do
		table.insert(parts.destination, {
			id = "gauge"..wd[i], draw = function()
				return main_state.gauge_type() == i - 1
			end,
			dst = {
				{x = BASE.laneLeftPosX + 846, y = 145, w = 155, h = 20},
			}
		})
	end
	table.insert(parts.destination, {
		id = "useOptionLeft", dst = {
			{x = BASE.laneLeftPosX + 852, y = 117, w = 130, h = 20},
		}
	})
	table.insert(parts.destination, {
		id = "useOptionRight", dst = {
			{x = BASE.laneLeftPosX + 1002, y = 117, w = 130, h = 20},
		}
	})
end
local function songInformation(parts)
	-- 現在のスコア
	table.insert(parts.destination, {
		id = "nowscore", dst = {
			{x = BASE.laneLeftPosX + 162, y = 39, w = 30, h = 40},
		}
	})
	-- 最大コンボ
	table.insert(parts.destination, {
		id = "maxcombo", dst = {
			{x = BASE.laneLeftPosX + 814, y = 39, w = 30, h = 40},
		}
	})
	-- BPM
	table.insert(parts.destination, {
		id = "minbpm", op = {MAIN.OP.BPMCHANGE}, dst = {
			{x = BASE.laneLeftPosX + 412, y = 58, w = 21, h = 40},
		}
	})
	table.insert(parts.destination, {
		id = "nowbpm", dst = {
			{x = BASE.laneLeftPosX + 524, y = 63, w = 30, h = 40},
		}
	})
	table.insert(parts.destination, {
		id = "maxbpm", op = {MAIN.OP.BPMCHANGE}, dst = {
			{x = BASE.laneLeftPosX + 670, y = 58, w = 21, h = 40},
		}
	})
end


-- 演奏時間を4つの区間に分けその区間での自スコアとライバルとの差分を表示していく機能 960->940     940-960
local function sectionScore(parts)
	if CONFIG.play.sectionScore.sw and main_state.option(MAIN.OP.AUTOPLAYOFF) then
		table.insert(parts.image, {id = "sectionFrame", src = 1, x = 350, y = 1270, w = 330, h = 160})
		table.insert(parts.value, {id = "section1-4_score", src = 1, x = 720, y = 960, w = 24 * 11, h = 20, divx = 11, digit = 4, value = function() return CUSTOM.NUM.sectionScore1_4()[1] end})
		table.insert(parts.value, {id = "section1-4_diff", src = 1, x = 720, y = 980, w = 24 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore1_4()[2] end})
		table.insert(parts.value, {id = "section2-4_score", src = 1, x = 720, y = 960, w = 24 * 11, h = 40, divx = 11, divy = 2, digit = 4, value = function() return CUSTOM.NUM.sectionScore2_4()[1] end})
		table.insert(parts.value, {id = "section2-4_diff", src = 1, x = 720, y = 980, w = 24 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore2_4()[2] end})
		table.insert(parts.value, {id = "section3-4_score", src = 1, x = 720, y = 960, w = 24 * 11, h = 40, divx = 11, divy = 2, digit = 4, value = function() return CUSTOM.NUM.sectionScore3_4()[1] end})
		table.insert(parts.value, {id = "section3-4_diff", src = 1, x = 720, y = 980, w = 24 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore3_4()[2] end})
		table.insert(parts.value, {id = "section4-4_score", src = 1, x = 720, y = 960, w = 24 * 11, h = 40, divx = 11, divy = 2, digit = 4, value = function() return CUSTOM.NUM.sectionScore4_4()[1] end})
		table.insert(parts.value, {id = "section4-4_diff", src = 1, x = 720, y = 980, w = 24 * 12, h = 40, divx = 12, divy = 2, digit = 5, value = function() return CUSTOM.NUM.sectionScore4_4()[2] end})
		table.insert(parts.value, {id = "section1-4_min", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(1, 4)[1] end})
		table.insert(parts.value, {id = "section1-4_sec", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(1, 4)[2] end})
		table.insert(parts.value, {id = "section2-4_min", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(2, 4)[1] end})
		table.insert(parts.value, {id = "section2-4_sec", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(2, 4)[2] end})
		table.insert(parts.value, {id = "section3-4_min", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(3, 4)[1] end})
		table.insert(parts.value, {id = "section3-4_sec", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(3, 4)[2] end})
		table.insert(parts.value, {id = "section4-4_min", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(4, 4)[1] end})
		table.insert(parts.value, {id = "section4-4_sec", src = 1, x = 720, y = 940, w = 24 * 11, h = 20, divx = 11, digit = 2, value = function() return CUSTOM.NUM.sectionTime(4, 4)[2] end})
		table.insert(parts.destination, {id = "sectionFrame", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.sectionScoreFrame.x, y = BASE.sectionScoreFrame.y, w = 330, h = 160},}})
		local num = 4
		local posY = BASE.sectionScoreFrame.y + 70
		for i = 1, num, 1 do
			table.insert(parts.destination, {id = "section" ..i .."-4_min", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.sectionScoreFrame.x + 15, y = posY, w = 20, h = 20}}})
			table.insert(parts.destination, {id = "section" ..i .."-4_sec", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.sectionScoreFrame.x + 65, y = posY, w = 20, h = 20}}})
			table.insert(parts.destination, {id = "section" ..i .."-4_score", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.sectionScoreFrame.x + 130, y = posY, w = 20, h = 20}}})
			table.insert(parts.destination, {id = "section" ..i .."-4_diff", timer = MAIN.TIMER.PLAY, dst = {{x = BASE.sectionScoreFrame.x + 220, y = posY, w = 20, h = 20}}})
			posY = posY - 20
		end
		-- 経過グラフ
		table.insert(parts.graph, {id = "gra_section", src = 1, x = 0, y = 910, w = 1, h = 1, angle = MAIN.G_ANGLE.RIGHT, value = function() return CUSTOM.GRAPH.sectionRemainRate() end})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.fourFour.gFlg end, dst = {{x = BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 216, g = 27, b = 0}}})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.threeFour.gFlg end, dst = {{x = BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 255, g = 151, b = 0}}})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.twoFour.gFlg end, dst = {{x = BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 0, g = 178, b = 255}}})
		table.insert(parts.destination, {id = "gra_section", timer = MAIN.TIMER.PLAY, draw = function() return CUSTOM.sectionScore.oneFour.gFlg end, dst = {{x = BASE.sectionScoreFrame.x + 3, y = BASE.sectionScoreFrame.y + 3, w = 324, h = 5, r = 33, g = 251, b = 88}}})
		if CONFIG.play.sectionScore.sound.sw then
			CUSTOM.SOUND.initSectionSE()
			table.insert(parts.destination, {id = MAIN.IMAGE.BLACK, draw = function() return CUSTOM.SOUND.sectionScoreEffect() end, dst = {{x = 0, y = 0, w = 1, h = 1, a = 0}}})
		end
	end
end

local function charAnimation(parts)
	if CONFIG.bpmLinkChar.sw then
		local char = CUSTOM.FUNC.selectBpmLinkChar()
		table.insert(parts.source, {id = "char", path = "Root/image/" ..char ..".png"})
		table.insert(parts.image, {id = "char", src = "char", timer = MAIN.TIMER.PLAY, x = 0, y = 0, w = 400, h = 610, divx = 2, divy = 2, cycle = CUSTOM.NUM.oneBeat(4)})
		if CONFIG.bpmLinkChar.type == 1 then
			table.insert(parts.destination, {
				id = "char", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.NO_BPMCHANGE}, dst = {
					{time = 0, x = BASE.charAnimation.x, y = BASE.charAnimation.y, w = 200, h = 305},
					{time = 500, y = BASE.charAnimation.y + 2},
					{time = 1000, y = BASE.charAnimation.y}
				}
			})
		elseif CONFIG.bpmLinkChar.type == 2 then
			table.insert(parts.destination, {
				id = "char", timer = MAIN.TIMER.RHYTHM, op = {MAIN.OP.NO_BPMCHANGE}, dst = {
					{time = 0, x = BASE.charAnimation.x, y = BASE.charAnimation.y, w = 200, h = 305},
					{time = 500, y = 292, h = 280},
					{time = 1000, x = BASE.charAnimation.x + 200, y = BASE.charAnimation.y + 2, w = -200, h = 305},
					{time = 1500, y = BASE.charAnimation.y, h = 280},
					{time = 2000, x = BASE.charAnimation.x, y = BASE.charAnimation.y + 2, w = 200, h = 305}
				}
			})
		end
	end
end

local function load()
	local parts = {}
	parts.source = {}
	
	parts.image = {
		{id = "centerFrame", src = 1, x = 0, y = 0, w = 8, h = 900},
		{id = "bottomFrame", src = 1, x = 30, y = 758, w = 1164, h = 180},
		{id = "titleFrame", src = 1, x = 30, y = 20, w = 331, h = 92},
		{id = "artistFrame", src = 1, x = 30, y = 120, w = 331, h = 92},
		{id = "infoFrame", src = 1, x = 380, y = 20, w = 328, h = 225},

		{id = "bgaFrame1_1", src = 1, x = 30, y = 220, w = 331, h = 331},
		{id = "bgaFrame16_9", src = 1, x = 30, y = 560, w = 331, h = 191},

		{id = "soundOnly1_1", src = 1, x = 1100, y = 1140, w = 321, h = 321},
		{id = "soundOnly16_9", src = 1, x = 1100, y = 1208, w = 321, h = 181},
		
		-- SoundOnly
--		{id = "soundonly", src = 1, x = 570, y = 270, w = 600, h = 350},
		
		-- エフェクター
		{id = "effecter_nonactive", src = 1, x = 380, y = 560, w = 227, h = 28},
		{id = "effecter_active", src = 1, x = 610, y = 560, w = 227, h = 28},
		--LNタイプ
		{id = "btn-lnmode_nonactive", src = 1, x = 380, y = 588, w = 227, h = 84, divy = 3, len = 3, ref = MAIN.BUTTON.LNMODE},
		{id = "btn-lnmode_active", src = 1, x = 610, y = 588, w = 227, h = 84, divy = 3, len = 3, ref = MAIN.BUTTON.LNMODE},
		
		-- 修飾
		{id = "lamp_rhythm", src = 24, x = 0, y = 0, w = 152, h = 108},
		{id = "lamp_gaugeinclease", src = 24, x = 0, y = 0, w = 152, h = 216, divy = 2, cycle = 50, timer = MAIN.TIMER.GAUGE_INCLEASE_1P},
		{id = "lamp_maxgauge", src = 24, x = 0, y = 0, w = 152, h = 216, divy = 2, cycle = 50, timer = MAIN.TIMER.GAUGE_MAX_1P},
--		{id = "lamp_maxgauge", src = 24, x = 0, y = 0, w = 152, h = 108, timer = MAIN.TIMER.GAUGE_MAX_1P},

		-- 難易度画像
		{id = "lev_biginner", src = 1, x = 30, y = 940, w = 165, h = 20},
		{id = "lev_normal", src = 1, x = 30, y = 960, w = 165, h = 20},
		{id = "lev_hyper", src = 1, x = 30, y = 980, w = 165, h = 20},
		{id = "lev_another", src = 1, x = 30, y = 1000, w = 165, h = 20},
		{id = "lev_insame", src = 1, x = 30, y = 1020, w = 165, h = 20},
		{id = "lev_unknown", src = 1, x = 30, y = 1040, w = 165, h = 20},

		-- 使用オプション
		{id = "gaugeAssist", src = 1, x = 195, y = 940, w = 155, h = 20},
		{id = "gaugeEasy", src = 1, x = 195, y = 960, w = 155, h = 20},
		{id = "gaugeNormal", src = 1, x = 195, y = 980, w = 155, h = 20},
		{id = "gaugeHard", src = 1, x = 195, y = 1000, w = 155, h = 20},
		{id = "gaugeExHard", src = 1, x = 195, y = 1020, w = 155, h = 20},
		{id = "gaugeHazard", src = 1, x = 195, y = 1040, w = 155, h = 20},
		{id = "gaugeStandardGrade", src = 1, x = 380, y = 940, w = 155, h = 20},
		{id = "gaugeExGrade", src = 1, x = 380, y = 960, w = 155, h = 20},
		{id = "gaugeExHardGrade", src = 1, x = 380, y = 980, w = 155, h = 20},
		{id = "useOptionLeft", src = 1, x = 590, y = 940, w = 130, h = 200, divy = 10, len = 10, ref = MAIN.BUTTON.RANDOM_1P},
		{id = "useOptionRight", src = 1, x = 590, y = 940, w = 130, h = 200, divy = 10, len = 10, ref = MAIN.BUTTON.RANDOM_2P},
	}
	
	parts.value = {
		-- 現在のスコア
		{id = "nowscore", src = 1, x = 1008, y = 940, w = 330, h = 40, divx = 11, divy = 1, digit = 6, ref = MAIN.NUM.POINT, zeropadding = MAIN.N_ZEROPADDING.ON},
		-- 現在の最大コンボ数
		{id = "maxcombo", src = 1, x = 1008, y = 940, w = 330, h = 40, divx = 11, divy = 1, digit = 5, ref = MAIN.NUM.MAXCOMBO2},
		-- 現在のEXスコア
		{id = "nowexscore", src = 1, x = 1008, y = 940, w = 330, h = 40, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.SCORE2, zeropadding = MAIN.N_ZEROPADDING.ON},
		
		-- 最大BPM
		{id = "maxbpm", src = 1, x = 1008, y = 980, w = 210, h = 40, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MAXBPM, align = MAIN.N_ALIGN.CENTER},
		-- 現在のBPM
		{id = "nowbpm", src = 1, x = 1008, y = 940, w = 300, h = 40, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.NOWBPM, align = MAIN.N_ALIGN.CENTER},
		-- 最小BPM
		{id = "minbpm", src = 1, x = 1008, y = 980, w = 210, h = 40, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.MINBPM, align = MAIN.N_ALIGN.CENTER},
		-- 残り時間
		{id = "min_time", src = 1, x = 720, y = 940, w = 264, h = 20, divx = 11, divy = 1, digit = 2, ref = MAIN.NUM.TIMELEFT_MINUTE},
		{id = "sec_time", src = 1, x = 720, y = 940, w = 264, h = 20, divx = 11, divy = 1, digit = 2, ref = MAIN.NUM.TIMELEFT_SECOND},
		-- 譜面レベル
		{id = "playlevel", src = 1, x = 720, y = 940, w = 264, h = 20, divx = 11, divy = 1, digit = 2, ref = MAIN.NUM.PLAYLEVEL},
		-- 総ノート
		{id = "totalNotes", src = 1, x = 720, y = 940, w = 240, h = 20, divx = 10, divy = 1, digit = 4, ref = MAIN.NUM.TOTALNOTES, align = MAIN.N_ALIGN.LEFT},
		-- PG数
		{id = "count_pg", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.PERFECT, align = MAIN.N_ALIGN.RIGHT},
		-- great数
		{id = "count_gr", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.GREAT, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_gr-early", src = 1, x = 720, y = 1100, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_GREAT, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_gr-late", src = 1, x = 720, y = 1120, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_GREAT, align = MAIN.N_ALIGN.RIGHT},
		-- good数
		{id = "count_gd", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.GOOD, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_gd-early", src = 1, x = 720, y = 1100, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_GOOD, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_gd-late", src = 1, x = 720, y = 1120, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_GOOD, align = MAIN.N_ALIGN.RIGHT},
		-- bad数
		{id = "count_bd", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.BAD, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_bd-early", src = 1, x = 720, y = 1100, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_BAD, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_bd-late", src = 1, x = 720, y = 1120, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_BAD, align = MAIN.N_ALIGN.RIGHT},
		-- poor数
		{id = "count_pr", src = 1, x = 720, y = 960, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.POOR, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_pr-early", src = 1, x = 720, y = 1100, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.EARLY_POOR, align = MAIN.N_ALIGN.RIGHT},
		{id = "count_pr-late", src = 1, x = 720, y = 1120, w = 264, h = 20, divx = 11, divy = 1, digit = 4, ref = MAIN.NUM.LATE_POOR, align = MAIN.N_ALIGN.RIGHT},
	}
	parts.graph = {}
	parts.destination = {}
	mainFrame(parts)
	title(parts)
	artist(parts)
	information(parts)
	bga(parts)
	effector(parts)
	lamp(parts)
	level(parts)
	useOption(parts)
	songInformation(parts)
	charAnimation(parts)
	sectionScore(parts)
	return parts
end

return {
	load = load
}