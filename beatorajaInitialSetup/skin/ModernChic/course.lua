--[[
	コースリザルト画面
	@author : KASAKO
	blog: https://www.kasacontent.com/tag/modernchic/
]]
-- DEBUG = true
-- モジュール読み込み
main_state = require("main_state")
timer_util = require("timer_util")
PROPERTY = require("Result.lua.require.property").load(false)
-- ヘッダ読み込み
local header = require("Result.lua.require.header").load(15)

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	CONFIG = require("config")
	RESULT_BASE = require("Result.lua.base").createBasePosition()
	-- テキスト関連
	local textProperty = require("Result.lua.require.textproperty")
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)

	skin.source =  {}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.image = {}
	skin.imageset = {}
	skin.value = {}
	skin.slider = {}
	skin.graph = {}
	skin.gauge = {}
	skin.gaugegraph = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.timingdistributiongraph = {}
	skin.customTimers = {}
	skin.customEvents = {}
	skin.destination = {}
	if CONFIG.infoOutput then CUSTOM.FUNC.infoOutput(15) end
	require("Result.lua.base").addSource(skin)
	
	-- 背景
	do
		local path = skin_config.get_path("Result/lua/background.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.source, parts.source)
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.imageset, parts.imageset)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- 画面下にタイトル、アーティスト、ジャンル、難易度表名
	table.insert(skin.destination, {
		id = MAIN.IMAGE.BLACK, dst = {
			{x = 0, y = 0, w = 1920, h = 50},
		}
	})
	table.insert(skin.destination, {
		id = "bottomCourse", dst = {
			{x = 1920 / 2, y = 10, w = 1600, h = 25},
		}
	})
	-- 中央部情報
	do
		local path = skin_config.get_path("Result/lua/centerinfo.lua")
		local status, parts = pcall(function()
			return dofile(path).load(1)
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.value, parts.value)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- 通常メニュー
	do
		local path = skin_config.get_path("Result/lua/mainmenu.lua")
		local status, parts = pcall(function()
			return dofile(path).load(1)
		end)
		if status and parts then
			skin.gauge = parts.gauge
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.value, parts.value)
			CUSTOM.ADD_ALL(skin.graph, parts.graph)
			CUSTOM.ADD_ALL(skin.gaugegraph, parts.gaugegraph)
			CUSTOM.ADD_ALL(skin.judgegraph, parts.judgegraph)
			CUSTOM.ADD_ALL(skin.bpmgraph, parts.bpmgraph)
			CUSTOM.ADD_ALL(skin.timingdistributiongraph, parts.timingdistributiongraph)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- IRメニュー
	if PROPERTY.isIrmenuOn() and main_state.option(MAIN.OP.ONLINE) then
		local path = skin_config.get_path("Result/lua/irmenu.lua")
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
	-- 事前準備
	-- main_state.option(293)は使えないっぽい
	if PROPERTY.isStartAnimationOn() then
		local path = skin_config.get_path("Result/lua/prepare.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- フェードアウト処理
	do
		local path = skin_config.get_path("Result/lua/fadeout.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	-- プレイ履歴の追加
	-- TODO リプレイ中のリザルトも履歴として記録されてしまう
	-- isReplay()で対処したいなー
	if PROPERTY.isUpdateHistoryOn() then
		local path = skin_config.get_path("Result/lua/history.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	
	return skin
end

return{
	header = header,
	main = main
}