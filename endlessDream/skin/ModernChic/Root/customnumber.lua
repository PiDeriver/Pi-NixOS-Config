--[[
    カスタムナンバーを定義する場合はここに記述
    value定義のvalueプロパティで使用可能
    @author : KASAKO
]]
local laneCover = {
	all = {flg = true, num = 0},
	sp = {flg = true, num = 0},
	dp = {flg = true, num = 0}
}
local function selectTarget()
	if (CONFIG.play.sectionScore.type == 1) or CUSTOM.OP.isFirstPlay2() then
		return MAIN.NUM.DIFF_TARGETSCORE
	elseif CONFIG.play.sectionScore.type == 2 then
		return MAIN.NUM.DIFF_HIGHSCORE
	end
end

local m = {}
local FUNC = require("Root.customfunction")
local CLOCK = require("Root.customtime")

-- マスターボリューム
m.masterVolumeNum = function()
    return main_state.volume_sys() * 100
end
-- キーボリューム
m.keyVolumeNum = function()
    return main_state.volume_key() * 100
end
-- BGMボリューム
m.bgmVolumeNum = function()
    return main_state.volume_bg() * 100
end
-- 現在のスコアレート
m.nowScoreRateNum = function()
    return main_state.rate()
end
-- 現在のEXスコア
m.nowExScoreNum = function()
    return main_state.exscore()
end
-- 現在のゲージ％数
m.nowGaugePercentNum = function()
    return main_state.gauge()
end
-- 現在のPG数
m.nowPGCountNum = function()
    return main_state.judge(0)
end
-- 現在のグレート数
m.nowGreatCountNum = function()
    return main_state.judge(1)
end
-- 現在のグッド数
m.nowGoodCountNum = function()
    return main_state.judge(2)
end
-- 現在のバッド数
m.nowBadCountNum = function()
    return main_state.judge(3)
end
-- 現在のプア数
m.nowPoorCountNum = function()
    return main_state.judge(4)
end
-- 現在のミス数
m.nowMissCountNum = function()
    return main_state.judge(5)
end
-- 乱数生成
m.randNum = function(min, max)
    return math.random(min, max)
end
-- 一拍の時間
-- split: 画像の分割数
m.oneBeat = function(split)
    return (60 / main_state.number(MAIN.NUM.MAINBPM)) * 1000 * split
end
-- 一拍の時間
-- split: 画像の分割数
m.oneBeat2 = function(split, bpm)
    return (60 / bpm) * 1000 * split
end
-- 最大EXスコア
m.maxExscore = function()
	return main_state.number(MAIN.NUM.TOTALNOTES) * 2
end
-- 自己ベストの取得
m.myScoreBest = function()
	-- 自己ベ
	local myScoreBest = main_state.number(MAIN.NUM.HIGHSCORE2)
	-- 今回のスコア
	local myScoreNow = main_state.number(MAIN.NUM.SCORE3)
	if myScoreBest >= myScoreNow then
		return myScoreBest
	else
		return myScoreNow
	end
end
-- IR更新前と更新後の差分
m.irRankDiff = function()
	-- IRにスコアを更新したか
	if CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_BEGIN) or CUSTOM.OP.isTimerOff(MAIN.TIMER.IR_CONNECT_SUCCESS) then
		return 0
	else
		-- 更新前
		local prevRank = main_state.number(MAIN.NUM.IR_PREVRANK)
		-- 更新後
		local updateRank = main_state.number(MAIN.NUM.IR_RANK)
		-- 初見時
		if prevRank == 0 then
			return 0
		else
			-- 差を返す（+になることは順位が下がった事を示す）
			local diff = updateRank - prevRank
			return diff
		end
	end
end

m.mybestClearType = function()
	-- これまでのクリアタイプ
	local prev = main_state.number(MAIN.NUM.TARGET_CLEAR)
	local now = main_state.number(MAIN.NUM.CLEAR)
	-- maxを1、failedを10に整形
	if prev == 10 then prev = 1
	elseif prev == 9 then prev = 2
	elseif prev == 8 then prev = 3
	elseif prev == 7 then prev = 4
	elseif prev == 6 then prev = 5
	elseif prev == 5 then prev = 6
	elseif prev == 4 then prev = 7
	elseif prev == 3 then prev = 8
	elseif prev == 2 then prev = 9
	elseif prev == 1 then prev = 10
    else prev = 11 end
	if now == 10 then now = 1
	elseif now == 9 then now = 2
	elseif now == 8 then now = 3
	elseif now == 7 then now = 4
	elseif now == 6 then now = 5
	elseif now == 5 then now = 6
	elseif now == 4 then now = 7
	elseif now == 3 then now = 8
	elseif now == 2 then now = 9
	elseif now == 1 then now = 10
    else now = 11 end

	if prev > now then
		return now
	else
		return prev
	end
end
-- 参考TOTAL値
-- 参考URL：http://nekokan.dyndns.info/~268/memo/total.html
m.calcTotal = function()
	local gauge
	local totalNotes = main_state.number(MAIN.NUM.TOTALNOTES)
	if totalNotes < 1 then
		gauge = 0
	elseif totalNotes < 400 then
		gauge = 200 + (totalNotes / 5)
	elseif totalNotes < 600 then
		gauge = 280 + ((totalNotes - 400) / 2.5)
	elseif totalNotes >= 600 then
		gauge = 360 + ((totalNotes - 600) / 5)
	end
	return gauge
end
-- ベストランク取得
m.bestRank = function()
	if main_state.option(MAIN.OP.BEST_F_1P) then
		return 1
	elseif main_state.option(MAIN.OP.BEST_E_1P) then
		return 2
	elseif main_state.option(MAIN.OP.BEST_D_1P) then
		return 3
	elseif main_state.option(MAIN.OP.BEST_C_1P) then
		return 4
	elseif main_state.option(MAIN.OP.BEST_B_1P) then
		return 5
	elseif main_state.option(MAIN.OP.BEST_A_1P) then
		return 6
	elseif main_state.option(MAIN.OP.BEST_AA_1P) then
		return 7
	elseif main_state.option(MAIN.OP.BEST_AAA_1P) then
		return 8
	else
		return 0
	end
end
-- 今回のランク
m.nowRank = function()
	if main_state.option(MAIN.OP.RESULT_F_1P) then
		return 1
	elseif main_state.option(MAIN.OP.RESULT_E_1P) then
		return 2
	elseif main_state.option(MAIN.OP.RESULT_D_1P) then
		return 3
	elseif main_state.option(MAIN.OP.RESULT_C_1P) then
		return 4
	elseif main_state.option(MAIN.OP.RESULT_B_1P) then
		return 5
	elseif main_state.option(MAIN.OP.RESULT_A_1P) then
		return 6
	elseif main_state.option(MAIN.OP.RESULT_AA_1P) then
		return 7
	elseif main_state.option(MAIN.OP.RESULT_AAA_1P) then
		return 8
	else
		return 0
	end
end
-- 難易度ごとの基本色
m.diffRGB = function()
	if main_state.option(MAIN.OP.DIFFICULTY1) then
		return {6, 255, 0}
	elseif main_state.option(MAIN.OP.DIFFICULTY2) then
		return {18, 210, 215}
	elseif main_state.option(MAIN.OP.DIFFICULTY3) then
		return {255, 192, 0}
	elseif main_state.option(MAIN.OP.DIFFICULTY4) then
		return {255, 0, 0}
	elseif main_state.option(MAIN.OP.DIFFICULTY5) then
		return {148, 44, 150}
	elseif main_state.option(MAIN.OP.DIFFICULTY0) then
		return {195, 195, 195}
	end
end
-- 達成率
m.achievementRate = function(num)
	local targetscore = main_state.number(num)
	local maxscore = m.maxExscore()
	if targetscore == 0 then
		return 0
	else
		return (targetscore / maxscore) * 100
	end
end

-- 各セクションの状況
m.sectionTime = function(numer, denom)
	local songLimitSec = (((main_state.number(MAIN.NUM.SONGLENGTH_MINUTE) * 60) + main_state.number(MAIN.NUM.SONGLENGTH_SECOND)) / denom) * numer
	return {songLimitSec / 60, songLimitSec % 60}
end
m.sectionScore1_4 = function()
	if CUSTOM.OP.isSectionfRemain(1, 4) and CUSTOM.sectionScore.oneFour.nFlg then
		CUSTOM.sectionScore.oneFour.nFlg = not CUSTOM.sectionScore.oneFour.nFlg
		CUSTOM.sectionScore.oneFour.myScore = main_state.number(MAIN.NUM.SCORE2)
		CUSTOM.sectionScore.oneFour.tgtDiff = main_state.number(selectTarget())
	end
	return {CUSTOM.sectionScore.oneFour.myScore, CUSTOM.sectionScore.oneFour.tgtDiff}
end
m.sectionScore2_4 = function()
	if CUSTOM.OP.isSectionfRemain(2, 4) and CUSTOM.sectionScore.twoFour.nFlg then
		CUSTOM.sectionScore.twoFour.nFlg = not CUSTOM.sectionScore.twoFour.nFlg
		CUSTOM.sectionScore.twoFour.myScore = main_state.number(MAIN.NUM.SCORE2)
		CUSTOM.sectionScore.twoFour.tgtDiff = main_state.number(selectTarget())
	end
	return {CUSTOM.sectionScore.twoFour.myScore, CUSTOM.sectionScore.twoFour.tgtDiff}
end
m.sectionScore3_4 = function()
	if CUSTOM.OP.isSectionfRemain(3, 4) and CUSTOM.sectionScore.threeFour.nFlg then
		CUSTOM.sectionScore.threeFour.nFlg = not CUSTOM.sectionScore.threeFour.nFlg
		CUSTOM.sectionScore.threeFour.myScore = main_state.number(MAIN.NUM.SCORE2)
		CUSTOM.sectionScore.threeFour.tgtDiff = main_state.number(selectTarget())
	end
	return {CUSTOM.sectionScore.threeFour.myScore, CUSTOM.sectionScore.threeFour.tgtDiff}
end
m.sectionScore4_4 = function()
	if CUSTOM.OP.isSectionfRemain(4, 4) and CUSTOM.sectionScore.fourFour.nFlg then
		CUSTOM.sectionScore.fourFour.nFlg = not CUSTOM.sectionScore.fourFour.nFlg
		CUSTOM.sectionScore.fourFour.myScore = main_state.number(MAIN.NUM.SCORE2)
		CUSTOM.sectionScore.fourFour.tgtDiff = main_state.number(selectTarget())
	end
	return {CUSTOM.sectionScore.fourFour.myScore, CUSTOM.sectionScore.fourFour.tgtDiff}
end
-- プレイ開始からの経過時間（マイクロ秒単位・プレイスキン）
m.elapsedTimeFromStart = function()
	return (main_state.time() - main_state.timer(MAIN.TIMER.PLAY)) / 1000000
end
-- プレイ開始からの経過時間（秒単位・プレイスキン）
m.elapsedTimeFromStart2 = function()
	return (main_state.number(MAIN.NUM.PLAYTIME_MINUTE) * 60) + main_state.number(MAIN.NUM.PLAYTIME_SECOND)
end
-- すべてのレーンカバー数
m.allLaneCoverCountSP = FUNC.countFileRecords(skin_config.get_path("io/Play/sp/lanecover/pathList.txt"), 0)
m.allLaneCoverCountDP = FUNC.countFileRecords(skin_config.get_path("io/Play/dp/lanecover/pathList.txt"), 0)
-- 使用済みレーンカバー数
m.usedLaneCoverCountSP = FUNC.countFileRecords(skin_config.get_path("io/Play/sp/lanecover/excludeList.txt"), 0)
m.usedLaneCoverCountDP = FUNC.countFileRecords(skin_config.get_path("io/Play/dp/lanecover/excludeList.txt"), 0)
-- 本日プレイした曲数
m.todaySongUpdateCount = FUNC.countFileRecords(skin_config.get_path("History/" ..CLOCK.DATE .."/history.txt"), 0)
-- 本日ランプ更新した曲数
m.todayClearUpdateCount = FUNC.countFileRecords(skin_config.get_path("History/" ..CLOCK.DATE .."/clear.txt"), 0)
-- 本日スコア更新した曲数
m.todayScoreUpdateCount = FUNC.countFileRecords(skin_config.get_path("History/" ..CLOCK.DATE .."/score.txt"), 0)
-- 本日ミスカン更新した曲数
m.todayMissUpdateCount = FUNC.countFileRecords(skin_config.get_path("History/" ..CLOCK.DATE .."/miss.txt"), 0)
-- インプレ数
m.impressionCount = FUNC.countFileRecords(skin_config.get_path("History/impression.txt"), 1)
return m