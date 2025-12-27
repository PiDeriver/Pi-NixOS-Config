--[[
	サイドメニュー
	@author : KASAKO
]]
local function irLoading(isLampMenuOpen, isRankingMenuOpen)
	local song = main_state.option(MAIN.OP.SONGBAR)
	local grade = main_state.option(MAIN.OP.GRADEBAR)
	local waiting = main_state.option(MAIN.OP.IR_WAITING)
	local online = main_state.option(MAIN.OP.ONLINE)
	return ((isLampMenuOpen == true) or (isRankingMenuOpen == true)) and (waiting == true) and (online == true) and ((grade == true) or (song == true))
end
local function irOffline(isLampMenuOpen, isRankingMenuOpen)
	local loading = main_state.option(MAIN.OP.OFFLINE)
	return ((isLampMenuOpen == true) or (isRankingMenuOpen == true)) and loading == true
end

local sFunc = require("Select.lua.require.settings")
local function load()
	local parts = {}

	-- メニュー開閉状態
	local isLampMenuOpen
	local isRankingMenuOpen
	local isVolumeMenuOpen
	local isSettingMenuOpen

	if PROPERTY.isSideMenuRetentionOff() then
		isLampMenuOpen = false
		isRankingMenuOpen = false
		isVolumeMenuOpen = false
		isSettingMenuOpen = false
	elseif PROPERTY.isSideMenuRetentionOn() then
		-- 設定読み込み
		local settings = sFunc.loadingSettings()
		isLampMenuOpen = sFunc.toboolean(settings.isLampMenuOpen)
		isRankingMenuOpen = sFunc.toboolean(settings.isRankingMenuOpen)
		isVolumeMenuOpen = sFunc.toboolean(settings.isVolumeMenuOpen)
		isSettingMenuOpen = sFunc.toboolean(settings.isSettingMenuOpen)
	end

	-- メニュー開閉
	local function rampMenuSwitch()
		isLampMenuOpen = not isLampMenuOpen
		isRankingMenuOpen = false
		isVolumeMenuOpen = false
		isSettingMenuOpen = false
		if PROPERTY.isSideMenuRetentionOn() then
			sFunc.saveSettings(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
		end
		CUSTOM.SOUND.windowMotionSound(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
	end
	local function rankingMenuSwitch()
		isLampMenuOpen = false
		isRankingMenuOpen = not isRankingMenuOpen
		isVolumeMenuOpen = false
		isSettingMenuOpen = false
		if PROPERTY.isSideMenuRetentionOn() then
			sFunc.saveSettings(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
		end
		CUSTOM.SOUND.windowMotionSound(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
	end
	local function volumeMenuSwitch()
		isLampMenuOpen = false
		isRankingMenuOpen = false
		isVolumeMenuOpen = not isVolumeMenuOpen
		isSettingMenuOpen = false
		if PROPERTY.isSideMenuRetentionOn() then
			sFunc.saveSettings(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
		end
		CUSTOM.SOUND.windowMotionSound(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
	end
	local function settingMenuSwitch()
		isLampMenuOpen = false
		isRankingMenuOpen = false
		isVolumeMenuOpen = false
		isSettingMenuOpen = not isSettingMenuOpen
		if PROPERTY.isSideMenuRetentionOn() then
			sFunc.saveSettings(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
		end
		CUSTOM.SOUND.windowMotionSound(isLampMenuOpen, isRankingMenuOpen, isVolumeMenuOpen, isSettingMenuOpen)
	end

	-- 基準点
	local posX = 80
	local posY = 228
	local openTime = 200
	
	parts.image = {
		{id = "s_menu", src = 11, x = 0, y = 0, w = 930, h = 636},
		{id = "s_ramp", src = 11, x = 0, y = 640, w = 694, h = 603},
		{id = "s_rampName", src = 11, x = 700, y = 640, w = 245, h = 603},
		{id = "s_percentFrame", src = 11, x = 950, y = 640, w = 120, h = 603},
		{id = "s_selector", src = 11, x = 1000, y = 100, w = 70, h = 469},
		{id = "s_volumeFrame", src = 11, x = 1500, y = 0, w = 930, h = 635},
		{id = "s_masterVolumeMin", src = 11, x = 2436, y = 72, w = 64, h = 61},
		{id = "s_keyVolumeMin", src = 11, x = 2436, y = 72, w = 64, h = 61},
		{id = "s_bgmVolumeMin", src = 11, x = 2436, y = 72, w = 64, h = 61},
		{id = "s_masterVolumeMax", src = 11, x = 2436, y = 133, w = 64, h = 61},
		{id = "s_keyVolumeMax", src = 11, x = 2436, y = 133, w = 64, h = 61},
		{id = "s_bgmVolumeMax", src = 11, x = 2436, y = 133, w = 64, h = 61},
		{id = "s_masterVolumeMinRect", src = 11, x = 2436, y = 194, w = 64, h = 61, act = function() main_state.set_volume_sys(0) end},
		{id = "s_keyVolumeMinRect", src = 11, x = 2436, y = 194, w = 64, h = 61, act = function() main_state.set_volume_key(0) end},
		{id = "s_bgmVolumeMinRect", src = 11, x = 2436, y = 194, w = 64, h = 61, act = function() main_state.set_volume_bg(0) end},
		{id = "s_masterVolumeMaxRect", src = 11, x = 2436, y = 255, w = 64, h = 61, act = function() main_state.set_volume_sys(1) end},
		{id = "s_keyVolumeMaxRect", src = 11, x = 2436, y = 255, w = 64, h = 61, act = function() main_state.set_volume_key(1) end},
		{id = "s_bgmVolumeMaxRect", src = 11, x = 2436, y = 255, w = 64, h = 61, act = function() main_state.set_volume_bg(1) end},
		-- IR読込中
		{id = "s_loading", src = 11, x = 1500, y = 1000, w = 1248, h = 200, divx = 4, cycle = 2000},
		{id = "s_loadingWd", src = 11, x = 1500, y = 1400, w = 750, h = 130},
		-- IR接続不可
		{id = "s_offline", src = 11, x = 1500, y = 1200, w = 624, h = 200, divx = 2, cycle = 1000},
		{id = "s_offlineWd", src = 11, x = 1500, y = 1530, w = 750, h = 130},
		-- ランキング用
		{id = "s_rankingFrame", src = 11, x = 1500, y = 640, w = 930, h = 64},
		{id = "s_rankingFrame2", src = 11, x = 1500, y = 704, w = 930, h = 25},
		{id = "s_rankingMyPostion", src = 11, x = 1500, y = 1660, w = 936, h = 140, divy = 2, cycle = 100},
		{id = "s_rankingScrollFrame", src = 7, x = 980, y = 0, w = 28, h = 636},
		-- クリアランプ（ランキング表示用）
		{id = "s_NoPlay", src = 9, x = 500, y = 170, w = 110, h = 22},
		{id = "s_Failed", src = 9, x = 500, y = 192, w = 110, h = 22},
		{id = "s_LaEasy", src = 9, x = 500, y = 214, w = 110, h = 22},
		{id = "s_Clear", src = 9, x = 500, y = 236, w = 110, h = 22},
		{id = "s_Easy", src = 9, x = 500, y = 258, w = 110, h = 22},
		{id = "s_FullCombo", src = 9, x = 500, y = 280, w = 330, h = 22, divx = 3, cycle = 300},
		{id = "s_HardClear", src = 9, x = 500, y = 302, w = 110, h = 22},
		{id = "s_ExHard", src = 9, x = 500, y = 324, w = 220, h = 22, divx = 2, cycle = 200},
		{id = "s_Perfect", src = 9, x = 500, y = 346, w = 110, h = 22},
		{id = "s_Max", src = 9, x = 500, y = 368, w = 110, h = 22},
		{id = "s_Assist", src = 9, x = 500, y = 390, w = 110, h = 22},
		-- 設定メニュー用
		{id = "s_wdSettingsMenu", src = 11, x = 2500, y = 0, w = 610, h = 36},
		{id = "s_wdAutoSaveReplaySettings", src = 11, x = 2500, y = 36, w = 610, h = 36},
		{id = "s_btn", src = 11, x = 2500, y = 72, w = 231, h = 61},
		{id = "s_btnSelected", src = 11, x = 2500, y = 132, w = 231, h = 122, divy = 2, cycle = 200},
		{id = "s_btnRect", src = 11, x = 2500, y = 132, w = 231, h = 61},
		{id = "s_wdKeyconfig", src = 11, x = 2731, y = 72, w = 231, h = 61, act = MAIN.BUTTON.KEYCONFIG},
		{id = "s_wdSkinChange", src = 11, x = 2731, y = 133, w = 231, h = 61, act = MAIN.BUTTON.SKINSELECT},
		{id = "s_wdIrpageOpen", src = 11, x = 2731, y = 194, w = 231, h = 61, act = MAIN.BUTTON.OPEN_IR_WEBSITE},
		{id = "s_wdIrpageOpenNg", src = 11, x = 2731, y = 255, w = 231, h = 61},
	}

	-- リプレイデータ詳細
	do
		local replayRef = {MAIN.BUTTON.AUTOSAVEREPLAY_1, MAIN.BUTTON.AUTOSAVEREPLAY_2, MAIN.BUTTON.AUTOSAVEREPLAY_3, MAIN.BUTTON.AUTOSAVEREPLAY_4}
		local replayAct = {MAIN.BUTTON.REPLAY, MAIN.BUTTON.REPLAY2, MAIN.BUTTON.REPLAY3, MAIN.BUTTON.REPLAY4}
		local posY = {72, 133, 194, 255}
		for i = 1, 4, 1 do
			table.insert(parts.image, {
				id = "s_autoReplaySetting" ..i, src = 11, x = 2962, y = 72, w = 231, h = 671, divy = 11, len = 11, ref = replayRef[i], act = replayRef[i]
			})
			table.insert(parts.image, {
				id = "s_autoReplayOn" ..i, src = 11, x = 3193, y = posY[i], w = 231, h = 61, act = replayAct[i]
			})
			table.insert(parts.image, {
				id = "s_autoReplayOff" ..i, src = 11, x = 3424, y = posY[i], w = 231, h = 61
			})
		end
	end

	-- ランプアイコン
	table.insert(parts.image, {id = "s_rampButtonOff", src = 11, x = 700, y = 1250, w = 62, h = 62})
	table.insert(parts.image, {id = "s_rampButtonRect", src = 11, x = 762, y = 1250, w = 62, h = 62, act = function() return rampMenuSwitch() end})
	table.insert(parts.image, {id = "s_rampButtonOn", src = 11, x = 762, y = 1250, w = 62, h = 62, act = function() return rampMenuSwitch() end})
	-- ランキングアイコン
	table.insert(parts.image, {id = "s_rankingButtonOff", src = 11, x = 700, y = 1312, w = 62, h = 62})
	table.insert(parts.image, {id = "s_rankingButtonRect", src = 11, x = 762, y = 1312, w = 62, h = 62, act = function() return rankingMenuSwitch() end})
	table.insert(parts.image, {id = "s_rankingButtonOn", src = 11, x = 762, y = 1312, w = 62, h = 62, act = function() return rankingMenuSwitch() end})
	-- ランキングアイコン
	table.insert(parts.image, {id = "s_volumeButtonOff", src = 11, x = 700, y = 1374, w = 62, h = 62})
	table.insert(parts.image, {id = "s_volumeButtonRect", src = 11, x = 762, y = 1374, w = 62, h = 62, act = function() return volumeMenuSwitch() end})
	table.insert(parts.image, {id = "s_volumeButtonOn", src = 11, x = 762, y = 1374, w = 62, h = 62, act = function() return volumeMenuSwitch() end})
	-- 設定アイコン
	table.insert(parts.image, {id = "s_settingButtonOff", src = 11, x = 700, y = 1436, w = 62, h = 62})
	table.insert(parts.image, {id = "s_settingButtonRect", src = 11, x = 762, y = 1436, w = 62, h = 62, act = function() return settingMenuSwitch() end})
	table.insert(parts.image, {id = "s_settingButtonOn", src = 11, x = 762, y = 1436, w = 62, h = 62, act = function() return settingMenuSwitch() end})

	parts.imageset = {}
	do
		-- TOP10のクリア状況
		local ref = {
			MAIN.NUM.RANKING1_CLEAR,
			MAIN.NUM.RANKING2_CLEAR,
			MAIN.NUM.RANKING3_CLEAR,
			MAIN.NUM.RANKING4_CLEAR,
			MAIN.NUM.RANKING5_CLEAR,
			MAIN.NUM.RANKING6_CLEAR,
			MAIN.NUM.RANKING7_CLEAR,
			MAIN.NUM.RANKING8_CLEAR,
			MAIN.NUM.RANKING9_CLEAR,
			MAIN.NUM.RANKING10_CLEAR
		}
		for i = 1, 10, 1 do
			table.insert(parts.imageset,{
				id = "s_clearTypeIr"..i, ref = ref[i], images = {"s_NoPlay", "s_Failed", "s_Assist", "s_LaEasy", "s_Easy", "s_Clear", "s_HardClear", "s_ExHard", "s_FullCombo", "s_Perfect", "s_Perfect"}
			})
		end
	end
	
	-- align:0,1,2 右、左、中央
	parts.value = {
		-- メイン音量数値
		{id = "s_masterVolumeNum", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, value = function()
			return CUSTOM.NUM.masterVolumeNum()
		end,
	},
	-- キー音量数値
	{id = "s_keyVolumeNum", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, value = function()
			return CUSTOM.NUM.keyVolumeNum()
		end,
	},
	-- キー音量数値
	{id = "s_bgmVolumeNum", src = 5, x = 2401, y = 510, w = 242, h = 15, divx = 11, digit = 3, value = function()
			return CUSTOM.NUM.bgmVolumeNum()
		end,
	},
	}
	parts.slider = {
		{id = "s_masterVolume",  src  = 5,  x  = 2610,  y  = 800,  w  = 15,  h  = 39,  type  = MAIN.SLIDER.MASTER_VOLUME,  range  = 385,  angle  = MAIN.S_ANGLE.RIGHT,  changeable  = true},
		{id = "s_keyVolume",  src  = 5,  x  = 2610,  y  = 800,  w  = 15,  h  = 39,  type  = MAIN.SLIDER.KEY_VOLUME,  range  = 385,  angle  = MAIN.S_ANGLE.RIGHT,  changeable  = true},
		{id = "s_bgmVolume",  src  = 5,  x  = 2610,  y  = 800,  w  = 15,  h  = 39,  type  = MAIN.SLIDER.BGM_VOLUME,  range  = 385,  angle  = MAIN.S_ANGLE.RIGHT,  changeable  = true},
		-- typeは8
		{id = "s_rankingScrollLamp", src = 7, x = 1010, y = 45, w = 35, h = 45, type = 8, range = 600, angle = MAIN.S_ANGLE.DOWN, changeable = true}
	}
	parts.graph = {}
	parts.destination = {}

	-- セレクターとボタン
	table.insert(parts.destination, {
		id = "s_selector", loop = 1500, dst = {
			{time = 1300, x = -72, y = 380, w = 70, h = 469, acc = MAIN.ACC.DECELERATE},
			{time = 1500, x = -2}
		}
	})
	table.insert(parts.destination, {
		id = "s_rampButtonOff", timer = timer_util.timer_observe_boolean(function() return not isLampMenuOpen end), dst = {
			{x = 2, y = 710, w = 62, h = 62},
		}
	})
	table.insert(parts.destination, {
		id = "s_rampButtonRect", timer = timer_util.timer_observe_boolean(function() return not isLampMenuOpen end), dst = {
			{x = 2, y = 710, w = 62, h = 62},
		}, mouseRect = {x = 0, y = 0, w = 62, h = 62}
	})
	table.insert(parts.destination, {
		id = "s_rampButtonOn", timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), dst = {
			{x = 2, y = 710, w = 62, h = 62},
		}
	})

	table.insert(parts.destination, {
		id = "s_rankingButtonOff", timer = timer_util.timer_observe_boolean(function() return not isRankingMenuOpen end), dst = {
			{x = 2, y = 630, w = 62, h = 62},
		}
	})
	table.insert(parts.destination, {
		id = "s_rankingButtonRect", timer = timer_util.timer_observe_boolean(function() return not isRankingMenuOpen end), dst = {
			{x = 2, y = 630, w = 62, h = 62},
		}, mouseRect = {x = 0, y = 0, w = 62, h = 62}
	})
	table.insert(parts.destination, {
		id = "s_rankingButtonOn", timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
			{x = 2, y = 630, w = 62, h = 62},
		}
	})

	table.insert(parts.destination, {
		id = "s_volumeButtonOff", timer = timer_util.timer_observe_boolean(function() return not isVolumeMenuOpen end), dst = {
			{x = 2, y = 550, w = 62, h = 62},
		}
	})
	table.insert(parts.destination, {
		id = "s_volumeButtonRect", timer = timer_util.timer_observe_boolean(function() return not isVolumeMenuOpen end), dst = {
			{x = 2, y = 550, w = 62, h = 62},
		}, mouseRect = {x = 0, y = 0, w = 62, h = 62}
	})
	table.insert(parts.destination, {
		id = "s_volumeButtonOn", timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{x = 2, y = 550, w = 62, h = 62},
		}
	})

	table.insert(parts.destination, {
		id = "s_settingButtonOff", timer = timer_util.timer_observe_boolean(function() return not isSettingMenuOpen end), dst = {
			{x = 2, y = 470, w = 62, h = 62},
		}
	})
	table.insert(parts.destination, {
		id = "s_settingButtonRect", timer = timer_util.timer_observe_boolean(function() return not isSettingMenuOpen end), dst = {
			{x = 2, y = 470, w = 62, h = 62},
		}, mouseRect = {x = 0, y = 0, w = 62, h = 62}
	})
	table.insert(parts.destination, {
		id = "s_settingButtonOn", timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
			{x = 2, y = 470, w = 62, h = 62},
		}
	})

	-- フレーム
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), dst = {
			{time = 0, x = -930, y = 228, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = posX}
		}
	})
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return not isLampMenuOpen end), dst = {
			{time = 0, x = -posX, y = 228, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = -930}
		}
	})
	table.insert(parts.destination, {
		id = "s_ramp", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), dst = {
			{time = openTime, x = posX + 200, y = 246, w = 694, h = 603},
		}
	})

	do
		-- 人数系
		local wd = {"max", "perfect", "fullcombo", "exHard", "hard", "normal", "easy", "assist", "lightAssist", "failed", "noPlay"}
		local ref = {
			MAIN.NUM.IR_PLAYER_MAX,
			MAIN.NUM.IR_PLAYER_PERFECT,
			MAIN.NUM.IR_PLAYER_FULLCOMBO,
			MAIN.NUM.IR_PLAYER_EXHARD,
			MAIN.NUM.IR_PLAYER_HARD,
			MAIN.NUM.IR_PLAYER_NORMAL,
			MAIN.NUM.IR_PLAYER_EASY,
			MAIN.NUM.IR_PLAYER_ASSIST,
			MAIN.NUM.IR_PLAYER_LIGHTASSIST,
			MAIN.NUM.IR_PLAYER_FAILED,
			MAIN.NUM.IR_PLAYER_NOPLAY
		}
		-- 自身のクリア条件と一致するか
		local op = {
			MAIN.OP.SELECT_BAR_MAX_CLEARED,
			MAIN.OP.SELECT_BAR_PERFECT_CLEARED,
			MAIN.OP.SELECT_BAR_FULL_COMBO_CLEARED,
			MAIN.OP.SELECT_BAR_EXHARD_CLEARED,
			MAIN.OP.SELECT_BAR_HARD_CLEARED,
			MAIN.OP.SELECT_BAR_NORMAL_CLEARED,
			MAIN.OP.SELECT_BAR_EASY_CLEARED,
			MAIN.OP.SELECT_BAR_ASSIST_EASY_CLEARED,
			MAIN.OP.SELECT_BAR_LIGHT_ASSIST_EASY_CLEARED,
			MAIN.OP.SELECT_BAR_FAILED,
			MAIN.OP.SELECT_BAR_NOT_PLAYED
		}

		local posY = 805
		for i = 1, 11, 1 do
			table.insert(parts.value, {
				id = "s_" ..wd[i] .."num", src = 11, x = 1000, y = 0, w = 341, h = 36, divx = 11, digit = 5, ref = ref[i], align = 0
			})
		end
		for i = 1, 11, 1 do
			table.insert(parts.destination, {
				id = "s_" ..wd[i] .."num", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), draw = function()
					if main_state.option(op[i]) == true then
						return true
					else
						return false
					end
				end, dst = {
					{time = openTime, x = posX + 20, y = posY, w = 31, h = 36, r = 255, g = 161, b = 3},
				}
			})
			table.insert(parts.destination, {
				id = "s_" ..wd[i] .."num", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), draw = function()
					if main_state.option(op[i]) == false then
						return true
					else
						return false
					end
				end, dst = {
					{time = openTime, x = posX + 20, y = posY, w = 31, h = 36},
				}
			})
			posY = posY - 55
		end
	end

	do
		-- IR全体のクリア状況
		local graphLenght = 690
		local wd = {"max", "perfect", "fullcombo", "exhard", "hard", "normal", "easy", "assist", "lassist", "failed", "noplay"}
		local val = {
			MAIN.NUM.IR_PLAYER_MAX_RATE,
			MAIN.NUM.IR_PLAYER_PERFECT_RATE,
			MAIN.NUM.IR_PLAYER_FULLCOMBO_RATE,
			MAIN.NUM.IR_PLAYER_EXHARD_RATE,
			MAIN.NUM.IR_PLAYER_HARD_RATE,
			MAIN.NUM.IR_PLAYER_NORMAL_RATE,
			MAIN.NUM.IR_PLAYER_EASY_RATE,
			MAIN.NUM.IR_PLAYER_ASSIST_RATE,
			MAIN.NUM.IR_PLAYER_LIGHTASSIST_RATE,
			MAIN.NUM.IR_PLAYER_FAILED_RATE,
			MAIN.NUM.IR_PLAYER_NOPLAY_RATE
		}
		local posY = 1250
		-- グラフバーの登録
		for i = 1, 11, 1 do
			table.insert(parts.graph, {
				id = "s_bar" ..wd[i], src = 11, x = 0, y = posY, w = graphLenght, h = 49, angle = MAIN.S_ANGLE.UP, value = function()
					local rate = main_state.number(val[i])
					if rate == -2147483648 then
						return 0
					else
						-- 1は100％を表す
						return rate / 100
					end
				end
			})
			posY = posY + 49
		end
		-- グラフ描画
		local dstPosY = 798
		for i = 1, 11, 1 do
			table.insert(parts.destination, {
				id = "s_bar" ..wd[i], blend = MAIN.BLEND.ADDITION, loop = 500, timer = timer_util.timer_observe_boolean(function() return CUSTOM.OP.isTimerOn(MAIN.TIMER.IR_CONNECT_SUCCESS) and isLampMenuOpen == true end), dst = {
					{time = openTime, x = posX + 202, y = dstPosY, w = 0, h = 49, acc = MAIN.ACC.DECELERATE},
					{time = 500, w = 690}
				}
			})
			dstPosY = dstPosY - 55
		end
	end

	-- クリア状況-------------------------------------------------------------------------
	table.insert(parts.destination, {
		id = "s_rampName", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), dst = {
			{time = openTime, x = posX + 400, y = 246, w = 245, h = 603},
		}
	})
	table.insert(parts.destination, {
		id = "s_percentFrame", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), dst = {
			{time = openTime, x = posX + 773, y = 246, w = 120, h = 603},
		}
	})
	
	do
		-- 自身のクリア条件と一致するか
		local op = {
			MAIN.OP.SELECT_BAR_MAX_CLEARED,
			MAIN.OP.SELECT_BAR_PERFECT_CLEARED,
			MAIN.OP.SELECT_BAR_FULL_COMBO_CLEARED,
			MAIN.OP.SELECT_BAR_EXHARD_CLEARED,
			MAIN.OP.SELECT_BAR_HARD_CLEARED,
			MAIN.OP.SELECT_BAR_NORMAL_CLEARED,
			MAIN.OP.SELECT_BAR_EASY_CLEARED,
			MAIN.OP.SELECT_BAR_ASSIST_EASY_CLEARED,
			MAIN.OP.SELECT_BAR_LIGHT_ASSIST_EASY_CLEARED,
			MAIN.OP.SELECT_BAR_FAILED,
			MAIN.OP.SELECT_BAR_NOT_PLAYED
		}
		do
			-- レート系
			local wd = {"max", "perfect", "fullcombo", "exHard", "hard", "normal", "easy", "assist", "lightAssist", "failed", "noPlay"}
			local ref = {
				MAIN.NUM.IR_PLAYER_MAX_RATE,
				MAIN.NUM.IR_PLAYER_PERFECT_RATE,
				MAIN.NUM.IR_PLAYER_FULLCOMBO_RATE,
				MAIN.NUM.IR_PLAYER_EXHARD_RATE,
				MAIN.NUM.IR_PLAYER_HARD_RATE,
				MAIN.NUM.IR_PLAYER_NORMAL_RATE,
				MAIN.NUM.IR_PLAYER_EASY_RATE,
				MAIN.NUM.IR_PLAYER_ASSIST_RATE,
				MAIN.NUM.IR_PLAYER_LIGHTASSIST_RATE,
				MAIN.NUM.IR_PLAYER_FAILED_RATE,
				MAIN.NUM.IR_PLAYER_NOPLAY_RATE
			}
			for i = 1, 11, 1 do
				table.insert(parts.value, {
					id = "s_" ..wd[i] .."rate", src = 11, x = 1000, y = 0, w = 310, h = 36, divx = 10, digit = 3, ref = ref[i], align = 0
				})
			end
			local posY = 804
			for i = 1, 11, 1 do
				table.insert(parts.destination, {
					id = "s_" ..wd[i] .."rate", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), draw = function()
						if main_state.option(op[i]) == true then
							return true
						else
							return false
						end
					end, dst = {
						{time = openTime, x = posX + 692, y = posY, w = 31, h = 36, r = 255, g = 161, b = 3},
					}
				})
				table.insert(parts.destination, {
					id = "s_" ..wd[i] .."rate", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), draw = function()
						if main_state.option(op[i]) == false then
							return true
						else
							return false
						end
					end, dst = {
						{time = openTime, x = posX + 692, y = posY, w = 31, h = 36},
					}
				})
				posY = posY - 55
			end
		end
		do
			-- レート系（小数点）
			local wd = {"max", "perfect", "fullcombo", "exHard", "hard", "normal", "easy", "assist", "lightAssist", "failed", "noPlay"}
			local ref = {
				MAIN.NUM.IR_PLAYER_MAX_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_PERFECT_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_FULLCOMBO_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_EXHARD_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_HARD_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_NORMAL_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_EASY_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_ASSIST_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_LIGHTASSIST_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_FAILED_RATE_AFTERDOT,
				MAIN.NUM.IR_PLAYER_NOPLAY_RATE_AFTERDOT
			}
			for i = 1, 11, 1 do
				table.insert(parts.value, {
					id = "s_" ..wd[i] .."rateAfterdot", src = 11, x = 1000, y = 0, w = 310, h = 36, divx = 10, digit = 1, ref = ref[i], align = 0
				})
			end
			local posY = 804
			for i = 1, 11, 1 do
				table.insert(parts.destination, {
					id = "s_" ..wd[i] .."rateAfterdot", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), draw = function()
						if main_state.option(op[i]) == true then
							return true
						else
							return false
						end
					end, dst = {
						{time = openTime, x = posX + 792, y = posY, w = 31, h = 36, r = 255, g = 161, b = 3},
					}
				})
				table.insert(parts.destination, {
					id = "s_" ..wd[i] .."rateAfterdot", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isLampMenuOpen end), draw = function()
						if main_state.option(op[i]) == false then
							return true
						else
							return false
						end
					end, dst = {
						{time = openTime, x = posX + 792, y = posY, w = 31, h = 36},
					}
				})
				posY = posY - 55
			end
		end
	end

	-- ランキング-----------------------------------------------------------------------
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
			{time = 0, x = -930, y = 228, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = posX}
		}
	})
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return not isRankingMenuOpen end), dst = {
			{time = 0, x = -posX, y = 228, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = -930}
		}
	})
	-- IR用スクロールバー
	table.insert(parts.destination, {
		id = "s_rankingScrollFrame", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
			{time = openTime, x = posX + 930, y = 228, w = 28, h = 636},
		}
	})
	table.insert(parts.destination, {
		id = "s_rankingScrollLamp", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
			{time = openTime, x = posX + 927, y = 823, w = 35, h = 45},
			{time = openTime + 1000, a = 150},
			{time = openTime + 2000, a = 255}
		}
	})
	-- 順位イメージ
	do
		local val = {
			MAIN.NUM.RANKING1_INDEX,
			MAIN.NUM.RANKING2_INDEX,
			MAIN.NUM.RANKING3_INDEX,
			MAIN.NUM.RANKING4_INDEX,
			MAIN.NUM.RANKING5_INDEX,
			MAIN.NUM.RANKING6_INDEX,
			MAIN.NUM.RANKING7_INDEX,
			MAIN.NUM.RANKING8_INDEX,
			MAIN.NUM.RANKING9_INDEX,
			MAIN.NUM.RANKING10_INDEX,
		}
		for i = 1, 10, 1 do
			table.insert(parts.value, {
				id = "s_ranking" ..i, src = 11, x = 1000, y = 0, w = 341, h = 36, divx = 11, digit = 5, ref = val[i], align = MAIN.N_ALIGN.RIGHT
			})
		end
	end
	-- クリアランク
	do
		local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
		local y = {530, 552, 574, 596, 618, 640, 662, 684}
		for i = 1, 8, 1 do
			table.insert(parts.image, {
				id = "s_"..wd[i], src = 9, x = 500, y = y[i], w = 59, h = 22
			})
		end
	end
	-- グラフ
	do
		local val = {
			MAIN.NUM.RANKING1_EXSCORE,
			MAIN.NUM.RANKING2_EXSCORE,
			MAIN.NUM.RANKING3_EXSCORE,
			MAIN.NUM.RANKING4_EXSCORE,
			MAIN.NUM.RANKING5_EXSCORE,
			MAIN.NUM.RANKING6_EXSCORE,
			MAIN.NUM.RANKING7_EXSCORE,
			MAIN.NUM.RANKING8_EXSCORE,
			MAIN.NUM.RANKING9_EXSCORE,
			MAIN.NUM.RANKING10_EXSCORE
		}
		local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
		local posY = 800
		for i = 1, 10, 1 do
			local graphPosY = 729
			-- exスコアグラフ
			for j = 1, 8, 1 do
				-- 各ランクのグラフ準備
				table.insert(parts.graph, {
					id = "s_rankingGraph" ..wd[j] ..i, src = 11, x = 1500, y = graphPosY, w = 916, h = 21, angle = MAIN.S_ANGLE.UP, value = function()
						local score = main_state.number(val[i])
						-- トータルノート数 * 2
						local maxscore = CUSTOM.NUM.maxExscore()
						if score == -2147483648 then
							return 0
						else
							return score / maxscore
						end
					end
				})
				graphPosY = graphPosY + 21
			end
			-- exスコア
			table.insert(parts.value, {
				id = "s_exscore" ..i, src = 11, x = 1000, y = 0, w = 341, h = 36, divx = 11, digit = 5, ref = val[i], align = MAIN.N_ALIGN.RIGHT
			})
		end

		-- 配置
		for i = 1, 10, 1 do
			-- フレーム
			table.insert(parts.destination, {
				id = "s_rankingFrame", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
					{time = openTime, x = posX, y = posY, w = 930, h = 64},
				}
			})
			-- グラフ部
			do
				local refRate = {100, 88.8, 77.7, 66.6, 55.5, 44.4, 33.3, 22.2, -1}
				local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
				for j = 1, 8, 1 do
					table.insert(parts.destination, {
						id = "s_rankingGraph" ..wd[j] ..i, loop = 500, timer = timer_util.timer_observe_boolean(function() return CUSTOM.OP.isTimerOn(MAIN.TIMER.IR_CONNECT_SUCCESS) and isRankingMenuOpen == true end), draw = function()
							-- exスコアを取得
							local exScore = main_state.number(379 + i)
							-- 最大exスコアを取得
							local maxExScore = CUSTOM.NUM.maxExscore()
							local rankRate = (exScore / maxExScore) * 100
							return main_state.option(MAIN.OP.ONLINE) and rankRate <= refRate[j] and rankRate > refRate[j + 1]
						end, dst = {
							{time = openTime, x = posX + 7, y = posY + 2, w = 0, h = 21, acc = MAIN.ACC.DECELERATE},
							{time = 500, x = posX + 7, y = posY + 2, w = 916, h = 21},
						}
					})
				end
			end
			-- ランク
			table.insert(parts.destination, {
				id = "s_rankingFrame2", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
					{time = openTime, x = posX, y = posY, w = 930, h = 25, a = 150},
				}
			})
			-- 順位
			table.insert(parts.destination, {
				id = "s_ranking" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
					{time = openTime, x = posX + 20, y = posY + 30, w = 20, h = 24, a = 201, g = 255, b = 9},
				}
			})
			-- 名前
			table.insert(parts.destination, {
				id = "s_irRankName" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), draw = function()
					return not CUSTOM.OP.isMyFrame(i)
				end, dst = {
					{time = openTime, x = posX + 170, y = posY + 26, w = 300, h = 25},
				}
			})
			table.insert(parts.destination, {
				id = "s_irRankName" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), draw = function()
					return CUSTOM.OP.isMyFrame(i)
				end, dst = {
					{time = openTime, x = posX + 170, y = posY + 26, w = 300, h = 25, r = 255, g = 161, b = 3},
				}
			})
			-- スコア
			table.insert(parts.destination, {
				id = "s_exscore" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), draw = function()
					return not CUSTOM.OP.isMyFrame(i)
				end, dst = {
					{time = openTime, x = posX + 610, y = posY + 30, w = 20, h = 24},
				}
			})
			table.insert(parts.destination, {
				id = "s_exscore" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), draw = function()
					return CUSTOM.OP.isMyFrame(i)
				end, dst = {
					{time = openTime, x = posX + 610, y = posY + 30, w = 20, h = 24, r = 255, g = 161, b = 3},
				}
			})
			-- クリアランク
			do
				local refRate = {100, 88.88, 77.77, 66.66, 55.55, 44.44, 33.33, 22.22, -1}
				local wd = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
				for j = 1, 8, 1 do
					table.insert(parts.destination, {
						id = "s_"..wd[j], loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), draw = function()
							-- exスコアを取得
							local exScore = main_state.number(379 + i)
							-- 最大exスコアを取得
							local maxExScore = CUSTOM.NUM.maxExscore()
							local rankRate = (exScore / maxExScore) * 100
							return main_state.option(MAIN.OP.SONGBAR) and main_state.option(MAIN.OP.ONLINE) and rankRate <= refRate[j] and rankRate > refRate[j + 1]
						end,
						dst = {
							{time = openTime, x = posX + 730, y = posY + 32, w = 59, h = 22},
						}
					})
				end
			end
			-- クリア状況
			table.insert(parts.destination, {
				id = "s_clearTypeIr" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), dst = {
					{time = openTime, x = posX + 800, y = posY + 32, w = 110, h = 22},
				}
			})
			-- 自分の場合は強調
			table.insert(parts.destination, {
				id = "s_rankingMyPostion", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isRankingMenuOpen end), draw = function()
					return CUSTOM.OP.isMyFrame(i)
				end, dst = {
					{time = openTime, x = posX - 3, y = posY - 5, w = 936, h = 70},
				}
			})
			posY = posY - 63
		end
	end

	-- IR接続中
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, loop = openTime, timer = timer_util.timer_observe_boolean(function() return irLoading(isLampMenuOpen, isRankingMenuOpen) end), dst = {
			{time = openTime, x = posX, y = 228, w = 930, h = 636, a = 200}
		}
	})
	table.insert(parts.destination, {
		id = "s_loading", loop = openTime, timer = timer_util.timer_observe_boolean(function() return irLoading(isLampMenuOpen, isRankingMenuOpen) end), dst = {
			{time = openTime, x = posX + (930 / 2) - (312 / 2), y = 228 + (636 / 2), w = 312, h = 200, a = 200},
		}
	})
	table.insert(parts.destination, {
		id = "s_loadingWd", loop = openTime, timer = timer_util.timer_observe_boolean(function() return irLoading(isLampMenuOpen, isRankingMenuOpen) end), dst = {
			{time = openTime, x = posX + (930 / 2) - (750 / 2), y = 400, w = 750, h = 130, a = 200},
			{time = openTime + 1000, a = 100},
			{time = openTime + 2000, a = 200}
		}
	})
	-- IR接続不可
	table.insert(parts.destination, {
		id = MAIN.IMAGE.BLACK, loop = openTime, timer = timer_util.timer_observe_boolean(function() return irOffline(isLampMenuOpen, isRankingMenuOpen) end), dst = {
			{time = openTime, x = posX, y = 228, w = 930, h = 636, a = 200}
		}
	})
	table.insert(parts.destination, {
		id = "s_offline", loop = openTime, timer = timer_util.timer_observe_boolean(function() return irOffline(isLampMenuOpen, isRankingMenuOpen) end), dst = {
			{time = openTime, x = posX + (930 / 2) - (312 / 2), y = 228 + (636 / 2), w = 312, h = 200, a = 200},
		}
	})
	table.insert(parts.destination, {
		id = "s_offlineWd", loop = openTime, timer = timer_util.timer_observe_boolean(function() return irOffline(isLampMenuOpen, isRankingMenuOpen) end), dst = {
			{time = openTime, x = posX + (930 / 2) - (750 / 2), y = 400, w = 750, h = 130, a = 200},
			{time = openTime + 1000, a = 100},
			{time = openTime + 2000, a = 200}
		}
	})

	-- ボリュームコントロール-------------------------------------------------------------
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = 0, x = -930, y = 228, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = posX}
		}
	})
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return not isVolumeMenuOpen end), dst = {
			{time = 0, x = -posX, y = 228, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = -930}
		}
	})
	table.insert(parts.destination, {
		id = "s_volumeFrame", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = openTime, x = posX, y = 228, w = 930, h = 635},
		}
	})
	-- ボリューム数値
	table.insert(parts.destination, {
		id = "s_masterVolumeNum", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = openTime, x = posX + 770, y = 627, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "s_keyVolumeNum", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = openTime, x = posX + 770, y = 512, w = 22, h = 15},
		}
	})
	table.insert(parts.destination, {
		id = "s_bgmVolumeNum", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = openTime, x = posX + 770, y = 392, w = 22, h = 15},
		}
	})
	-- ボリュームつまみ
	table.insert(parts.destination, {
		id = "s_masterVolume", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = openTime, x = posX + 270, y = 615, w = 15, h = 39},
		}
	})
	table.insert(parts.destination, {
		id = "s_keyVolume", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = openTime, x = posX + 270, y = 502, w = 15, h = 39},
		}
	})
	table.insert(parts.destination, {
		id = "s_bgmVolume", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
			{time = openTime, x = posX + 270, y = 380, w = 15, h = 39},
		}
	})
	-- ボリューム最小、最大アイコン
	do
		local wd = {"s_masterVolumeMin", "s_keyVolumeMin", "s_bgmVolumeMin", "s_masterVolumeMax", "s_keyVolumeMax", "s_bgmVolumeMax"}
		local wd2 = {"s_masterVolumeMinRect", "s_keyVolumeMinRect", "s_bgmVolumeMinRect", "s_masterVolumeMaxRect", "s_keyVolumeMaxRect", "s_bgmVolumeMaxRect"}
		local adPosX = {195, 195, 195, 690, 690, 690}
		local adPosY = {605, 492, 370, 605, 492, 370}
		for i = 1, #wd, 1 do
			table.insert(parts.destination, {
				id = wd[i], loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = adPosY[i], w = 64, h = 61},
				}
			})
		end
		for i = 1, #wd2, 1 do
			table.insert(parts.destination, {
				id = wd2[i], loop = openTime, timer = timer_util.timer_observe_boolean(function() return isVolumeMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = adPosY[i], w = 64, h = 61},
				}, mouseRect = {x = 0, y = 0, w = 64, h = 61}
			})
		end
	end

	-- 設定メニュー------------------------------------------------------------
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
			{time = 0, x = -930, y = posY, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = posX}
		}
	})
	table.insert(parts.destination, {
		id = "s_menu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return not isSettingMenuOpen end), dst = {
			{time = 0, x = -posX, y = posY, w = 930, h = 636, acc = MAIN.ACC.DECELERATE},
			{time = openTime, x = -930}
		}
	})
	-- キーコンフィグ、スキン変更、IRページを開く
	table.insert(parts.destination, {
		id = "s_wdSettingsMenu", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
			{time = openTime, x = posX + 160, y = posY + 484, w = 610, h = 36},
		}
	})
	do
		-- 上段
		local adPosX = {120, 350, 578}
		local wd = {"wdKeyconfig", "wdSkinChange", "wdIrpageOpenNg"}
		for i = 1, 3, 1 do
			table.insert(parts.destination, {
				id = "s_btn", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 386, w = 231, h = 61},
				}
			})
			table.insert(parts.destination, {
				id = "s_" ..wd[i], loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 386, w = 231, h = 61},
				}
			})
			table.insert(parts.destination, {
				id = "s_btnRect", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 386, w = 231, h = 61},
					{time = openTime + 250, a = 100},
					{time = openTime + 500, a = 255}
				}, mouseRect = {x = 0, y = 0, w = 231, h = 61}
			})
		end
		-- 曲バー、段位バーの時のみ表示
		table.insert(parts.destination, {
			id = "s_wdIrpageOpen", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), draw = function()
				return main_state.option(MAIN.OP.SONGBAR) or main_state.option(MAIN.OP.GRADEBAR)
			end, dst = {
				{time = openTime, x = posX + 578, y = posY + 386, w = 231, h = 61},
			}
		})
	end
	-- リプレイ設定
	table.insert(parts.destination, {
		id = "s_wdAutoSaveReplaySettings", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
			{time = openTime, x = posX + 160, y = posY + 260, w = 610, h = 36},
		}
	})
	do
		local adPosX = {11, 237, 462, 688}
		local selectOp = {
			MAIN.OP.SELECT_REPLAYDATA,
			MAIN.OP.SELECT_REPLAYDATA2,
			MAIN.OP.SELECT_REPLAYDATA3,
			MAIN.OP.SELECT_REPLAYDATA4
		}
		local replayOp = {
			MAIN.OP.REPLAYDATA,
			MAIN.OP.REPLAYDATA2,
			MAIN.OP.REPLAYDATA3,
			MAIN.OP.REPLAYDATA4
		}

		for i = 1, 4, 1 do
			-- リプレイ設定
			table.insert(parts.destination, {
				id = "s_btn", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 162, w = 231, h = 61},
				}
			})
			table.insert(parts.destination, {
				id = "s_autoReplaySetting" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 162, w = 231, h = 61},
				}
			})
			table.insert(parts.destination, {
				id = "s_btnRect", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 162, w = 231, h = 61},
					{time = openTime + 250, a = 100},
					{time = openTime + 500, a = 255}
				}, mouseRect = {x = 0, y = 0, w = 231, h = 61}
			})
			-- リプレイボタン
			table.insert(parts.destination, {
				id = "s_btn", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 100, w = 231, h = 61},
				}
			})
			table.insert(parts.destination, {
				id = "s_autoReplayOff" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 100, w = 231, h = 61},
				}
			})
			table.insert(parts.destination, {
				id = "s_autoReplayOn" ..i, loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), op = {replayOp[i]}, dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 100, w = 231, h = 61},
				}
			})
			table.insert(parts.destination, {
				id = "s_btnSelected", loop = openTime, timer = timer_util.timer_observe_boolean(function() return isSettingMenuOpen end), op = {selectOp[i]}, dst = {
					{time = openTime, x = posX + adPosX[i], y = posY + 100, w = 231, h = 61},
				}
			})
		end
	end

	return parts
end

return {
	load = load
}