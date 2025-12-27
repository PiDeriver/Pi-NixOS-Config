--[[
    基準の作成
    @author : KASAKO
]]
local function createNotes(key)
	local m = {}
	if key == 5 then
		if PROPERTY.isLeftScratch() then
			m.KEY_POSITION = {114, 177, 228, 291, 342, 3}
		elseif PROPERTY.isRightScratch() then
			m.KEY_POSITION = {117, 180, 231, 294, 345, 408}
		end
	elseif key == 7 then
		if PROPERTY.isLeftScratch() then
			-- 左皿 S 1-7
			m.KEY_POSITION = {114, 177, 228, 291, 342, 405, 456, 3}
		elseif PROPERTY.isRightScratch() then
			-- 右皿 S 1-7
			m.KEY_POSITION = {3, 66, 117, 180, 231, 294, 345, 408}
		end
	end
	return m
end

local function createKeyflash(key)
	local m = {}
	m.normalWidth = 67
	m.normalHeight = 73
	m.scratchWidth = 92
	m.scratchHeight = 92
	if PROPERTY.isLeftScratch() then
		m.keyFramePosX = 111
		m.scratchFramePosX = 0
		m.scratchImagePosX = 10
	elseif PROPERTY.isRightScratch() then
		m.keyFramePosX = 0
		m.scratchFramePosX = 408
		m.scratchImagePosX = 418
	end
	if key == 5 then
		m.flashTimer = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5}
		if PROPERTY.isLeftScratch() then
			m.KEY_X = {110, 167, 224, 281, 338}
			m.KEY_Y = {137, 147, 137, 147, 137}
		elseif PROPERTY.isRightScratch() then
			m.KEY_X = {113, 170, 227, 284, 341}
			m.KEY_Y = {137, 147, 137, 147, 137}
		end
	elseif key == 7 then
		m.flashTimer = {MAIN.TIMER.KEYON_1P_KEY1, MAIN.TIMER.KEYON_1P_KEY2, MAIN.TIMER.KEYON_1P_KEY3, MAIN.TIMER.KEYON_1P_KEY4, MAIN.TIMER.KEYON_1P_KEY5, MAIN.TIMER.KEYON_1P_KEY6, MAIN.TIMER.KEYON_1P_KEY7}
		if PROPERTY.isLeftScratch() then
			m.KEY_X = {110, 167, 224, 281, 338, 395, 452}
			m.KEY_Y = {137, 147, 137, 147, 137, 147, 137}
		elseif PROPERTY.isRightScratch() then
			m.KEY_X = {-1, 56, 113, 170, 227, 284, 341}
			m.KEY_Y = {137, 147, 137, 147, 137, 147, 137}
		end
	end
	return m
end

local function createKeyCount(key)
	local m = {}
	if key == 5 then
		m.x = {}
		m.y = {200, 178, 200, 178, 200, 178}
		m.r = {255, 255,128,255,128,255}
		m.g = {128, 255,128,255,128,255}
		m.b = {128, 255,255,255,255,255}
		if PROPERTY.isLeftScratch() then
			m.x = {23, 109, 166, 223, 280, 337}
		elseif PROPERTY.isRightScratch() then
			m.x = {428, 114, 171, 228, 285, 342}
		end
	elseif key == 7 then
		m.x = {}
		m.y = {200, 178, 200, 178, 200, 178, 200, 178}
		m.r = {255, 255,128,255,128,255,128,255}
		m.g = {128, 255,128,255,128,255,128,255}
		m.b = {128, 255,255,255,255,255,255,255}
		if PROPERTY.isLeftScratch() then
			m.x = {23, 109, 166, 223, 280, 337, 394, 451}
		elseif PROPERTY.isRightScratch() then
			m.x = {428, 0, 57, 114, 171, 228, 285, 342}
		end
	end
	return m
end

local function createGauge()
	local m = {}
	m.POS_Y = 110
	m.PERFECT_COLOR = {147, 204, 44}
	if PROPERTY.isLeftScratch() then
		m.WIDTH = 400
		m.AFTERDOT_X = 503
		m.NUM_X = 415
		m.AFTERDOT_NUM_X = 513
		m.TYPE_X = 230
		m.POS_X = 11
		m.PS = "1P"
	elseif PROPERTY.isRightScratch() then
		-- ゲージ w値を-にすることで逆向きにできる
		m.WIDTH = -400
		m.AFTERDOT_X = 93
		m.NUM_X = 5
		m.AFTERDOT_NUM_X = 103
		m.TYPE_X = 144
		m.POS_X = 545
		m.PS = "2P"
	end
	return m
end


local module = {}
module.createBasePositionSP = function(key)
	local m = {}
	-- 判定基準点
	m.NOTES_JUDGE_Y = 227
	m.LANE_LENGTH = 853
	m.KEYFLASH = createKeyflash(key)
	m.NOTES = createNotes(key)
	m.KEYCOUNT = createKeyCount(key)
	m.GAUGE = createGauge()
	if PROPERTY.isLeftPosition() then
		m.playsidePositionX = 51
		m.infoPositionX = 570
		m.progressbarPositionX = 23
		m.gaugePositionX = 14
		m.titleFramePosY = 0
		m.topInfoPosX = 775
		m.minPosX = 100
		m.secPosX = 170
		m.sectionScoreFrame = {x = 30, y = 855}
		if CONFIG.bpmLinkChar.playside then m.charAnimation = {x = 80, y = 300} else m.charAnimation = {x = 1080, y = 300} end
	elseif PROPERTY.isRightPosition() then
		m.playsidePositionX = 1350
		m.infoPositionX = 0
		m.gaugePositionX = 1350
		m.progressbarPositionX = 1881
		m.titleFramePosY = 58
		m.topInfoPosX = 575
		m.minPosX = 1200
		m.secPosX = 1270
		m.sectionScoreFrame = {x = 990, y = 855}
		if CONFIG.bpmLinkChar.playside then m.charAnimation = {x = 1080, y = 300} else m.charAnimation = {x = 80, y = 300} end
	end
	if key == 5 then
		if PROPERTY.isLeftScratch() then
			m.FIVEKEY_COVER_POS_X = 405
			m.FIVEKEY_COVER_ANGLE = 180
		elseif PROPERTY.isRightScratch() then
			m.FIVEKEY_COVER_POS_X = 0
			m.FIVEKEY_COVER_ANGLE = 0
		end
	end
	return m
end

module.createBasePositionDP = function(key)
	local m = {}
	-- レーン基準
	if PROPERTY.isCenterPosition() then
		m.laneLeftPosX = 378
		m.subPosX = {10, 1580}
	elseif PROPERTY.isLeftPosition() then
		m.laneLeftPosX = 40
		m.subPosX = {1240, 1580}
	elseif PROPERTY.isRightPosition() then
		m.laneLeftPosX = 720
		m.subPosX = {10, 350}
	end
	m.laneRightPosX = m.laneLeftPosX + 645
	-- 判定基準
	m.NOTES_JUDGE_Y = 227
	m.LANE_LENGTH = 853
	if PROPERTY.isGraphPositionLeft() then
		m.sectionScoreFrame = {x = m.subPosX[2], y = 790}
		m.charAnimation = {x = m.subPosX[2] + 70, y = 290}
	elseif PROPERTY.isGraphPositionRight() then
		m.sectionScoreFrame = {x = m.subPosX[1], y = 790}
		m.charAnimation = {x = m.subPosX[2] + 70, y = 290}
	elseif PROPERTY.isGraphareaNone() then
		m.sectionScoreFrame = {x = m.subPosX[2], y = 790}
		m.charAnimation = {x = m.subPosX[2] + 70, y = 290}
	end
	return m
end

module.addSourceSP = function(skin)
	table.insert(skin.source, {id = 1, path = "Play/parts/sp_hw/system.png"})
	table.insert(skin.source, {id = 2, path = "Play/parts/sp_hw/info.png"})
	table.insert(skin.source, {id = 3, path = "Play/parts/common/bg/*.png"})
	table.insert(skin.source, {id = 4, path = "Play/parts/common/judge/*.png"})
	table.insert(skin.source, {id = 5, path = "Play/parts/common/judgeline/*.png"})
	table.insert(skin.source, {id = 6, path = "Play/parts/common/notes/*.png"})
	table.insert(skin.source, {id = 9, path = "Play/parts/common/glow/*.png"})
	table.insert(skin.source, {id = 10, path = "Play/parts/common/progress/*.png"})
	table.insert(skin.source, {id = 11, path = "Play/parts/common/bomb/*.png"})
	table.insert(skin.source, {id = 13, path = "Play/parts/common/fullcombo/*.png"})
	table.insert(skin.source, {id = 14, path = "Play/parts/common/keybeam/*.png"})
	table.insert(skin.source, {id = 15, path = "Play/parts/common/key/*.png"})
	table.insert(skin.source, {id = 16, path = "Play/parts/common/keyflash/*.png"})
	table.insert(skin.source, {id = 18, path = "Play/parts/sp_hw/lift/*.png"})
	table.insert(skin.source, {id = 20, path = "Play/parts/sp_hw/bga.png"})
	table.insert(skin.source, {id = 21, path = "Play/parts/common/close/close.png"})
	table.insert(skin.source, {id = 22, path = "Play/parts/sp_hw/score.png"})
	table.insert(skin.source, {id = 24, path = "Play/parts/common/lamp/*.png"})
	table.insert(skin.source, {id = 25, path = "Play/parts/sp_hw/graphbg/*.png"})
	table.insert(skin.source, {id = 26, path = "Play/parts/common/mine/#default.png"})
	table.insert(skin.source, {id = 28, path = "Play/parts/common/oadx_bomb/*.png"})
	table.insert(skin.source, {id = 29, path = "Play/parts/common/gauge/*.png"})
	table.insert(skin.source, {id = 30, path = "Play/parts/common/scratch/*.png"})
	table.insert(skin.source, {id = 31, path = "Play/parts/sp_hw/bgainfo.png"})
	table.insert(skin.source, {id = "hcnBomb", path = "Play/parts/common/hcn/hcn.png"})
	table.insert(skin.source, {id = "adjusted", path = "Play/parts/sp_hw/adjusted.png"})
	-- レーンカバー
	if PROPERTY.islanecoverRotationSwitchOff() then
		table.insert(skin.source, {id = 17, path = "Play/parts/common/lanecover/*.png"})
	elseif PROPERTY.islanecoverRotationSwitchOn() then
		table.insert(skin.source, {id = 17, path = CUSTOM.FUNC.randomChoiceStep1("Play/parts/common/lanecover/", "io/Play/sp/lanecover/", "Play.+%.png", true)})
	end
	-- 攻撃モーション
	if PROPERTY.isAttackModeOn() then
		table.insert(skin.source, {id = "parts_attack", path = "Play/parts/common/attack/attack.png"})
		table.insert(skin.source, {id = "parts_back", path = "Play/parts/common/attack/hud.png"})
	end
	-- BGA関連
	if main_state.option(MAIN.OP.NO_BGA) and PROPERTY.isHanyoTypeMovie() then
		table.insert(skin.source,{id = 23, path = "Play/parts/common/BGA/movie/*.mp4"})
	elseif main_state.option(MAIN.OP.NO_BGA) and PROPERTY.isHanyoTypeImage() then
		table.insert(skin.source,{id = 27, path = "Play/parts/common/BGA/image/*.png"})
	end
end

module.addSourceDP = function(skin)
	table.insert(skin.source, {id = 1, path = "Play/parts/dp_hw/system.png"})
	table.insert(skin.source, {id = 2, path = "Play/parts/dp_hw/lane.png"})
	table.insert(skin.source, {id = 3, path = "Play/parts/common/bg/*.png"})
	table.insert(skin.source, {id = 4, path = "Play/parts/common/judge/*.png"})
	table.insert(skin.source, {id = 5, path = "Play/parts/common/judgeline/*.png"})
	table.insert(skin.source, {id = 6, path = "Play/parts/common/notes/*.png"})
	table.insert(skin.source, {id = 9, path = "Play/parts/common/glow/*.png"})
	table.insert(skin.source, {id = 10, path = "Play/parts/common/progress/*.png"})
	table.insert(skin.source, {id = 11, path = "Play/parts/common/bomb/*.png"})
	table.insert(skin.source, {id = 13, path = "Play/parts/common/fullcombo/*.png"})
	table.insert(skin.source, {id = 14, path = "Play/parts/common/keybeam/*.png"})
	table.insert(skin.source, {id = 15, path = "Play/parts/common/key/*.png"})
	table.insert(skin.source, {id = 16, path = "Play/parts/common/keyflash/*.png"})
	table.insert(skin.source, {id = 19, path = "Play/parts/dp_hw/lift/*.png"})
	table.insert(skin.source, {id = 21, path = "Play/parts/common/close/close.png"})
	table.insert(skin.source, {id = 22, path = "Play/parts/dp_hw/score.png"})
	table.insert(skin.source, {id = 24, path = "Play/parts/common/lamp/*.png"})
	table.insert(skin.source, {id = 25, path = "Play/parts/dp_hw/graphbg/*.png"})
	table.insert(skin.source, {id = 26, path = "Play/parts/common/mine/#default.png"})
	table.insert(skin.source, {id = 28, path = "Play/parts/common/oadx_bomb/*.png"})
	table.insert(skin.source, {id = 29, path = "Play/parts/common/gauge/*.png"})
	table.insert(skin.source, {id = 30, path = "Play/parts/common/scratch/*.png"})
	table.insert(skin.source, {id = "hcnBomb", path = "Play/parts/common/hcn/hcn.png"})
	table.insert(skin.source, {id = "adjusted", path = "Play/parts/dp_hw/adjusted.png"})
	if PROPERTY.islanecoverRotationSwitchOff() then
		table.insert(skin.source, {id = 17, path = "Play/parts/common/lanecover/*.png"})
	elseif PROPERTY.islanecoverRotationSwitchOn() then
		table.insert(skin.source, {id = 17, path = CUSTOM.FUNC.randomChoiceStep1("Play/parts/common/lanecover/", "io/Play/dp/lanecover/", "Play.+%.png", true)})
		table.insert(skin.source, {id = 18, path = CUSTOM.FUNC.randomChoiceStep1("Play/parts/common/lanecover/", "io/Play/dp/lanecover/", "Play.+%.png", false)})
	end
end

return module