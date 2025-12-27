--[[
	5鍵用メインLua
	@author : KASAKO
	blog: https://www.kasacontent.com/tag/modernchic/
]]
-- DEBUG = true
-- モジュール読み込み
main_state = require("main_state")
-- requireはディレクトリ区切りを.で表す
PROPERTY = require("Play.lua.require.sp_property").load(true)
COMMONFUNC = require("Play.lua.require.common")
-- ヘッダ読み込み
local header = require("Play.lua.require.header").load(1)

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	CONFIG = require("config")
	BASE = require("Play.lua.base").createBasePositionSP(5)
	-- テキスト
	local textProperty = require("Play.lua.require.textproperty")
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)
	skin.source =  {}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.image = {}
	skin.note = {}
	skin.value = {}
	skin.slider = {}
	skin.hiddenCover = {}
	skin.liftCover = {}
	skin.graph = {}
	skin.bga = {id = "bga"}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.timingvisualizer = {}
	skin.hiterrorvisualizer = {}
	skin.judge = {}
	skin.gauge = {}
	skin.destination = {}
	require("Play.lua.base").addSourceSP(skin)
	-- 背景
	do
		local background_path = skin_config.get_path("Play/lua/background.lua")
		local background_status, background_parts = pcall(function()
			return dofile(background_path).load(3)
		end)
		if background_status and background_parts then
			CUSTOM.ADD_ALL(skin.image, background_parts.image)
			CUSTOM.ADD_ALL(skin.destination, background_parts.destination)
		end
	end
	-- インフォ部分
	do
		local info_path = skin_config.get_path("Play/lua/sp/info.lua")
		local info_status, info_parts = pcall(function()
			return dofile(info_path).load()
		end)
		if info_status and info_parts then
			CUSTOM.ADD_ALL(skin.source, info_parts.source)
			CUSTOM.ADD_ALL(skin.image, info_parts.image)
			CUSTOM.ADD_ALL(skin.value, info_parts.value)
			CUSTOM.ADD_ALL(skin.graph, info_parts.graph)
			CUSTOM.ADD_ALL(skin.destination, info_parts.destination)
		end
	end
	-- 進捗バー
	do
		local progress_path = skin_config.get_path("Play/lua/sp/progress.lua")
		local progress_status, progress_parts = pcall(function()
			return dofile(progress_path).load()
		end)
		if progress_status and progress_parts then
			CUSTOM.ADD_ALL(skin.image, progress_parts.image)
			CUSTOM.ADD_ALL(skin.slider, progress_parts.slider)
			CUSTOM.ADD_ALL(skin.destination, progress_parts.destination)
		end
	end
	-- キーフラッシュ
	do
		local keyflash_path = skin_config.get_path("Play/lua/sp/keyflash.lua")
		local keyflash_status, keyflash_parts = pcall(function()
			return dofile(keyflash_path).load(5)
		end)
		if keyflash_status and keyflash_parts then
			CUSTOM.ADD_ALL(skin.image, keyflash_parts.image)
			CUSTOM.ADD_ALL(skin.destination, keyflash_parts.destination)
		end
	end
	-- ゲージ
	do
		local gauge_path = skin_config.get_path("Play/lua/sp/gauge.lua")
		local gauge_status, gauge_parts = pcall(function()
			return dofile(gauge_path).load()
		end)
		if gauge_status and gauge_parts then
			CUSTOM.ADD_ALL(skin.image, gauge_parts.image)
			CUSTOM.ADD_ALL(skin.value, gauge_parts.value)
			skin.gauge = gauge_parts.gauge
			CUSTOM.ADD_ALL(skin.destination, gauge_parts.destination)
		end
	end
	-- レーン部分
	do
		local lane_path = skin_config.get_path("Play/lua/sp/lane.lua")
		local lane_status, lane_parts = pcall(function()
			return dofile(lane_path).load()
		end)
		if lane_status and lane_parts then
			CUSTOM.ADD_ALL(skin.image, lane_parts.image)
			CUSTOM.ADD_ALL(skin.destination, lane_parts.destination)
		end
	end
	-- キー入力
	do
		local inputkey_path = skin_config.get_path("Play/lua/sp/inputkey.lua")
		local inputkey_status, inputkey_parts = pcall(function()
			return dofile(inputkey_path).load(5)
		end)
		if inputkey_status and inputkey_parts then
			CUSTOM.ADD_ALL(skin.image, inputkey_parts.image)
			CUSTOM.ADD_ALL(skin.destination, inputkey_parts.destination)
		end
	end
	-- ノート
	do
		local notes_path = skin_config.get_path("Play/lua/sp/notes.lua")
		local notes_status, notes_parts = pcall(function()
			return dofile(notes_path).load(5)
		end)
		if notes_status and notes_parts then
			CUSTOM.ADD_ALL(skin.image, notes_parts.image)
			skin.note = notes_parts.note
			CUSTOM.ADD_ALL(skin.destination, notes_parts.destination)
		end
	end
	-- カバー
	do
		local cover_path = skin_config.get_path("Play/lua/sp/cover.lua")
		local cover_status, cover_parts = pcall(function()
			return dofile(cover_path).load()
		end)
		if cover_status and cover_parts then
			CUSTOM.ADD_ALL(skin.image, cover_parts.image)
			CUSTOM.ADD_ALL(skin.value, cover_parts.value)
			CUSTOM.ADD_ALL(skin.slider, cover_parts.slider)
			CUSTOM.ADD_ALL(skin.hiddenCover, cover_parts.hiddenCover)
			CUSTOM.ADD_ALL(skin.liftCover, cover_parts.liftCover)
			CUSTOM.ADD_ALL(skin.destination, cover_parts.destination)
		end
	end
	-- 5鍵用カバー
	if PROPERTY.is5keyLanecoverOn() then
		table.insert(skin.image, {id = "5keysFrame", src = 1, x = 1760, y = 0, w = 114, h = 901})
		table.insert(skin.destination,{
			id = "5keysFrame", loop = 1500, dst = {
				{time = 0, x = BASE.playsidePositionX + BASE.FIVEKEY_COVER_POS_X, y = 1080, w = 114, h = 901, acc = MAIN.ACC.DECELERATE, a = 240, angle = BASE.FIVEKEY_COVER_ANGLE},
				{time = 1000},
				{time = 1500, y = BASE.NOTES_JUDGE_Y - 48}
			}
		})
	end
	-- ターゲット差分、SLOW/FAST
	do
		local assist_path = skin_config.get_path("Play/lua/sp/assist.lua")
		local assist_status, assist_parts = pcall(function()
			return dofile(assist_path).load()
		end)
		if assist_status and assist_parts then
			CUSTOM.ADD_ALL(skin.image, assist_parts.image)
			CUSTOM.ADD_ALL(skin.value, assist_parts.value)
			CUSTOM.ADD_ALL(skin.destination, assist_parts.destination)
		end
	end
	-- 爆発
	do
		local bomb7_path = skin_config.get_path("Play/lua/sp/bomb.lua")
		local bomb7_status, bomb7_parts = pcall(function()
			return dofile(bomb7_path).load(5)
		end)
		if bomb7_status and bomb7_parts then
			CUSTOM.ADD_ALL(skin.image, bomb7_parts.image)
			CUSTOM.ADD_ALL(skin.destination, bomb7_parts.destination)
		end
	end
	-- 判定カウント、レベル情報部分
	do
		local info2_path = skin_config.get_path("Play/lua/sp/info2.lua")
		local info2_status, info2_parts = pcall(function()
			return dofile(info2_path).load()
		end)
		if info2_status and info2_parts then
			CUSTOM.ADD_ALL(skin.image, info2_parts.image)
			CUSTOM.ADD_ALL(skin.value, info2_parts.value)
			CUSTOM.ADD_ALL(skin.destination, info2_parts.destination)
		end
	end
	-- 判定
	do
		local judge_path = skin_config.get_path("Play/lua/sp/judge.lua")
		local judge_status, judge_parts = pcall(function()
			return dofile(judge_path).load()
		end)
		if judge_status and judge_parts then
			CUSTOM.ADD_ALL(skin.image, judge_parts.image)
			CUSTOM.ADD_ALL(skin.value, judge_parts.value)
			CUSTOM.ADD_ALL(skin.judge, judge_parts.judge)
			CUSTOM.ADD_ALL(skin.destination, judge_parts.destination)
		end
	end
	-- グラフ関連
	do
		local graph_path = skin_config.get_path("Play/lua/sp/graph.lua")
		local graph_status, graph_parts = pcall(function()
			return dofile(graph_path).load()
		end)
		if graph_status and graph_parts then
			CUSTOM.ADD_ALL(skin.image, graph_parts.image)
			CUSTOM.ADD_ALL(skin.value, graph_parts.value)
			CUSTOM.ADD_ALL(skin.judgegraph, graph_parts.judgegraph)
			CUSTOM.ADD_ALL(skin.bpmgraph, graph_parts.bpmgraph)
			CUSTOM.ADD_ALL(skin.timingvisualizer, graph_parts.timingvisualizer)
			CUSTOM.ADD_ALL(skin.hiterrorvisualizer, graph_parts.hiterrorvisualizer)
			CUSTOM.ADD_ALL(skin.graph, graph_parts.graph)
			CUSTOM.ADD_ALL(skin.destination, graph_parts.destination)
		end
	end
	-- フルコン演出
	do
		local fullcombo_path = skin_config.get_path("Play/lua/sp/fullcombo.lua")
		local fullcombo_status, fullcombo_parts = pcall(function()
			return dofile(fullcombo_path).load()
		end)
		if fullcombo_status and fullcombo_parts then
			CUSTOM.ADD_ALL(skin.image, fullcombo_parts.image)
			CUSTOM.ADD_ALL(skin.destination, fullcombo_parts.destination)
		end
	end
	-- スコアバー
	do
		local scorebar_path = skin_config.get_path("Play/lua/sp/scorebar.lua")
		local scorebar_status, scorebar_parts = pcall(function()
			return dofile(scorebar_path).load()
		end)
		if scorebar_status and scorebar_parts then
			CUSTOM.ADD_ALL(skin.image, scorebar_parts.image)
			CUSTOM.ADD_ALL(skin.value, scorebar_parts.value)
			CUSTOM.ADD_ALL(skin.graph, scorebar_parts.graph)
			CUSTOM.ADD_ALL(skin.destination, scorebar_parts.destination)
		end
	end
	-- 攻撃モーション用
	if PROPERTY.isAttackModeOn() then
		local attack_path = skin_config.get_path("Play/lua/sp/attack.lua")
		local attack_status, attack_parts = pcall(function()
			return dofile(attack_path).load()
		end)
		if attack_status and attack_parts then
			CUSTOM.ADD_ALL(skin.image, attack_parts.image)
			CUSTOM.ADD_ALL(skin.value, attack_parts.value)
			CUSTOM.ADD_ALL(skin.graph, attack_parts.graph)
			CUSTOM.ADD_ALL(skin.destination, attack_parts.destination)
		end
	end
	-- BGAエリアに情報表示 (プレイ)
	if PROPERTY.isDetailInfoSwitchOn() then
		local bgaareainfo_path = skin_config.get_path("Play/lua/sp/detailinfo/bgaareainfo.lua")
		local bgaareainfo_parts = dofile(bgaareainfo_path).load(6)
		if bgaareainfo_parts then
			CUSTOM.ADD_ALL(skin.image, bgaareainfo_parts.image)
			CUSTOM.ADD_ALL(skin.value, bgaareainfo_parts.value)
			CUSTOM.ADD_ALL(skin.graph, bgaareainfo_parts.graph)
			CUSTOM.ADD_ALL(skin.slider, bgaareainfo_parts.slider)
			CUSTOM.ADD_ALL(skin.judgegraph, bgaareainfo_parts.judgegraph)
			CUSTOM.ADD_ALL(skin.bpmgraph, bgaareainfo_parts.bpmgraph)
			CUSTOM.ADD_ALL(skin.destination, bgaareainfo_parts.destination)
		end
	end
	-- 準備
	do
		local prepare_path = skin_config.get_path("Play/lua/sp/prepare.lua")
		local prepare_status, prepare_parts = pcall(function()
			return dofile(prepare_path).load()
		end)
		if prepare_status and prepare_parts then
			CUSTOM.ADD_ALL(skin.image, prepare_parts.image)
			CUSTOM.ADD_ALL(skin.value, prepare_parts.value)
			CUSTOM.ADD_ALL(skin.graph, prepare_parts.graph)
			CUSTOM.ADD_ALL(skin.judgegraph, prepare_parts.judgegraph)
			CUSTOM.ADD_ALL(skin.destination, prepare_parts.destination)
		end
	end
	-- 閉店処理
	do
		local close_path = skin_config.get_path("Play/lua/close.lua")
		local close_status, close_parts = pcall(function()
			return dofile(close_path).load(21)
		end)
		if close_status and close_parts then
			CUSTOM.ADD_ALL(skin.image, close_parts.image)
			CUSTOM.ADD_ALL(skin.destination, close_parts.destination)
		end
	end
	-- 終了時にフェードアウト
	table.insert(skin.destination, {
		id = MAIN.IMAGE.BLACK, timer = MAIN.TIMER.FADEOUT, loop = 500, dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},
			{time = 500, a = 255}
		}
	})
	
	return skin
end

return{
	header = header,
	main = main
}