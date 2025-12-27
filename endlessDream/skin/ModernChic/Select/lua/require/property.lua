--[[
	初期値
	カスタムオプション：900-999
	オフセット：40-
	@author : KASAKO
]]
local module = {}

local customoptionNumber = 899
local categoryNumber = 0
local offsetNumber = 39

-- カテゴリナンバーの付与
local function addCategoryNumber()
	categoryNumber = categoryNumber + 1
	return categoryNumber
end

-- カスタムオプションナンバーの付与
local function addCustomoptionNumber()
	customoptionNumber = customoptionNumber + 1
	if customoptionNumber > 999 then
		print("カスタムナンバーが上限を超えています")
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

local bgPattern = customoption.parent("背景の種類")
bgPattern.image, module.isBgImage = customoption.chiled("静止画", bgPattern.name)
bgPattern.movie, module.isBgMovie = customoption.chiled("動画", bgPattern.name)
local bitmapFont = customoption.parent("画像フォント")
bitmapFont.off, module.isOutlineFont = customoption.chiled("無効", bitmapFont.name)
bitmapFont.on, module.isBitmapFont = customoption.chiled("有効（高負荷）", bitmapFont.name)
local extendFiles = customoption.parent("ステージ＆バナーファイル")
extendFiles.both, module.isStagefileTypeA = customoption.chiled("両方表示", extendFiles.name)
extendFiles.full, module.isStagefileTypeB = customoption.chiled("ステージファイルをフルサイズ表示", extendFiles.name)
local listPattern = customoption.parent("曲リストの並び")
listPattern.straight, module.isSonglistStraight = customoption.chiled("直線", listPattern.name)
listPattern.arch, module.isSonglistArch = customoption.chiled("曲線", listPattern.name)
listPattern.diagonal, module.isSonglistDiagonally = customoption.chiled("斜め", listPattern.name)
local subtitleScroll = customoption.parent("サブタイトルのスクロール")
subtitleScroll.off, module.isSubtitleScrollOff = customoption.chiled("無効", subtitleScroll.name)
subtitleScroll.on, module.isSubtitleScrollOn = customoption.chiled("有効", subtitleScroll.name)
local beam = customoption.parent("ビーム（装飾）")
beam.off, module.isIlluminationOff = customoption.chiled("無効", beam.name)
beam.on, module.isIlluminationOn = customoption.chiled("有効", beam.name)
local startAnimation = customoption.parent("開始パターン")
startAnimation.fadein, module.isStartFadein = customoption.chiled("フェードイン", startAnimation.name)
startAnimation.shutter, module.isStartShutter = customoption.chiled("シャッター", startAnimation.name)
local rateSwitch = customoption.parent("IR情報表示")
rateSwitch.cfrate, module.isIrClearrateFullcomborate = customoption.chiled("クリアレート&フルコンボレート", rateSwitch.name)
rateSwitch.ranking, module.isIrRanking = customoption.chiled("ランキング", rateSwitch.name)
local sidemenuRetentionSwitch = customoption.parent("サイドメニューの開閉状態を保持する")
sidemenuRetentionSwitch.off, module.isSideMenuRetentionOff = customoption.chiled("無効", sidemenuRetentionSwitch.name)
sidemenuRetentionSwitch.on, module.isSideMenuRetentionOn = customoption.chiled("有効", sidemenuRetentionSwitch.name)
local skinCheck = customoption.parent("スキン更新チェック")
skinCheck.off, module.isCheckNewVersionOff = customoption.chiled("無効", skinCheck.name)
skinCheck.on, module.isCheckNewVersionOn = customoption.chiled("有効", skinCheck.name)
local language = customoption.parent("言語")
language.jpn, module.isLanguageJPN = customoption.chiled("日本語", language.name)
language.en, module.isLanguageEN = customoption.chiled("English", language.name)
language.cn, module.isLanguageCN = customoption.chiled("Chinese", language.name)
local viewHistory = customoption.parent("プレイ履歴表示")
viewHistory.off, module.isviewHistoryOff = customoption.chiled("無効", viewHistory.name)
viewHistory.on, module.isviewHistoryOn = customoption.chiled("有効", viewHistory.name)
local keymap = customoption.parent("キーマップ表示")
keymap.off, module.iskeymapOff = customoption.chiled("無効", keymap.name)
keymap.on, module.iskeymapOn = customoption.chiled("有効", keymap.name)
local bgRotation = customoption.parent("背景ローテーション")
bgRotation.off, module.isbgRotationOff = customoption.chiled("無効", bgRotation.name)
bgRotation.on, module.isbgRotationOn = customoption.chiled("有効（選択した背景は無視されます）", bgRotation.name)
local ischarAnimation = customoption.parent("BPM連動キャラクター")
ischarAnimation.off, module.isCharAnimationOff = customoption.chiled("無効", ischarAnimation.name)
ischarAnimation.on, module.isCharAnimationOn = customoption.chiled("有効", ischarAnimation.name)

local bgImage = customoption.filepath("背景（静止画）Select/bg/image/*.png", "Select/bg/image/*.png")
local bgMovie = customoption.filepath("背景（動画）Select/bg/movie/*.mp4", "Select/bg/movie/*.mp4")
local animationChar = customoption.filepath("BPM連動キャラクター Root/image","Root/image/*.png")

local bgBrightness
bgBrightness, module.offsetBgBrightness = customoption.offset("背景の明るさ 0~255 (255で真っ暗になります)")

module.property = {
	-- カスタムオプション定義
	{name = bgPattern.name, def = bgPattern.image.name, category = bgPattern.label, item = {
		{name = bgPattern.image.name, op = bgPattern.image.num},
		{name = bgPattern.movie.name, op = bgPattern.movie.num},
	}},
	{name = bitmapFont.name, def = bitmapFont.off.name, category = bitmapFont.label, item = {
		{name = bitmapFont.off.name, op = bitmapFont.off.num},
		{name = bitmapFont.on.name, op = bitmapFont.on.num},
	}},
	{name = extendFiles.name, def = extendFiles.both.name, category = extendFiles.label, item = {
		{name = extendFiles.both.name, op = extendFiles.both.num},
		{name = extendFiles.full.name, op = extendFiles.full.num},
	}},
	{name = listPattern.name, def = listPattern.straight.name, category = listPattern.label, item = {
		{name = listPattern.straight.name, op = listPattern.straight.num},
		{name = listPattern.arch.name, op = listPattern.arch.num},
		{name = listPattern.diagonal.name, op = listPattern.diagonal.num},
	}},
	{name = subtitleScroll.name, def = subtitleScroll.on.name, category = subtitleScroll.label, item = {
		{name = subtitleScroll.off.name, op = subtitleScroll.off.num},
		{name = subtitleScroll.on.name, op = subtitleScroll.on.num},
	}},
	{name = beam.name, def = beam.on.name, category = beam.label, item = {
		{name = beam.off.name, op = beam.off.num},
		{name = beam.on.name, op = beam.on.num},
	}},
	{name = startAnimation.name, def = startAnimation.fadein.name, category = startAnimation.label, item = {
		{name = startAnimation.fadein.name, op = startAnimation.fadein.num},
		{name = startAnimation.shutter.name, op = startAnimation.shutter.num},
	}},
	{name = rateSwitch.name, def = rateSwitch.cfrate.name, category = rateSwitch.label, item = {
		{name = rateSwitch.cfrate.name, op = rateSwitch.cfrate.num},
		{name = rateSwitch.ranking.name, op = rateSwitch.ranking.num},
	}},
	{name = sidemenuRetentionSwitch.name, def = sidemenuRetentionSwitch.off.name, category = sidemenuRetentionSwitch.label, item = {
		{name = sidemenuRetentionSwitch.off.name, op = sidemenuRetentionSwitch.off.num},
		{name = sidemenuRetentionSwitch.on.name, op = sidemenuRetentionSwitch.on.num},
	}},
	{name = skinCheck.name, def = skinCheck.on.name, category = skinCheck.label, item = {
		{name = skinCheck.off.name, op = skinCheck.off.num},
		{name = skinCheck.on.name, op = skinCheck.on.num},
	}},
	{name = language.name, def = language.jpn.name, category = language.label, item = {
		{name = language.jpn.name, op = language.jpn.num},
		{name = language.en.name, op = language.en.num},
		{name = language.cn.name, op = language.cn.num},
	}},
	{name = viewHistory.name, def = viewHistory.off.name, category = viewHistory.label, item = {
		{name = viewHistory.off.name, op = viewHistory.off.num},
		{name = viewHistory.on.name, op = viewHistory.on.num},
	}},
	{name = keymap.name, def = keymap.on.name, category = keymap.label, item = {
		{name = keymap.off.name, op = keymap.off.num},
		{name = keymap.on.name, op = keymap.on.num},
	}},
	{name = bgRotation.name, def = bgRotation.off.name, category = bgRotation.label, item = {
		{name = bgRotation.off.name, op = bgRotation.off.num},
		{name = bgRotation.on.name, op = bgRotation.on.num},
	}},
	{name = ischarAnimation.name, def = ischarAnimation.on.name, category = ischarAnimation.label, item = {
		{name = ischarAnimation.off.name, op = ischarAnimation.off.num},
		{name = ischarAnimation.on.name, op = ischarAnimation.on.num},
	}},
}

module.filepath = {
	{name = bgImage.name, path = bgImage.path, category = bgImage.label, def = "#default"},
	{name = bgMovie.name, path = bgMovie.path, category = bgMovie.label, def = "BGmovie01"},
	{name = animationChar.name, path = animationChar.path, category = animationChar.label, def = "yuki"},
}

-- offsetのユーザー定義は40以降
module.offset = {
	{name = bgBrightness.name, category = bgBrightness.label, id = bgBrightness.num, a = 0},
}

--[[
	カスタムカテゴリ
	カスタムオプション、ファイルパス、オフセットを関連付け
]]
module.category = {
	--カスタムオプション定義
	{name = "メインオプション", item = {
		language.label,
		bitmapFont.label,
		extendFiles.label,
		listPattern.label,
		subtitleScroll.label,
		keymap.label,
		beam.label,
		startAnimation.label,
		rateSwitch.label,
		sidemenuRetentionSwitch.label,
		skinCheck.label
	}},
	{name = "BPM連動キャラクター", item = {
		ischarAnimation.label,
		animationChar.label
	}},
	{name = "プレイ履歴表示（ModernChicResultスキンの使用と『プレイ履歴の保存』を有効にする必要があります。）", item = {
		viewHistory.label
	}},
	{name = "背景", item = {
		bgPattern.label,
		bgImage.label,
		bgMovie.label,
		bgRotation.label,
		bgBrightness.label
	}},
}

if DEBUG then
	print("セレクトカスタムオプション最大値：" ..customoptionNumber .."\nセレクトカテゴリ最大値：" ..categoryNumber .."\nセレクトオフセット最大値：" ..offsetNumber)
end

return module