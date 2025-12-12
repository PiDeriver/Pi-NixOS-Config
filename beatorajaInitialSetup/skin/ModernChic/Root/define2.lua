--[[
    カスタムパラメータ定義
    DATE:21/09/11
    @author : KASAKO
]]
local m = {}
-- ヘッダ情報読み込み
m.LOAD_HEADER = function(skin, header)
	for i, v in pairs(header) do
		skin[i] = v
	end
end
-- テーブルに要素を追加する
m.ADD_ALL = function(list, t)
	if t then
		for i, v in ipairs(t) do
			table.insert(list, v)
		end
	end
end
-- 区間スコア状況
m.sectionScore = {
	oneFour = {nFlg = true, sFlg = true, gFlg = true, myScore = 0, tgtDiff = 0},
	twoFour = {nFlg = true, sFlg = true, gFlg = true, myScore = 0, tgtDiff = 0},
	threeFour = {nFlg = true, sFlg = true, gFlg = true, myScore = 0, tgtDiff = 0},
	fourFour = {nFlg = true, sFlg = true, gFlg = true, myScore = 0, tgtDiff = 0}
}

m.OP = require("Root.customoption")
m.NUM = require("Root.customnumber")
m.GRAPH = require("Root.customgraph")
m.SLIDER = require("Root.customslider")
m.FUNC = require("Root.customfunction")
m.CLOCK = require("Root.customtime")
m.TEXT = require("Root.customtext")
m.SOUND = require("Root.customsound")
m.TIMER = require("Root.customtimer")
return m