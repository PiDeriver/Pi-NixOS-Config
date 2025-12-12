--[[
	DP用（10鍵、14鍵）用プロパティ
	@author : KASAKO
]]
local module = {}

--[[
	初期値
	カスタムオプション：900-999
	オフセット：40-
]]
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

local function load(is10keys)
	local targetSwitch = customoption.parent("ターゲット差分")
	targetSwitch.off, module.isDiffTargetOff = customoption.chiled("非表示", targetSwitch.name)
	targetSwitch.on, module.isDiffTargetOn = customoption.chiled("表示", targetSwitch.name)
	local targetPattern = customoption.parent("ターゲット差分の種類")
	targetPattern.rank, module.isTargetRank = customoption.chiled("目標ランク", targetPattern.name)
	targetPattern.mybest, module.isTargetMybest = customoption.chiled("自己ベスト", targetPattern.name)
	local targetPosition = customoption.parent("ターゲット差分表示位置")
	targetPosition.typeA, module.isDiffTargetTypeA = customoption.chiled("TYPE-A(判定文字上)", targetPosition.name)
	targetPosition.typeB, module.isDiffTargetTypeB = customoption.chiled("TYPE-B（判定文字横・外側）", targetPosition.name)
	targetPosition.typeC, module.isDiffTargetTypeC = customoption.chiled("TYPE-C（判定文字横・内側）", targetPosition.name)
	local judgetimingSwitch = customoption.parent("判定タイミング")
	judgetimingSwitch.off, module.isJudgeTimingOff = customoption.chiled("非表示", judgetimingSwitch.name)
	judgetimingSwitch.on, module.isJudgeTimingOn = customoption.chiled("表示", judgetimingSwitch.name)
	local judgetimingPattern = customoption.parent("判定タイミングの種類")
	judgetimingPattern.typeA, module.isJudgeTimingWord = customoption.chiled("FAST/SLOW", judgetimingPattern.name)
	judgetimingPattern.typeB, module.isJudgeTimingMs = customoption.chiled("+-ms", judgetimingPattern.name)
	local judgetimingPosition = customoption.parent("判定タイミング表示位置")
	judgetimingPosition.typeA, module.isJudgeTimingTypeA = customoption.chiled("TYPE-A(判定文字上)", judgetimingPosition.name)
	judgetimingPosition.typeB, module.isJudgeTimingTypeB = customoption.chiled("TYPE-B（判定文字横・外側）", judgetimingPosition.name)
	judgetimingPosition.typeC, module.isJudgeTimingTypeC = customoption.chiled("TYPE-C（判定文字横・内側）", judgetimingPosition.name)
	local timingBomb = customoption.parent("判定タイミングボム")
	timingBomb.off, module.isJudgeTimingBombOff = customoption.chiled("無効", timingBomb.name)
	timingBomb.on, module.isJudgeTimingBombOn = customoption.chiled("使う（早いか遅いかでボムの色が変化します）", timingBomb.name)
	local bombPattern = customoption.parent("ボムの種類")
	bombPattern.modernchic, module.isModernChicBomb = customoption.chiled("ModernChic規格", bombPattern.name)
	bombPattern.oadx, module.isOADXBomb = customoption.chiled("OADX規格", bombPattern.name)
	local graphPosition = customoption.parent("グラフバー表示位置")
	graphPosition.left, module.isGraphPositionLeft = customoption.chiled("左", graphPosition.name)
	graphPosition.right, module.isGraphPositionRight = customoption.chiled("右", graphPosition.name)
	graphPosition.none, module.isGraphareaNone = customoption.chiled("無効", graphPosition.name)
	local playPosition = customoption.parent("プレイ位置")
	playPosition.left, module.isLeftPosition = customoption.chiled("左側表示", playPosition.name)
	playPosition.center, module.isCenterPosition = customoption.chiled("中央表示", playPosition.name)
	playPosition.right, module.isRightPosition = customoption.chiled("右側表示", playPosition.name)
	local bitmapFont = customoption.parent("画像フォント")
	bitmapFont.off, module.isOutlineFont = customoption.chiled("無効", bitmapFont.name)
	bitmapFont.on, module.isBitmapFont = customoption.chiled("有効（高負荷）", bitmapFont.name)
	local glowlampSwitch = customoption.parent("グローランプ")
	glowlampSwitch.off, module.isGlowlampOff = customoption.chiled("非表示", glowlampSwitch.name)
	glowlampSwitch.on, module.isGlowlampOn = customoption.chiled("表示", glowlampSwitch.name)
	local indicatorSwitch = customoption.parent("ゲージMAXインジケータ")
	indicatorSwitch.off, module.isGaugeMaxIndicatorOff = customoption.chiled("非表示", indicatorSwitch.name)
	indicatorSwitch.on, module.isGaugeMaxIndicatorOn = customoption.chiled("表示", indicatorSwitch.name)
	local gaugeSwitch = customoption.parent("ゲージ")
	gaugeSwitch.off, module.isGaugeCoverOff = customoption.chiled("表示", gaugeSwitch.name)
	gaugeSwitch.on, module.isGaugeCoverOn = customoption.chiled("非表示", gaugeSwitch.name)

	local notesDistributionSwitch = customoption.parent("ノート分布")
	notesDistributionSwitch.off, module.isnotesDistributionCoverOff = customoption.chiled("表示", notesDistributionSwitch.name)
	notesDistributionSwitch.on, module.isnotesDistributionCoverOn = customoption.chiled("非表示", notesDistributionSwitch.name)
	local notesDistributionPattern = customoption.parent("ノート分布パターン")
	notesDistributionPattern.typeA, module.isnotesDistributionTypeA = customoption.chiled("判定", notesDistributionPattern.name)
	notesDistributionPattern.typeB, module.isnotesDistributionTypeB = customoption.chiled("FAST/SLOW", notesDistributionPattern.name)
	notesDistributionPattern.typeC, module.isnotesDistributionTypeC = customoption.chiled("ノート", notesDistributionPattern.name)

	local timinggraphSwitch = customoption.parent("タイミンググラフ")
	timinggraphSwitch.off, module.isTiminggraphCoverOff = customoption.chiled("表示", timinggraphSwitch.name)
	timinggraphSwitch.on, module.isTiminggraphCoverOn = customoption.chiled("非表示", timinggraphSwitch.name)
	local timinggraphDisplayPattern = customoption.parent("タイミンググラフ表示位置")
	timinggraphDisplayPattern.typeA, module.isTiminggraphDisplayTypeA = customoption.chiled("BGA側", timinggraphDisplayPattern.name)
	timinggraphDisplayPattern.typeB, module.isTiminggraphDisplayTypeB = customoption.chiled("プレイエリア側", timinggraphDisplayPattern.name)
	local timinggraphMagnification = customoption.parent("タイミンググラフ倍率")
	timinggraphMagnification.low, module.isTiminggraphMagnificationLow = customoption.chiled("低倍率（+-225ms）", timinggraphMagnification.name)
	timinggraphMagnification.normal, module.isTiminggraphMagnificationNormal = customoption.chiled("標準倍率（+-150ms）", timinggraphMagnification.name)
	timinggraphMagnification.high, module.isTiminggraphMagnificationHigh = customoption.chiled("高倍率（+-75ms）", timinggraphMagnification.name)
	local timinggraphColorPattern = customoption.parent("タイミンググラフ配色パターン")
	timinggraphColorPattern.normal, module.isTiminggraphColorNormal = customoption.chiled("通常", timinggraphColorPattern.name)
	timinggraphColorPattern.red, module.isTiminggraphColorRed = customoption.chiled("赤基調", timinggraphColorPattern.name)
	timinggraphColorPattern.green, module.isTiminggraphColorGreen = customoption.chiled("緑基調", timinggraphColorPattern.name)
	timinggraphColorPattern.blue, module.isTiminggraphColorBlue = customoption.chiled("青基調", timinggraphColorPattern.name)
	local HitErrorVisualizerPattern = customoption.parent("ヒットエラービジュアライザーパターン")
	HitErrorVisualizerPattern.normal, module.isHitErrorVisualizerPatternNormal = customoption.chiled("通常", HitErrorVisualizerPattern.name)
	HitErrorVisualizerPattern.triangle, module.isHitErrorVisualizerPatternTriangle = customoption.chiled("三角", HitErrorVisualizerPattern.name)
	HitErrorVisualizerPattern.emphasis, module.isHitErrorVisualizerPatternEmphasis = customoption.chiled("強調", HitErrorVisualizerPattern.name)

	local infomationSwitch = customoption.parent("オートプレイ＆リプレイ時の案内")
	infomationSwitch.off, module.isAutoplayInfoOff = customoption.chiled("非表示", infomationSwitch.name)
	infomationSwitch.on, module.isAutoplayInfoOn = customoption.chiled("表示", infomationSwitch.name)
	local tenkeysCoverSwitch = customoption.parent("10鍵用レーンカバー（10鍵モード時のみ）")
	tenkeysCoverSwitch.off, module.is10keyLanecoverOff = customoption.chiled("非表示", tenkeysCoverSwitch.name)
	tenkeysCoverSwitch.on, module.is10keyLanecoverOn = customoption.chiled("表示", tenkeysCoverSwitch.name)
	local keybeamHeight = customoption.parent("キービームの高さ")
	keybeamHeight.size100, module.isBeamHeight100 = customoption.chiled("100%", keybeamHeight.name)
	keybeamHeight.size90, module.isBeamHeight90 = customoption.chiled("90%", keybeamHeight.name)
	keybeamHeight.size80, module.isBeamHeight80 = customoption.chiled("80%", keybeamHeight.name)
	keybeamHeight.size70, module.isBeamHeight70 = customoption.chiled("70%", keybeamHeight.name)
	keybeamHeight.size60, module.isBeamHeight60 = customoption.chiled("60%", keybeamHeight.name)
	keybeamHeight.size50, module.isBeamHeight50 = customoption.chiled("50%（短い）", keybeamHeight.name)
	keybeamHeight.size40, module.isBeamHeight40 = customoption.chiled("40%", keybeamHeight.name)
	keybeamHeight.size30, module.isBeamHeight30 = customoption.chiled("30%（とても短い）", keybeamHeight.name)
	keybeamHeight.size20, module.isBeamHeight20 = customoption.chiled("20%", keybeamHeight.name)
	keybeamHeight.size10, module.isBeamHeight10 = customoption.chiled("10%", keybeamHeight.name)
	local keybeamDisappearanceTime = customoption.parent("キービームの消失時間")
	keybeamDisappearanceTime.normal, module.isBeamDisappearanceTimeNormal = customoption.chiled("通常", keybeamDisappearanceTime.name)
	keybeamDisappearanceTime.short, module.isBeamDisappearanceTimeShort = customoption.chiled("短い", keybeamDisappearanceTime.name)
	keybeamDisappearanceTime.long, module.isBeamDisappearanceTimeLong = customoption.chiled("長い", keybeamDisappearanceTime.name)
	local keybeamDisappearancePattern = customoption.parent("キービームの消失パターン")
	keybeamDisappearancePattern.typeL, module.isBeamDisappearanceTypeL = customoption.chiled("TYPE-L", keybeamDisappearancePattern.name)
	keybeamDisappearancePattern.typeB, module.isBeamDisappearanceTypeB = customoption.chiled("TYPE-B", keybeamDisappearancePattern.name)
	local gaugeStretchDirection = customoption.parent("グルーヴゲージの向き")
	gaugeStretchDirection.right, module.isGaugeStretchDirectionRight = customoption.chiled("右方向", gaugeStretchDirection.name)
	gaugeStretchDirection.left, module.isGaugeStretchDirectionLeft = customoption.chiled("左方向", gaugeStretchDirection.name)
	local bgaPattern = customoption.parent("BGA表示パターン")
	bgaPattern.typeA, module.isBgaPattern1_1 = customoption.chiled("1:1", bgaPattern.name)
	bgaPattern.typeB, module.isBgaPattern16_9 = customoption.chiled("16:9", bgaPattern.name)
	bgaPattern.typeC, module.isNoBGA = customoption.chiled("無効", bgaPattern.name)
	local lanecoverRotationSwitch = customoption.parent("左右のレーンカバーをローテーション表示")
	lanecoverRotationSwitch.off, module.islanecoverRotationSwitchOff = customoption.chiled("無効", lanecoverRotationSwitch.name)
	lanecoverRotationSwitch.on, module.islanecoverRotationSwitchOn = customoption.chiled("有効（選択したレーンカバーは無視されます）", lanecoverRotationSwitch.name)
	local finishCoverSwitch = customoption.parent("終了時にレーンカバーを下ろす")
	finishCoverSwitch.off, module.isFinishCoverOff = customoption.chiled("無効", finishCoverSwitch.name)
	finishCoverSwitch.on, module.isFinishCoverOn = customoption.chiled("有効", finishCoverSwitch.name)

	-- ファイルパス
	local bg = customoption.filepath("背景", "Play/parts/common/bg/*.png")
	local graphBg = customoption.filepath("グラフバー用背景", "Play/parts/dp_hw/graphbg/*.png")
	local notesParts = customoption.filepath("ノーツ", "Play/parts/common/notes/*.png")
	local judgeParts = customoption.filepath("判定文字", "Play/parts/common/judge/*.png")
	local lanecoverParts = customoption.filepath("レーンカバー", "Play/parts/common/lanecover/*.png")
	local liftParts = customoption.filepath("リフトカバー", "Play/parts/dp_hw/lift/*.png")
	local modernchicBomb = customoption.filepath("ボム（ModernChic規格）", "Play/parts/common/bomb/*.png")
	local oadxBomb = customoption.filepath("ボム（OADX規格）", "Play/parts/common/oadx_bomb/*.png")
	local fcParts = customoption.filepath("フルコンボエフェクト", "Play/parts/common/fullcombo/*.png")
	local keybeamParts = customoption.filepath("キービーム", "Play/parts/common/keybeam/*.png")
	local keyimageParts = customoption.filepath("キーイメージ", "Play/parts/common/key/*.png")
	local keyflashParts = customoption.filepath("キーフラッシュ", "Play/parts/common/keyflash/*.png")
	local judgelineParts = customoption.filepath("判定ライン色", "Play/parts/common/judgeline/*.png")
	local glowlampParts = customoption.filepath("グローランプ（判定ライン上のやつ）", "Play/parts/common/glow/*.png")
	local progressParts = customoption.filepath("プログレスランプ（進捗バーのあれ）", "Play/parts/common/progress/*.png")
	local indicatorParts = customoption.filepath("ゲージMAXインジケータランプ", "Play/parts/common/lamp/*.png")
	local gaugeParts = customoption.filepath("ゲージ", "Play/parts/common/gauge/*.png")
	local scratchImageParts = customoption.filepath("スクラッチイメージ", "Play/parts/common/scratch/*.png")

	-- オフセット
	local bgBrightness
	bgBrightness, module.offsetBgBrightness = customoption.offset("背景の明るさ 0~255 (255で真っ暗になります)")
	local graphBrightness
	graphBrightness, module.offsetGraphBrightness = customoption.offset("グラフエリア背景画像の明るさ 0~255 (255で真っ暗になります)")
	local bgaBrightness
	bgaBrightness, module.offsetBgaBrightness = customoption.offset("BGAの明るさ 0~255 (255で真っ暗になります)")
	local tarjudgeOffset
	tarjudgeOffset, module.offsetTarjudge = customoption.offset("ターゲット差分、判定タイミングの位置")
	local bombSize
	bombSize, module.offsetBombSize = customoption.offset("ボムの大きさ 1~100%（範囲外は100%になります）")
	local laneBrightness
	laneBrightness, module.offsetLaneBrightness = customoption.offset("レーンの明るさ 0~255（255で真っ暗になります）")
	local barlineBrightness
	barlineBrightness, module.offsetBarlineBrightness = customoption.offset("小節線の明るさ 0~255（255で見えなくなります）")
	local judgelineHeight
	judgelineHeight, module.offsetJudgelineHeight = customoption.offset("判定ラインの高さ（0以下はデフォルト値12になります）")
	local glowlampHeight
	glowlampHeight, module.offsetGlowlampHeight = customoption.offset("グローランプの高さ（0以下はデフォルト値48になります）")
	local timinggraphOffset
	timinggraphOffset, module.offsetTiminggraph = customoption.offset("タイミンググラフの位置（プレイエリア側時に有効）")

	module.property = {
		--カスタムオプション定義
		{name = targetSwitch.name, def = targetSwitch.off.name, category = targetSwitch.label, item = {
			{name = targetSwitch.off.name, op = targetSwitch.off.num},
			{name = targetSwitch.on.name, op = targetSwitch.on.num},
		}},
		{name = targetPattern.name, def = targetPattern.rank.name, category = targetPattern.label, item = {
			{name = targetPattern.rank.name, op = targetPattern.rank.num},
			{name = targetPattern.mybest.name, op = targetPattern.mybest.num},
		}},
		{name = targetPosition.name, def = targetPosition.typeA.name, category = targetPosition.label, item = {
			{name = targetPosition.typeA.name, op = targetPosition.typeA.num},
			{name = targetPosition.typeB.name, op = targetPosition.typeB.num},
			{name = targetPosition.typeC.name, op = targetPosition.typeC.num},
		}},
		{name = judgetimingSwitch.name, def = judgetimingSwitch.off.name, category = judgetimingSwitch.label, item = {
			{name = judgetimingSwitch.off.name, op = judgetimingSwitch.off.num},
			{name = judgetimingSwitch.on.name, op = judgetimingSwitch.on.num},
		}},
		{name = judgetimingPattern.name, def = judgetimingPattern.typeA.name, category = judgetimingPattern.label, item = {
			{name = judgetimingPattern.typeA.name, op = judgetimingPattern.typeA.num},
			{name = judgetimingPattern.typeB.name, op = judgetimingPattern.typeB.num},
		}},
		{name = judgetimingPosition.name, def = judgetimingPosition.typeA.name, category = judgetimingPosition.label, item = {
			{name = judgetimingPosition.typeA.name, op = judgetimingPosition.typeA.num},
			{name = judgetimingPosition.typeB.name, op = judgetimingPosition.typeB.num},
			{name = judgetimingPosition.typeC.name, op = judgetimingPosition.typeC.num},
		}},
		{name = timingBomb.name, def = timingBomb.off.name, category = timingBomb.label, item = {
			{name = timingBomb.off.name, op = timingBomb.off.num},
			{name = timingBomb.on.name, op = timingBomb.on.num},
		}},
		{name = bombPattern.name, def = bombPattern.modernchic.name, category = bombPattern.label, item = {
			{name =  bombPattern.modernchic.name, op =  bombPattern.modernchic.num},
			{name =  bombPattern.oadx.name, op =  bombPattern.oadx.num},
		}},
		{name = graphPosition.name, def = graphPosition.left.name, category = graphPosition.label, item = {
			{name = graphPosition.left.name, op = graphPosition.left.num},
			{name = graphPosition.right.name, op = graphPosition.right.num},
			{name = graphPosition.none.name, op = graphPosition.none.num},
		}},
		{name = playPosition.name, def = playPosition.center.name, category = playPosition.label, item = {
			{name = playPosition.left.name, op = playPosition.left.num},
			{name = playPosition.center.name, op = playPosition.center.num},
			{name = playPosition.right.name, op = playPosition.right.num},
		}},
		{name = bitmapFont.name, def = bitmapFont.off.name, category = bitmapFont.label, item = {
			{name = bitmapFont.off.name, op = bitmapFont.off.num},
			{name = bitmapFont.on.name, op = bitmapFont.on.num},
		}},
		{name = timinggraphMagnification.name, def = timinggraphMagnification.normal.name, category = timinggraphMagnification.label, item = {
			{name = timinggraphMagnification.low.name, op = timinggraphMagnification.low.num},
			{name = timinggraphMagnification.normal.name, op = timinggraphMagnification.normal.num},
			{name = timinggraphMagnification.high.name, op = timinggraphMagnification.high.num},
		}},
		{name = timinggraphColorPattern.name, def = timinggraphColorPattern.normal.name, category = timinggraphColorPattern.label, item = {
			{name = timinggraphColorPattern.normal.name, op = timinggraphColorPattern.normal.num},
			{name = timinggraphColorPattern.red.name, op = timinggraphColorPattern.red.num},
			{name = timinggraphColorPattern.green.name, op = timinggraphColorPattern.green.num},
			{name = timinggraphColorPattern.blue.name, op = timinggraphColorPattern.blue.num},
		}},
		{name = HitErrorVisualizerPattern.name, def = HitErrorVisualizerPattern.normal.name, category = HitErrorVisualizerPattern.label, item = {
			{name = HitErrorVisualizerPattern.normal.name, op = HitErrorVisualizerPattern.normal.num},
			{name = HitErrorVisualizerPattern.triangle.name, op = HitErrorVisualizerPattern.triangle.num},
			{name = HitErrorVisualizerPattern.emphasis.name, op = HitErrorVisualizerPattern.emphasis.num},
		}},
		{name = glowlampSwitch.name, def = glowlampSwitch.on.name, category = glowlampSwitch.label, item = {
			{name = glowlampSwitch.off.name, op = glowlampSwitch.off.num},
			{name = glowlampSwitch.on.name, op = glowlampSwitch.on.num},
		}},
		{name = indicatorSwitch.name, def = indicatorSwitch.on.name, category = indicatorSwitch.label, item = {
			{name = indicatorSwitch.off.name, op = indicatorSwitch.off.num},
			{name = indicatorSwitch.on.name, op = indicatorSwitch.on.num},
		}},
		{name = gaugeSwitch.name, def = gaugeSwitch.off.name, category = gaugeSwitch.label, item = {
			{name = gaugeSwitch.off.name, op = gaugeSwitch.off.num},
			{name = gaugeSwitch.on.name, op = gaugeSwitch.on.num},
		}},
		{name = notesDistributionSwitch.name, def = notesDistributionSwitch.off.name, category = notesDistributionSwitch.label, item = {
			{name = notesDistributionSwitch.off.name, op = notesDistributionSwitch.off.num},
			{name = notesDistributionSwitch.on.name, op = notesDistributionSwitch.on.num},
		}},
		{name = notesDistributionPattern.name, def = notesDistributionPattern.typeA.name, category = notesDistributionPattern.label, item = {
			{name = notesDistributionPattern.typeA.name, op = notesDistributionPattern.typeA.num},
			{name = notesDistributionPattern.typeB.name, op = notesDistributionPattern.typeB.num},
			{name = notesDistributionPattern.typeC.name, op = notesDistributionPattern.typeC.num},
		}},
		{name = timinggraphSwitch.name, def = timinggraphSwitch.off.name, category = timinggraphSwitch.label, item = {
			{name = timinggraphSwitch.off.name, op = timinggraphSwitch.off.num},
			{name = timinggraphSwitch.on.name, op = timinggraphSwitch.on.num},
		}},
		{name = timinggraphDisplayPattern.name, def = timinggraphDisplayPattern.typeA.name, category = timinggraphDisplayPattern.label, item = {
			{name = timinggraphDisplayPattern.typeA.name, op = timinggraphDisplayPattern.typeA.num},
			{name = timinggraphDisplayPattern.typeB.name, op = timinggraphDisplayPattern.typeB.num},
		}},
		{name = infomationSwitch.name, def = infomationSwitch.on.name, category = infomationSwitch.label, item = {
			{name = infomationSwitch.off.name, op = infomationSwitch.off.num},
			{name = infomationSwitch.on.name, op = infomationSwitch.on.num},
		}},
		{name = keybeamHeight.name, def = keybeamHeight.size50.name, category = keybeamHeight.label, item = {
			{name = keybeamHeight.size100.name, op = keybeamHeight.size100.num},
			{name = keybeamHeight.size90.name, op = keybeamHeight.size90.num},
			{name = keybeamHeight.size80.name, op = keybeamHeight.size80.num},
			{name = keybeamHeight.size70.name, op = keybeamHeight.size70.num},
			{name = keybeamHeight.size60.name, op = keybeamHeight.size60.num},
			{name = keybeamHeight.size50.name, op = keybeamHeight.size50.num},
			{name = keybeamHeight.size40.name, op = keybeamHeight.size40.num},
			{name = keybeamHeight.size30.name, op = keybeamHeight.size30.num},
			{name = keybeamHeight.size20.name, op = keybeamHeight.size20.num},
			{name = keybeamHeight.size10.name, op = keybeamHeight.size10.num},
		}},
		{name = keybeamDisappearanceTime.name, def = keybeamDisappearanceTime.normal.name, category = keybeamDisappearanceTime.label, item = {
			{name = keybeamDisappearanceTime.normal.name, op = keybeamDisappearanceTime.normal.num},
			{name = keybeamDisappearanceTime.short.name, op = keybeamDisappearanceTime.short.num},
			{name = keybeamDisappearanceTime.long.name, op = keybeamDisappearanceTime.long.num},
		}},
		{name = keybeamDisappearancePattern.name, def = keybeamDisappearancePattern.typeB.name, category = keybeamDisappearancePattern.label, item = {
			{name = keybeamDisappearancePattern.typeL.name, op = keybeamDisappearancePattern.typeL.num},
			{name = keybeamDisappearancePattern.typeB.name, op = keybeamDisappearancePattern.typeB.num},
		}},
		{name = gaugeStretchDirection.name, def = gaugeStretchDirection.right.name, category = gaugeStretchDirection.label, item = {
			{name = gaugeStretchDirection.right.name, op = gaugeStretchDirection.right.num},
			{name = gaugeStretchDirection.left.name, op = gaugeStretchDirection.left.num},
		}},
		{name = bgaPattern.name, def = bgaPattern.typeA.name, category = bgaPattern.label, item = {
			{name = bgaPattern.typeA.name, op = bgaPattern.typeA.num},
			{name = bgaPattern.typeB.name, op = bgaPattern.typeB.num},
			{name = bgaPattern.typeC.name, op = bgaPattern.typeC.num},
		}},
		{name = finishCoverSwitch.name, def = finishCoverSwitch.on.name, category = finishCoverSwitch.label, item = {
			{name = finishCoverSwitch.off.name, op = finishCoverSwitch.off.num},
			{name = finishCoverSwitch.on.name, op = finishCoverSwitch.on.num}
		}},
		{name = lanecoverRotationSwitch.name, def = lanecoverRotationSwitch.off.name, category = lanecoverRotationSwitch.label, item = {
			{name = lanecoverRotationSwitch.off.name, op = lanecoverRotationSwitch.off.num},
			{name = lanecoverRotationSwitch.on.name, op = lanecoverRotationSwitch.on.num}
		}},
	}

	module.filepath = {
		{name = bg.name, path = bg.path, category = bg.label, def = "#default"},
		{name = graphBg.name, path = graphBg.path, category = graphBg.label, def = "#default"},
		{name = notesParts.name, path = notesParts.path, category = notesParts.label, def = "#default"},
		{name = judgeParts.name, path = judgeParts.path, category = judgeParts.label, def = "#default"},
		{name = lanecoverParts.name, path = lanecoverParts.path, category = lanecoverParts.label, def = "#default"},
		{name = liftParts.name, path = liftParts.path, category = liftParts.label, def = "#default"},
		{name = modernchicBomb.name, path = modernchicBomb.path, category = modernchicBomb.label, def = "diamond SCUROed."},
		{name = oadxBomb.name, path = oadxBomb.path, category = oadxBomb.label, def = "DEFAULT"},
		{name = fcParts.name, path = fcParts.path, category = fcParts.label, def = "#default"},
		{name = keybeamParts.name, path = keybeamParts.path, category = keybeamParts.label, def = "#default"},
		{name = keyimageParts.name, path = keyimageParts.path, category = keyimageParts.label, def = "harf"},
		{name = keyflashParts.name, path = keyflashParts.path, category = keyflashParts.label, def = "#default"},
		{name = judgelineParts.name, path = judgelineParts.path, category = judgelineParts.label, def = "#default"},
		{name = glowlampParts.name, path = glowlampParts.path, category = glowlampParts.label, def = "#default"},
		{name = progressParts.name, path = progressParts.path, category = progressParts.label, def = "#default"},
		{name = indicatorParts.name, path = indicatorParts.path, category = indicatorParts.label, def = "#default"},
		{name = gaugeParts.name, path = gaugeParts.path, category = gaugeParts.label, def = "#default"},
	--	{name = "POMYU Chara 1P", path = "Play/parts/common/POMYU Chara/*|1P|", def = "Off"},
		{name = scratchImageParts.name, path = scratchImageParts.path, category = scratchImageParts.label, def = "#default"}
	}

	-- offsetのユーザー定義は40以降
	module.offset = {
		{name = bgaBrightness.name, id = bgaBrightness.num, category = bgaBrightness.label, a = 0},
		{name = bgBrightness.name, id = bgBrightness.num, category = bgBrightness.label, a = 0},
		{name = laneBrightness.name, id = laneBrightness.num, category = laneBrightness.label, a = 0},
		{name = barlineBrightness.name, id = barlineBrightness.num, category = barlineBrightness.label, a = 0},
		{name = graphBrightness.name, id = graphBrightness.num, category = graphBrightness.label, a = 0},
		{name = judgelineHeight.name, id = judgelineHeight.num, category = judgelineHeight.label, h = 0},
		{name = glowlampHeight.name, id = glowlampHeight.num, category = glowlampHeight.label, h = 0},
		{name = tarjudgeOffset.name, id = tarjudgeOffset.num, category = tarjudgeOffset.label, x = 0, y = 0},
		{name = bombSize.name, id = bombSize.num, category = bombSize.label, w = 0},
		{name = timinggraphOffset.name, id = timinggraphOffset.num, category = timinggraphOffset.label, x = 0, y = 0}
	}

	--[[
		カスタムカテゴリ
		カスタムオプション、ファイルパス、オフセットを関連付け
	]]
	module.category = {
		--カスタムオプション定義
		{name = "メインオプション", item = {
			playPosition.label,
			bitmapFont.label,
			finishCoverSwitch.label
		}},
		{name = "背景", item = {
			bg.label,
			bgBrightness.label
		}},
		{name = "グラフエリア", item = {
			graphPosition.label,
			graphBg.label,
			graphBrightness.label
		}},
		{name = "BGA", item = {
			bgaPattern.label,
			bgaBrightness.label
		}},
		{name = "ターゲットと判定タイミング", item = {
			targetSwitch.label,
			targetPattern.label,
			targetPosition.label,
			judgetimingSwitch.label,
			judgetimingPattern.label,
			judgetimingPosition.label,
			tarjudgeOffset.label
		}},
		{name = "ゲージ", item = {
			gaugeSwitch.label,
			gaugeParts.label,
			gaugeStretchDirection.label
		}},
		{name = "レーンカバー", item = {
			lanecoverParts.label,
			lanecoverRotationSwitch.label,
			liftParts.label,
		}},
		{name = "キービーム", item = {
			keybeamParts.label,
			keybeamHeight.label,
			keybeamDisappearanceTime.label,
			keybeamDisappearancePattern.label
		}},
		{name = "ボム", item = {
			bombPattern.label,
			timingBomb.label,
			modernchicBomb.label,
			oadxBomb.label,
			bombSize.label
		}},
		{name = "ノート分布グラフ", item = {
			notesDistributionSwitch.label,
			notesDistributionPattern.label
		}},
		{name = "判定タイミンググラフ", item = {
			timinggraphSwitch.label,
			timinggraphDisplayPattern.label,
			timinggraphMagnification.label,
			timinggraphColorPattern.label,
			HitErrorVisualizerPattern.label,
			timinggraphOffset.label
		}},
		-- ここから別
		{name = "パーツ選択", item = {
			notesParts.label,
			judgeParts.label,
			fcParts.label,
			keyimageParts.label,
			keyflashParts.label,
			judgelineParts.label,
			glowlampParts.label,
			progressParts.label,
			indicatorParts.label,
			scratchImageParts.label
		}},
		{name = "オフセット（位置、大きさ、明暗調整）", item = {
			laneBrightness.label,
			barlineBrightness.label,
			judgelineHeight.label,
			glowlampHeight.label
		}},
	}

	if is10keys then
		table.insert(module.property, {
			name = tenkeysCoverSwitch.name, def = tenkeysCoverSwitch.on.name, category = tenkeysCoverSwitch.label, item = {
				{name = tenkeysCoverSwitch.off.name, op = tenkeysCoverSwitch.off.num},
				{name = tenkeysCoverSwitch.on.name, op = tenkeysCoverSwitch.on.num},
			}
		})
		table.insert(module.category, 12, {
			name = "パーツ表示有無", item = {
				glowlampSwitch.label,
				indicatorSwitch.label,
				infomationSwitch.label,
				tenkeysCoverSwitch.label
			}
		})
	else
		table.insert(module.category, 12, {
			name = "パーツ表示有無", item = {
				glowlampSwitch.label,
				indicatorSwitch.label,
				infomationSwitch.label
			}
		})
	end

	if DEBUG then
		print("DP用カスタムオプション最大値：" ..customoptionNumber .."\nDP用カテゴリ最大値：" ..categoryNumber .."\nDP用オフセット最大値：" ..offsetNumber)
	end

	return module
end

return{
	load = load
}