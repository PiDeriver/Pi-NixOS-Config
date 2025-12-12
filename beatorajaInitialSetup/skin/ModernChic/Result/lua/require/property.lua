--[[
	リザルト用プロパティ
	@author : KASAKO
]]
local module = {}

-- 初期値
local offsetNumber = 39
local customoptionNumber = 899
local categoryNumber = 0

-- カテゴリナンバーの付与
local function addCategoryNumber()
	categoryNumber = categoryNumber + 1
	return categoryNumber
end

-- カスタムオプションナンバーの付与
local function addCustomoptionNumber()
	customoptionNumber = customoptionNumber + 1
	if customoptionNumber > 999 then
		print("警告：カスタムオプションが上限を超えています")
	end
	return customoptionNumber
end

-- オフセットナンバーを付与
local function addOffsetNumber()
	offsetNumber = offsetNumber + 1
	return offsetNumber
end

local customoption = {
    -- カスタムオプション項目を作成
    parent = function(name)
        return {
            name = name,
            label = addCategoryNumber()
        }
	end,
	-- カスタムオプション小項目を作成する
	chiled = function(cName, pName)
		local num = addCustomoptionNumber()
		local chiled = {name = cName, num = num}
		-- カスタムオプション簡易条件式
		local condition = function() return skin_config.option[pName] == num end
		return chiled, condition
	end,
	-- ファイルパス項目を作成
	filepath = function(name, path)
		return {
			name = name,
			path = path,
			label = addCategoryNumber(),
			def = "#default"
		}
	end,
	-- オフセット項目を作成
	offset = function(name)
		local label = addCategoryNumber()
		local num = addOffsetNumber()
		local offset = {name = name, label = label, num = num}
		local info = {
			num = num,
			alpha = function() return skin_config.offset[name].a end,
			width = function() return skin_config.offset[name].w end,
			height = function() return skin_config.offset[name].h end,
			x = function() return skin_config.offset[name].x end,
			y = function() return skin_config.offset[name].y end
		}
		return offset, info
	end
}

local function load(isResult)
	local bitmapFont = customoption.parent("画像フォント")
	bitmapFont.off, module.isOutlineFont = customoption.chiled("無効", bitmapFont.name)
	bitmapFont.on, module.isBitmapFont = customoption.chiled("有効（高負荷）", bitmapFont.name)
	local mainmenuPosition = customoption.parent("グラフ&スコア表示位置")
	mainmenuPosition.left, module.isMainmenuLeft = customoption.chiled("左", mainmenuPosition.name)
	mainmenuPosition.right, module.isMainmenuRight = customoption.chiled("右", mainmenuPosition.name)
	local showItem = customoption.parent("項目表示切り替え")
	showItem.combo, module.isShowItemCombo = customoption.chiled("コンボ数表示", showItem.name)
	showItem.misscount, module.isShowItemMisscount = customoption.chiled("ミスカウント表示", showItem.name)
	local startAnimation = customoption.parent("開始時アニメーション")
	startAnimation.off, module.isStartAnimationOff = customoption.chiled("無効", startAnimation.name)
	startAnimation.on, module.isStartAnimationOn = customoption.chiled("有効", startAnimation.name)
	local stageFile = customoption.parent("ステージファイル表示")
	stageFile.off, module.isStageFileOff = customoption.chiled("無効", stageFile.name)
	stageFile.on, module.isStageFileOn = customoption.chiled("有効", stageFile.name)
	local timeStamp = customoption.parent("タイムスタンプ")
	timeStamp.off, module.isTimestampOff = customoption.chiled("無効", timeStamp.name)
	timeStamp.on, module.isTimestampOn = customoption.chiled("有効", timeStamp.name)
	local beam = customoption.parent("修飾（ビーム）")
	beam.off, module.isBeamOff = customoption.chiled("無効", beam.name)
	beam.on, module.isBeamOn = customoption.chiled("有効", beam.name)
	local ring = customoption.parent("修飾（リング）")
	ring.off, module.isRingOff = customoption.chiled("無効", ring.name)
	ring.on, module.isRingOn = customoption.chiled("有効", ring.name)
	local bgPattern = customoption.parent("背景表示パターン")
	bgPattern.cf, module.isBackgroundClearFailed = customoption.chiled("Clear or Failed", bgPattern.name)
	bgPattern.all, module.isBackgroundAll = customoption.chiled("ALL", bgPattern.name)
	bgPattern.rank, module.isBackgroundRank = customoption.chiled("Rank", bgPattern.name)
	bgPattern.clearType, module.isBackgroundClearType = customoption.chiled("ClearType", bgPattern.name)
	local charSwitch = customoption.parent("キャラクター表示")
	charSwitch.off, module.isCharOff = customoption.chiled("無効", charSwitch.name)
	charSwitch.on, module.isCharOn = customoption.chiled("有効", charSwitch.name)
	local charPattern = customoption.parent("キャラクター表示パターン")
	charPattern.cf, module.isCharClearFailed = customoption.chiled("Clear or Failed", charPattern.name)
	charPattern.all, module.isCharAll = customoption.chiled("ALL", charPattern.name)
	charPattern.rank, module.isCharRank = customoption.chiled("Rank", charPattern.name)
	charPattern.clearType, module.isCharClearType = customoption.chiled("ClearType", charPattern.name)
	local irMenuSwitch = customoption.parent("IRメニュー表示")
	irMenuSwitch.off, module.isIrmenuOff = customoption.chiled("無効", irMenuSwitch.name)
	irMenuSwitch.on, module.isIrmenuOn = customoption.chiled("有効（オンライン時のみ表示されます）", irMenuSwitch.name)
	local irMenuPattern = customoption.parent("IRメニューの種類")
	irMenuPattern.top10, module.isIrRankingTop10 = customoption.chiled("IRランキングTOP10", irMenuPattern.name)
	irMenuPattern.clear, module.isIrClearType = customoption.chiled("IRクリア状況", irMenuPattern.name)
	local TDGMagnificationPattern = customoption.parent("タイミンググラフ倍率")
	TDGMagnificationPattern.low, module.isTDGMagnificationLow = customoption.chiled("低倍率（+-225ms）", TDGMagnificationPattern.name)
	TDGMagnificationPattern.normal, module.isTDGMagnificationNormal = customoption.chiled("標準倍率（+-150ms）", TDGMagnificationPattern.name)
	TDGMagnificationPattern.high, module.isTDGMagnificationHigh = customoption.chiled("高倍率（+-75ms）", TDGMagnificationPattern.name)
	local TDGColorPattern = customoption.parent("タイミンググラフ配色パターン")
	TDGColorPattern.normal, module.isTDGColorNormal = customoption.chiled("通常", TDGColorPattern.name)
	TDGColorPattern.red, module.isTDGColorRed = customoption.chiled("赤基調", TDGColorPattern.name)
	TDGColorPattern.green, module.isTDGColorGreen = customoption.chiled("緑基調", TDGColorPattern.name)
	TDGColorPattern.blue, module.isTDGColorBlue = customoption.chiled("青基調", TDGColorPattern.name)
	local clearRankPattern = customoption.parent("クリアランクイメージ表示パターン")
	clearRankPattern.fadeout, module.isClearRankFadeout = customoption.chiled("フェードアウト", clearRankPattern.name)
	clearRankPattern.fluffy, module.isClearRankFluffy = customoption.chiled("一定間隔表示", clearRankPattern.name)
	local updateHistory = customoption.parent("プレイ履歴の保存")
	updateHistory.off, module.isUpdateHistoryOff = customoption.chiled("無効", updateHistory.name)
	updateHistory.on, module.isUpdateHistoryOn = customoption.chiled("有効（ModernChic/History内に保存されます）", updateHistory.name)
	local updateHistoryBorder = customoption.parent("NOPLAYからのランプ更新保存")
	updateHistoryBorder.off, module.isupdateHistoryBorderOff = customoption.chiled("無効", updateHistoryBorder.name)
	updateHistoryBorder.on, module.isupdateHistoryBorderOn = customoption.chiled("有効", updateHistoryBorder.name)
	local charRotationSwitch = customoption.parent("キャラクターローテーション")
	charRotationSwitch.off, module.ischarRotationSwitchOff = customoption.chiled("無効", charRotationSwitch.name)
	charRotationSwitch.on, module.ischarRotationSwitchOn = customoption.chiled("有効（選択したキャラクターは無視されます）", charRotationSwitch.name)
	local bgRotationSwitch = customoption.parent("背景ローテーション")
	bgRotationSwitch.off, module.isbgRotationSwitchOff = customoption.chiled("無効", bgRotationSwitch.name)
	bgRotationSwitch.on, module.isbgRotationSwitchOn = customoption.chiled("有効（選択した背景は無視されます）", bgRotationSwitch.name)

	local clearRankParts = customoption.filepath("クリアランクイメージ", "Result/parts/rank/*.png")
	local irCoverParts = customoption.filepath("IRカバー", "Result/parts/irmask/*.png")
	local gaugeParts = customoption.filepath("ゲージ", "Result/parts/gauge/*.png")

	-- 背景
	local background = {}
	background.clear = customoption.filepath("背景（Clear）", "Result/parts/bg/isclear/clear/*.png")
	background.failed = customoption.filepath("背景（Failed）", "Result/parts/bg/isclear/failed/*.png")
	background.all = customoption.filepath("背景（ALL）", "Result/parts/bg/all/*.png")
	background.AAA = customoption.filepath("背景（AAA）", "Result/parts/bg/rank/AAA/*.png")
	background.AA = customoption.filepath("背景（AA）", "Result/parts/bg/rank/AA/*.png")
	background.A = customoption.filepath("背景（A）", "Result/parts/bg/rank/A/*.png")
	background.B = customoption.filepath("背景（B）", "Result/parts/bg/rank/B/*.png")
	background.C = customoption.filepath("背景（C）", "Result/parts/bg/rank/C/*.png")
	background.D = customoption.filepath("背景（D）", "Result/parts/bg/rank/D/*.png")
	background.E = customoption.filepath("背景（E）", "Result/parts/bg/rank/E/*.png")
	background.F = customoption.filepath("背景（F）", "Result/parts/bg/rank/F/*.png")
	background.failed2 = customoption.filepath("背景（Failed）", "Result/parts/bg/clearType/failed/*.png")
	background.assist = customoption.filepath("背景（Assist）", "Result/parts/bg/clearType/assist/*.png")
	background.laAssist = customoption.filepath("背景（LaAssist）", "Result/parts/bg/clearType/laassist/*.png")
	background.easy = customoption.filepath("背景（Easy）", "Result/parts/bg/clearType/easy/*.png")
	background.normal = customoption.filepath("背景（Normal and NoPlay）", "Result/parts/bg/clearType/normal/*.png")
	background.hard = customoption.filepath("背景（Hard）", "Result/parts/bg/clearType/hard/*.png")
	background.exhard = customoption.filepath("背景（Exhard）", "Result/parts/bg/clearType/exhard/*.png")
	background.fullcombo = customoption.filepath("背景（FullCombo）", "Result/parts/bg/clearType/fullcombo/*.png")
	background.perfect = customoption.filepath("背景（Perfect）", "Result/parts/bg/clearType/perfect/*.png")
	background.max = customoption.filepath("背景（Max）", "Result/parts/bg/clearType/max/*.png")

	-- 重ね絵
	local charBG = {}
	charBG.clear = customoption.filepath("キャラクター（Clear）", "Result/parts/char/isclear/clear/*.png")
	charBG.failed = customoption.filepath("キャラクター（Failed）", "Result/parts/char/isclear/failed/*.png")
	charBG.all = customoption.filepath("キャラクター（ALL）", "Result/parts/char/all/*.png")
	charBG.AAA = customoption.filepath("キャラクター（AAA）", "Result/parts/char/rank/AAA/*.png")
	charBG.AA = customoption.filepath("キャラクター（AA）", "Result/parts/char/rank/AA/*.png")
	charBG.A = customoption.filepath("キャラクター（A）", "Result/parts/char/rank/A/*.png")
	charBG.B = customoption.filepath("キャラクター（B）", "Result/parts/char/rank/B/*.png")
	charBG.C = customoption.filepath("キャラクター（C）", "Result/parts/char/rank/C/*.png")
	charBG.D = customoption.filepath("キャラクター（D）", "Result/parts/char/rank/D/*.png")
	charBG.E = customoption.filepath("キャラクター（E）", "Result/parts/char/rank/E/*.png")
	charBG.F = customoption.filepath("キャラクター（F）", "Result/parts/char/rank/F/*.png")
	charBG.failed2 = customoption.filepath("キャラクター（Failed）", "Result/parts/char/clearType/failed/*.png")
	charBG.assist = customoption.filepath("キャラクター（Assist）", "Result/parts/char/clearType/assist/*.png")
	charBG.laAssist = customoption.filepath("キャラクター（LaAssist）", "Result/parts/char/clearType/laassist/*.png")
	charBG.easy = customoption.filepath("キャラクター（Easy）", "Result/parts/char/clearType/easy/*.png")
	charBG.normal = customoption.filepath("キャラクター（Normal and NoPlay）", "Result/parts/char/clearType/normal/*.png")
	charBG.hard = customoption.filepath("キャラクター（Hard）", "Result/parts/char/clearType/hard/*.png")
	charBG.exhard = customoption.filepath("キャラクター（Exhard）", "Result/parts/char/clearType/exhard/*.png")
	charBG.fullcombo = customoption.filepath("キャラクター（FullCombo）", "Result/parts/char/clearType/fullcombo/*.png")
	charBG.perfect = customoption.filepath("キャラクター（Perfect）", "Result/parts/char/clearType/perfect/*.png")
	charBG.max = customoption.filepath("キャラクター（Max）", "Result/parts/char/clearType/max/*.png")

	-- オフセット関連
	local bgBrightness
	bgBrightness, module.offsetBgBrightness = customoption.offset("背景の明るさ 0~255 (255で真っ暗になります)")
	local charPosition
	charPosition, module.offsetCharPosition = customoption.offset("キャラクター表示位置調整")

	module.property = {
		--カスタムオプション定義
		{name = bitmapFont.name, def = bitmapFont.off.name, category = bitmapFont.label, item = {
			{name = bitmapFont.off.name, op = bitmapFont.off.num},
			{name = bitmapFont.on.name, op = bitmapFont.on.num},
		}},
		{name = mainmenuPosition.name, def = mainmenuPosition.left.name, category = mainmenuPosition.label, item = {
			{name = mainmenuPosition.left.name, op = mainmenuPosition.left.num},
			{name = mainmenuPosition.right.name, op = mainmenuPosition.right.num},
		}},
		{name = showItem.name, def = showItem.combo.name, category = showItem.label, item = {
			{name = showItem.combo.name, op = showItem.combo.num},
			{name = showItem.misscount.name, op = showItem.misscount.num},
		}},
		{name = irMenuSwitch.name, def = irMenuSwitch.on.name, category = irMenuSwitch.label, item = {
			{name = irMenuSwitch.off.name, op = irMenuSwitch.off.num},
			{name = irMenuSwitch.on.name, op = irMenuSwitch.on.num},
		}},
		{name = irMenuPattern.name, def = irMenuPattern.top10.name, category = irMenuPattern.label, item = {
			{name = irMenuPattern.top10.name, op = irMenuPattern.top10.num},
			{name = irMenuPattern.clear.name, op = irMenuPattern.clear.num},
		}},
		{name = startAnimation.name, def = startAnimation.on.name, category = startAnimation.label, item = {
			{name = startAnimation.off.name, op = startAnimation.off.num},
			{name = startAnimation.on.name, op = startAnimation.on.num},
		}},
		{name = timeStamp.name, def = timeStamp.on.name, category = timeStamp.label, item = {
			{name = timeStamp.off.name, op = timeStamp.off.num},
			{name = timeStamp.on.name, op = timeStamp.on.num},
		}},
		{name = beam.name, def = beam.on.name, category = beam.label, item = {
			{name = beam.off.name, op = beam.off.num},
			{name = beam.on.name, op = beam.on.num},
		}},
		{name = ring.name, def = ring.on.name, category = ring.label, item = {
			{name = ring.off.name, op = ring.off.num},
			{name = ring.on.name, op = ring.on.num},
		}},
		{name = charSwitch.name, def = charSwitch.on.name, category = charSwitch.label, item = {
			{name = charSwitch.off.name, op = charSwitch.off.num},
			{name = charSwitch.on.name, op = charSwitch.on.num},
		}},
		{name = clearRankPattern.name, def = clearRankPattern.fadeout.name, category = clearRankPattern.label, item = {
			{name = clearRankPattern.fadeout.name, op = clearRankPattern.fadeout.num},
			{name = clearRankPattern.fluffy.name, op = clearRankPattern.fluffy.num},
		}},
		{name = updateHistory.name, def = updateHistory.off.name, category = updateHistory.label, item = {
			{name = updateHistory.off.name, op = updateHistory.off.num},
			{name = updateHistory.on.name, op = updateHistory.on.num},
		}},
		{name = updateHistoryBorder.name, def = updateHistoryBorder.off.name, category = updateHistoryBorder.label, item = {
			{name = updateHistoryBorder.off.name, op = updateHistoryBorder.off.num},
			{name = updateHistoryBorder.on.name, op = updateHistoryBorder.on.num},
		}},
		{name = charRotationSwitch.name, def = charRotationSwitch.off.name, category = charRotationSwitch.label, item = {
			{name = charRotationSwitch.off.name, op = charRotationSwitch.off.num},
			{name = charRotationSwitch.on.name, op = charRotationSwitch.on.num}
		}},
		{name = bgRotationSwitch.name, def = bgRotationSwitch.off.name, category = bgRotationSwitch.label, item = {
			{name = bgRotationSwitch.off.name, op = bgRotationSwitch.off.num},
			{name = bgRotationSwitch.on.name, op = bgRotationSwitch.on.num}
		}},
	}

	module.filepath = {
		{name = clearRankParts.name, path = clearRankParts.path, category = clearRankParts.label, def = "#default"},
		{name = irCoverParts.name, path = irCoverParts.path, category = irCoverParts.label, def = "#default"},
		{name = gaugeParts.name, path = gaugeParts.path, category = gaugeParts.label, def = "#default"},
		{name = background.clear.name, path = background.clear.path, category = background.clear.label, def = "#default"},
		{name = background.failed.name, path = background.failed.path, category = background.failed.label, def = "#default"},
		{name = background.all.name, path = background.all.path, category = background.all.label, def = "#default"},
		{name = background.AAA.name, path = background.AAA.path, category = background.AAA.label, def = "#default"},
		{name = background.AA.name, path = background.AA.path, category = background.AA.label, def = "#default"},
		{name = background.A.name, path = background.A.path, category = background.A.label, def = "#default"},
		{name = background.B.name, path = background.B.path, category = background.B.label, def = "#default"},
		{name = background.C.name, path = background.C.path, category = background.C.label, def = "#default"},
		{name = background.D.name, path = background.D.path, category = background.D.label, def = "#default"},
		{name = background.E.name, path = background.E.path, category = background.E.label, def = "#default"},
		{name = background.F.name, path = background.F.path, category = background.F.label, def = "#default"},

		{name = charBG.clear.name, path = charBG.clear.path, category = charBG.clear.label, def = "yuki"},
		{name = charBG.failed.name, path = charBG.failed.path, category = charBG.failed.label, def = "yuki"},
		{name = charBG.all.name, path = charBG.all.path, category = charBG.all.label, def = "#default"},
		{name = charBG.AAA.name, path = charBG.AAA.path, category = charBG.AAA.label, def = "#default"},
		{name = charBG.AA.name, path = charBG.AA.path, category = charBG.AA.label, def = "#default"},
		{name = charBG.A.name, path = charBG.A.path, category = charBG.A.label, def = "#default"},
		{name = charBG.B.name, path = charBG.B.path, category = charBG.B.label, def = "#default"},
		{name = charBG.C.name, path = charBG.C.path, category = charBG.C.label, def = "#default"},
		{name = charBG.D.name, path = charBG.D.path, category = charBG.D.label, def = "#default"},
		{name = charBG.E.name, path = charBG.E.path, category = charBG.E.label, def = "#default"},
		{name = charBG.F.name, path = charBG.F.path, category = charBG.F.label, def = "#default"},
	}

	-- offsetのユーザー定義は40以降
	module.offset = {
		{name = bgBrightness.name, category = bgBrightness.label, id = bgBrightness.num, a = 0},
		{name = charPosition.name, category = charPosition.label, id = charPosition.num, x = 0, y = 0},
	}

	--[[
		カスタムオプション、ファイルパス、オフセットを関連付け
	]]
	module.category = {
		--カスタムオプション定義
		{name = "メインオプション", item = {
			bitmapFont.label,
			mainmenuPosition.label,
			showItem.label,
			startAnimation.label,
			timeStamp.label,
			beam.label,
			ring.label,
			gaugeParts.label
		}},
		{name = "プレイ履歴保存機能", item = {
			updateHistory.label,
			updateHistoryBorder.label
		}},
		{name = "クリアランクイメージ", item = {
			clearRankPattern.label,
			clearRankParts.label
		}},
		{name = "背景パターン", item = {
			bgPattern.label,
			bgRotationSwitch.label,
			bgBrightness.label
		}},
		{name = "背景選択（Clear or Failed）", item = {
			background.clear.label,
			background.failed.label
		}},
		{name = "背景選択（ALL）", item = {
			background.all.label
		}},
		{name = "背景選択（Rank）", item = {
			background.AAA.label,
			background.AA.label,
			background.A.label,
			background.B.label,
			background.C.label,
			background.D.label,
			background.E.label,
			background.F.label
		}},
		{name = "キャラクター表示", item = {
			charSwitch.label,
			charPattern.label,
			charRotationSwitch.label,
			charPosition.label
		}},
		{name = "キャラクター選択（Clear or Failed）", item = {
			charBG.clear.label,
			charBG.failed.label
		}},
		{name = "キャラクター選択（ALL）", item = {
			charBG.all.label
		}},
		{name = "キャラクター選択（Rank）", item = {
			charBG.AAA.label,
			charBG.AA.label,
			charBG.A.label,
			charBG.B.label,
			charBG.C.label,
			charBG.D.label,
			charBG.E.label,
			charBG.F.label
		}},
		{name = "IRメニュー", item = {
			irMenuSwitch.label,
			irMenuPattern.label,
			irCoverParts.label
		}}
	}

	if isResult then
		-- 通常リザルト
		table.insert(module.property, {
			name = bgPattern.name, def = bgPattern.cf.name, category = bgPattern.label, item = {
				{name = bgPattern.cf.name, op = bgPattern.cf.num},
				{name = bgPattern.all.name, op = bgPattern.all.num},
				{name = bgPattern.rank.name, op = bgPattern.rank.num},
				{name = bgPattern.clearType.name, op = bgPattern.clearType.num},
			}
		})
		-- キャラ表示パターン
		table.insert(module.property, {
			name = charPattern.name, def = charPattern.cf.name, category = charPattern.label, item = {
				{name = charPattern.cf.name, op = charPattern.cf.num},
				{name = charPattern.all.name, op = charPattern.all.num},
				{name = charPattern.rank.name, op = charPattern.rank.num},
				{name = charPattern.clearType.name, op = charPattern.clearType.num},
			}
		})
		-- ステージファイル表示
		table.insert(module.property, {
			name = stageFile.name, def = stageFile.off.name, category = stageFile.label, item = {
				{name = stageFile.off.name, op = stageFile.off.num},
				{name = stageFile.on.name, op = stageFile.on.num},
			}
		})
		-- タイミンググラフ倍率
		table.insert(module.property, {
			name = TDGMagnificationPattern.name, def = TDGMagnificationPattern.normal.name, category = TDGMagnificationPattern.label, item = {
				{name = TDGMagnificationPattern.low.name, op = TDGMagnificationPattern.low.num},
				{name = TDGMagnificationPattern.normal.name, op = TDGMagnificationPattern.normal.num},
				{name = TDGMagnificationPattern.high.name, op = TDGMagnificationPattern.high.num},
			}
		})
		-- タイミンググラフ配色
		table.insert(module.property, {
			name = TDGColorPattern.name, def = TDGColorPattern.normal.name, category = TDGColorPattern.label, item = {
				{name = TDGColorPattern.normal.name, op = TDGColorPattern.normal.num},
				{name = TDGColorPattern.red.name, op = TDGColorPattern.red.num},
				{name = TDGColorPattern.green.name, op = TDGColorPattern.green.num},
				{name = TDGColorPattern.blue.name, op = TDGColorPattern.blue.num},
			}
		})

		table.insert(module.filepath, {name = background.failed2.name, path = background.failed2.path, category = background.failed2.label, def = "#default"})
		table.insert(module.filepath, {name = background.assist.name, path = background.assist.path, category = background.assist.label, def = "#default"})
		table.insert(module.filepath, {name = background.laAssist.name, path = background.laAssist.path, category = background.laAssist.label, def = "#default"})
		table.insert(module.filepath, {name = background.easy.name, path = background.easy.path, category = background.easy.label, def = "#default"})
		table.insert(module.filepath, {name = background.normal.name, path = background.normal.path, category = background.normal.label, def = "#default"})
		table.insert(module.filepath, {name = background.hard.name, path = background.hard.path, category = background.hard.label, def = "#default"})
		table.insert(module.filepath, {name = background.exhard.name, path = background.exhard.path, category = background.exhard.label, def = "#default"})
		table.insert(module.filepath, {name = background.fullcombo.name, path = background.fullcombo.path, category = background.fullcombo.label, def = "#default"})
		table.insert(module.filepath, {name = background.perfect.name, path = background.perfect.path, category = background.perfect.label, def = "#default"})
		table.insert(module.filepath, {name = background.max.name, path = background.max.path, category = background.max.label, def = "#default"})

		table.insert(module.filepath, {name = charBG.failed2.name, path = charBG.failed2.path, category = charBG.failed2.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.assist.name, path = charBG.assist.path, category = charBG.assist.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.laAssist.name, path = charBG.laAssist.path, category = charBG.laAssist.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.easy.name, path = charBG.easy.path, category = charBG.easy.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.normal.name, path = charBG.normal.path, category = charBG.normal.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.hard.name, path = charBG.hard.path, category = charBG.hard.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.exhard.name, path = charBG.exhard.path, category = charBG.exhard.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.fullcombo.name, path = charBG.fullcombo.path, category = charBG.fullcombo.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.perfect.name, path = charBG.perfect.path, category = charBG.perfect.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.max.name, path = charBG.max.path, category = charBG.max.label, def = "#default"})

		table.insert(module.category, 7, {
			name = "背景選択（ClearType）", item = {
				background.failed2.label,
				background.assist.label,
				background.laAssist.label,
				background.easy.label,
				background.normal.label,
				background.hard.label,
				background.exhard.label,
				background.fullcombo.label,
				background.perfect.label,
				background.max.label
			}
		})
		table.insert(module.category, 12, {
			name = "キャラクター選択（ClearType）", item = {
				charBG.failed2.label,
				charBG.assist.label,
				charBG.laAssist.label,
				charBG.easy.label,
				charBG.normal.label,
				charBG.hard.label,
				charBG.exhard.label,
				charBG.fullcombo.label,
				charBG.perfect.label,
				charBG.max.label
			}
		})
		table.insert(module.category, {
			name = "ステージファイル表示", item = {
				stageFile.label
			}
		})
		table.insert(module.category, {
			name = "グラフ関連", item = {
				TDGMagnificationPattern.label,
				TDGColorPattern.label
			}
		})
	else
		-- コースリザルト
		table.insert(module.property, {
			name = bgPattern.name, def = bgPattern.cf.name, category = bgPattern.label, item = {
				{name = bgPattern.cf.name, op = bgPattern.cf.num},
				{name = bgPattern.all.name, op = bgPattern.all.num},
				{name = bgPattern.rank.name, op = bgPattern.rank.num},
			}
		})
		table.insert(module.property, {
			name = charPattern.name, def = charPattern.cf.name, category = charPattern.label, item = {
				{name = charPattern.cf.name, op = charPattern.cf.num},
				{name = charPattern.all.name, op = charPattern.all.num},
				{name = charPattern.rank.name, op = charPattern.rank.num},
			}
		})
	end

	if DEBUG then
		print("リザルトカスタムオプション最大値：" ..customoptionNumber .."\nリザルトカテゴリ最大値：" ..categoryNumber .."\nリザルトオフセット最大値：" ..offsetNumber)
	end

	return module
end

return{
	load = load
}