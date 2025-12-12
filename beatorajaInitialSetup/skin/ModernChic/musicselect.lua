--[[
	曲選択画面
	@author : KASAKO
	blog : https://www.kasacontent.com/tag/modernchic/
]]
-- DEBUG = true
-- モジュール読み込み
main_state = require("main_state")
timer_util = require("timer_util")
PROPERTY = require("Select.lua.require.property")
local header = require("Select.lua.require.header")

local function changeLang(tbl)
	local lang = nil
	if PROPERTY.isLanguageJPN() then
		lang = "jp"
	elseif PROPERTY.isLanguageEN() then
		lang = "en"
	elseif PROPERTY.isLanguageCN() then
		lang = "cn"
	end
	table.insert(tbl, {id = 3, path = "Select/parts/" ..lang .."/assistop.png"})
	table.insert(tbl, {id = 4, path = "Select/parts/" ..lang .."/subop.png"})
	table.insert(tbl, {id = 5, path = "Select/parts/" ..lang .."/mainframe.png"})
	table.insert(tbl, {id = 6, path = "Select/parts/" ..lang .."/op.png"})
	table.insert(tbl, {id = 10, path = "Select/parts/" ..lang .."/help.png"})
	table.insert(tbl, {id = 11, path = "Select/parts/" ..lang .."/sidemenu.png"})
end

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	CONFIG = require("config")
	-- テキスト関連
	local textProperty = require("Select.lua.require.textproperty").load(header.ver)
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)
	skin.source = {
		{id = 7, path = "Select/parts/songbar.png"},
		{id = 8, path = "Select/parts/scoreinfo.png"},
		{id = 9, path = "Select/parts/qco.png"},
	}
	-- 使用言語によって切り替え
	changeLang(skin.source)

	skin.image = {}
	skin.imageset = {}
	skin.graph = {}
	skin.slider = {}
	skin.value = {}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.songlist = {}
	skin.customTimers = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.destination = {}
	if CONFIG.infoOutput then CUSTOM.FUNC.infoOutput(5) end
	-- 背景
	do
		local background_path = skin_config.get_path("Select/lua/background.lua")
		local background_status, background_parts = pcall(function()
			return dofile(background_path).load()
		end)
		if background_status and background_parts then
			CUSTOM.ADD_ALL(skin.source, background_parts.source)
			CUSTOM.ADD_ALL(skin.image, background_parts.image)
			CUSTOM.ADD_ALL(skin.destination, background_parts.destination)
		end
	end
	-- 曲リスト
	do
		local songlist_path = skin_config.get_path("Select/lua/songlist.lua")
		local songlist_status, songlist_parts = pcall(function()
			return dofile(songlist_path).load()
		end)
		if songlist_status and songlist_parts then
			CUSTOM.ADD_ALL(skin.image, songlist_parts.image)
			CUSTOM.ADD_ALL(skin.imageset, songlist_parts.imageset)
			CUSTOM.ADD_ALL(skin.value, songlist_parts.value)
			CUSTOM.ADD_ALL(skin.graph, songlist_parts.graph)
			skin.songlist = songlist_parts.songlist
			CUSTOM.ADD_ALL(skin.destination, songlist_parts.destination)
		end
	end
	-- メインフレーム
	do
		local mainframe_path = skin_config.get_path("Select/lua/mainframe.lua")
		local mainframe_status, mainframe_parts = pcall(function()
			return dofile(mainframe_path).load()
		end)
		if mainframe_status and mainframe_parts then
			CUSTOM.ADD_ALL(skin.source, mainframe_parts.source)
			CUSTOM.ADD_ALL(skin.image, mainframe_parts.image)
			CUSTOM.ADD_ALL(skin.slider, mainframe_parts.slider)
			CUSTOM.ADD_ALL(skin.imageset, mainframe_parts.imageset)
			CUSTOM.ADD_ALL(skin.destination, mainframe_parts.destination)
		end
	end
	-- 選曲タイトル、ジャンル、BPM表示部
	do
		local musicdisplay_path = skin_config.get_path("Select/lua/musicdisplay.lua")
		local musicdisplay_status, musicdisplay_parts = pcall(function()
			return dofile(musicdisplay_path).load()
		end)
		if musicdisplay_status and musicdisplay_parts then
			CUSTOM.ADD_ALL(skin.image, musicdisplay_parts.image)
			CUSTOM.ADD_ALL(skin.value, musicdisplay_parts.value)
			CUSTOM.ADD_ALL(skin.destination, musicdisplay_parts.destination)
		end
	end
	-- ボタンエリア
	do
		local btnarea_path = skin_config.get_path("Select/lua/btnarea.lua")
		local btnarea_status, btnarea_parts = pcall(function()
			return dofile(btnarea_path).load()
		end)
		if btnarea_status and btnarea_parts then
			CUSTOM.ADD_ALL(skin.image, btnarea_parts.image)
			CUSTOM.ADD_ALL(skin.destination, btnarea_parts.destination)
		end
	end
	-- コース・段位表示
	do
		local cource_path = skin_config.get_path("Select/lua/cource.lua")
		local cource_status, cource_parts = pcall(function()
			return dofile(cource_path).load()
		end)
		if cource_status and cource_parts then
			CUSTOM.ADD_ALL(skin.image, cource_parts.image)
			CUSTOM.ADD_ALL(skin.destination, cource_parts.destination)
		end
	end
	-- BMS情報部
	do
		local info_path = skin_config.get_path("Select/lua/info.lua")
		local info_status, info_parts = pcall(function()
			return dofile(info_path).load()
		end)
		if info_status and info_parts then
			CUSTOM.ADD_ALL(skin.image, info_parts.image)
			CUSTOM.ADD_ALL(skin.value, info_parts.value)
			CUSTOM.ADD_ALL(skin.graph, info_parts.graph)
			CUSTOM.ADD_ALL(skin.destination, info_parts.destination)
		end
	end
	-- スコア表示部
	do
		local score_path = skin_config.get_path("Select/lua/score.lua")
		local score_status, score_parts = pcall(function()
			return dofile(score_path).load()
		end)
		if score_status and score_parts then
			CUSTOM.ADD_ALL(skin.image, score_parts.image)
			CUSTOM.ADD_ALL(skin.value, score_parts.value)
			CUSTOM.ADD_ALL(skin.graph, score_parts.graph)
			CUSTOM.ADD_ALL(skin.destination, score_parts.destination)
		end
	end
	-- BMS分析部
	do
		local bmsanalysis_path = skin_config.get_path("Select/lua/bmsanalysis.lua")
		local bmsanalysis_status, bmsanalysis_parts = pcall(function()
			return dofile(bmsanalysis_path).load()
		end)
		if bmsanalysis_status and bmsanalysis_parts then
			CUSTOM.ADD_ALL(skin.image, bmsanalysis_parts.image)
			CUSTOM.ADD_ALL(skin.judgegraph, bmsanalysis_parts.judgegraph)
			CUSTOM.ADD_ALL(skin.bpmgraph, bmsanalysis_parts.bpmgraph)
			CUSTOM.ADD_ALL(skin.value, bmsanalysis_parts.value)
			CUSTOM.ADD_ALL(skin.destination, bmsanalysis_parts.destination)
		end
	end
	-- QCO
	do
		local qco_path = skin_config.get_path("Select/lua/qco.lua")
		local qco_status, qco_parts = pcall(function()
			return dofile(qco_path).load()
		end)
		if qco_status and qco_parts then
			CUSTOM.ADD_ALL(skin.image, qco_parts.image)
			CUSTOM.ADD_ALL(skin.imageset, qco_parts.imageset)
			CUSTOM.ADD_ALL(skin.value, qco_parts.value)
			CUSTOM.ADD_ALL(skin.destination, qco_parts.destination)
		end
	end
	-- ライバル機能
	do
		local rivalview_path = skin_config.get_path("Select/lua/rivalview.lua")
		local rivalview_status, rivalview_parts = pcall(function()
			return dofile(rivalview_path).load()
		end)
		if rivalview_status and rivalview_parts then
			CUSTOM.ADD_ALL(skin.image, rivalview_parts.image)
			CUSTOM.ADD_ALL(skin.value, rivalview_parts.value)
			CUSTOM.ADD_ALL(skin.destination, rivalview_parts.destination)
		end
	end
	-- サイドメニュー
	do
		local path = skin_config.get_path("Select/lua/sidemenu.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.imageset, parts.imageset)
			CUSTOM.ADD_ALL(skin.value, parts.value)
			CUSTOM.ADD_ALL(skin.slider, parts.slider)
			CUSTOM.ADD_ALL(skin.graph, parts.graph)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- バージョンチェック
--[[
	do
		local path = skin_config.get_path("Select/lua/versioncheck.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
]]
	-- プレイ履歴
	if PROPERTY.isviewHistoryOn() then
		local path = skin_config.get_path("Select/lua/history.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.value, parts.value)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- ヘルプ画面
	do
		local path = skin_config.get_path("Select/lua/help.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- 開始アニメーション
	do
		local startanimation_path = skin_config.get_path("Select/lua/startanimation.lua")
		local startanimation_status, startanimation_parts = pcall(function()
			return dofile(startanimation_path).load()
		end)
		if startanimation_status and startanimation_parts then
			CUSTOM.ADD_ALL(skin.image, startanimation_parts.image)
			CUSTOM.ADD_ALL(skin.value, startanimation_parts.value)
			CUSTOM.ADD_ALL(skin.destination, startanimation_parts.destination)
		end
	end
	-- オプションメニュー
	do
		local option_path = skin_config.get_path("Select/lua/option.lua")
		local option_status, option_parts = pcall(function()
			return dofile(option_path).load()
		end)
		if option_status and option_parts then
			CUSTOM.ADD_ALL(skin.image, option_parts.image)
			CUSTOM.ADD_ALL(skin.imageset, option_parts.imageset)
			CUSTOM.ADD_ALL(skin.destination, option_parts.destination)
		end
	end
	-- アシストオプション
	do
		local assistoption_path = skin_config.get_path("Select/lua/assistoption.lua")
		local assistoption_status, assistoption_parts = pcall(function()
			return dofile(assistoption_path).load()
		end)
		if assistoption_status and assistoption_parts then
			CUSTOM.ADD_ALL(skin.image, assistoption_parts.image)
			CUSTOM.ADD_ALL(skin.imageset, assistoption_parts.imageset)
			CUSTOM.ADD_ALL(skin.destination, assistoption_parts.destination)
		end
	end
	-- サブオプション
	do
		local suboption_path = skin_config.get_path("Select/lua/suboption.lua")
		local suboption_status, suboption_parts = pcall(function()
			return dofile(suboption_path).load()
		end)
		if suboption_status and suboption_parts then
			CUSTOM.ADD_ALL(skin.image, suboption_parts.image)
			CUSTOM.ADD_ALL(skin.value, suboption_parts.value)
			CUSTOM.ADD_ALL(skin.imageset, suboption_parts.imageset)
			CUSTOM.ADD_ALL(skin.destination, suboption_parts.destination)
		end
	end
	return skin
end

return{
	header = header,
	main = main
}