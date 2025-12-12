--[[
    カスタムオプションを定義する場合はここに記述
    @author : KASAKO
]]
local m = {}

-- ゲージがアシストイージー状態
m.isGaugeAssistEasy = function()
    return main_state.gauge_type() == 0
end
-- ゲージがイージー状態
m.isGaugeEasy = function()
    return main_state.gauge_type() == 1
end
-- ゲージがノーマル状態
m.isGaugeNormal = function()
    return main_state.gauge_type() == 2
end
-- ゲージがハード状態
m.isGaugeHard = function()
    return main_state.gauge_type() == 3
end
-- ゲージがEXハード状態
m.isGaugeExHard = function()
    return main_state.gauge_type() == 4
end
-- ゲージがハザード状態
m.isGaugeHazard = function()
    return main_state.gauge_type() == 5
end
-- ゲージが段位ゲージ状態（ノーマル）
m.isGaugeGrade = function()
    return main_state.gauge_type() == 6
end
-- ゲージが段位ゲージ状態（ハード）
m.isGaugeExGrade = function()
    return main_state.gauge_type() == 7
end
-- ゲージが段位ゲージ状態（EXハード）
m.isGaugeExhardGrade = function()
    return main_state.gauge_type() == 8
end
-- タイマーがオフの状態
m.isTimerOff = function(timerId)
    return main_state.timer(timerId) == main_state.timer_off_value
end
-- タイマーがオンの状態
m.isTimerOn = function(timerId)
    return main_state.timer(timerId) ~= main_state.timer_off_value
end
-- LNモードでかつ長押しが含まれる譜面（プレイスキン）
m.isLnPattern = function()
    return main_state.event_index(MAIN.BUTTON.LNMODE) == 0 and main_state.option(MAIN.OP.LN)
end
-- CNモードでかつ長押しが含まれる譜面（プレイスキン）
m.isCnPattern = function()
    return main_state.event_index(MAIN.BUTTON.LNMODE) == 1 and main_state.option(MAIN.OP.LN)
end
-- HCNモードでかつ長押しが含まれる譜面（プレイスキン）
m.isHcnPattern = function()
    return main_state.event_index(MAIN.BUTTON.LNMODE) == 2 and main_state.option(MAIN.OP.LN)
end

-- 途中で閉店したのかを判定する
-- TODO 意図的に中断した時に表示されてしまう
m.isInTheMiddleFailed = function()
    local totalNotes = main_state.number(MAIN.NUM.TOTALNOTES)
    local processNotes = main_state.number(MAIN.NUM.PERFECT) + main_state.number(MAIN.NUM.GREAT) + main_state.number(MAIN.NUM.GOOD) + main_state.number(MAIN.NUM.BAD) + main_state.number(MAIN.NUM.POOR)
    return main_state.option(MAIN.OP.RESULT_FAIL) and totalNotes ~= processNotes
end

m.isMainBpm = function()
    local nowBpm = main_state.number(MAIN.NUM.NOWBPM)
    local mainBpm = main_state.number(MAIN.NUM.MAINBPM)
    local minBpm = main_state.number(MAIN.NUM.MINBPM)
    local maxBpm = main_state.number(MAIN.NUM.MAXBPM)
    return (mainBpm == nowBpm) and (maxBpm ~= minBpm)
end

-- コース中のリザルトなのか？（op280~293が機能しない？）
m.isCourse = function()
	-- コース1タイトルがあればコースであると判断
	return main_state.text(MAIN.STRING.COURSE1_TITLE) ~= ""
end

-- 初見プレイではない（リザルトスキン用）
m.isNotFirstPlay = function()
    return main_state.option(MAIN.OP.UPDATE_SCORE) and (main_state.number(MAIN.NUM.HIGHSCORE2) ~= 0)
end
-- 初見プレイではない（プレイスキン用）
m.isNotFirstPlay2 = function()
    return (main_state.float_number(MAIN.GRAPH.BESTSCORERATE) ~= 0) and main_state.option(MAIN.OP.AUTOPLAYOFF)
end
-- 初見プレイ（プレイスキン用）
m.isFirstPlay2 = function()
    return (main_state.float_number(MAIN.GRAPH.BESTSCORERATE) == 0) and main_state.option(MAIN.OP.AUTOPLAYOFF)
end
-- 曲バー移動後一定時間操作なし（セレクトスキン）
m.isNeglect = function(sec)
    return (main_state.time() - main_state.timer(MAIN.TIMER.SONGBAR_CHANGE)) / 1000000 > sec
end

-- キャラ表示切り替えフラグ
m.isCharDisplayOn = true

-- TODO リプレイ中のリザルトか判断できるようにしたい（正常動作しない）
--[[
m.isReplay = function()
    local re = main_state.option(MAIN.OP.REPLAYDATA)
    local re2 = main_state.option(MAIN.OP.REPLAYDATA2)
    local re3 = main_state.option(MAIN.OP.REPLAYDATA3)
    local re4 = main_state.option(MAIN.OP.REPLAYDATA4)
    print(((re == true) or (re2 == true)) or ((re3 == true) or (re4 == true)))
    return ((re == true) or (re2 == true)) or ((re3 == true) or (re4 == true))
end
]]

-- 自身の順位枠か
m.isMyFrame = function(indexNum)
	local indexRank = main_state.number(389 + indexNum)
	local myRank = main_state.number(MAIN.NUM.IR_RANK)
	local flg = main_state.text(119 + indexNum) == "YOU"
	return (indexRank == myRank) and flg
end

m.isYouWin = function()
	local myScore = main_state.number(MAIN.NUM.SCORE)
	local rivalScore = main_state.number(MAIN.NUM.RIVAL_SCORE)
	return (myScore >= rivalScore) and main_state.option(MAIN.OP.COMPARE_RIVAL)
end

m.isRivalWin = function()
	local myScore = main_state.number(MAIN.NUM.SCORE)
	local rivalScore = main_state.number(MAIN.NUM.RIVAL_SCORE)
	return (myScore < rivalScore) and main_state.option(MAIN.OP.COMPARE_RIVAL)
end

-- アシストオプションのいずれかが有効状態
m.isAssistOn = function()
    local a = main_state.event_index(MAIN.BUTTON.ASSIST_EXJUDGE)
    local b = main_state.event_index(MAIN.BUTTON.ASSIST_JUDGEAREA)
    local c = main_state.event_index(MAIN.BUTTON.ASSIST_MARKNOTE)
    local d = main_state.event_index(MAIN.BUTTON.ASSIST_NOMINE)
    local e = main_state.event_index(MAIN.BUTTON.ASSIST_CONSTANT)
    local f = main_state.event_index(MAIN.BUTTON.ASSIST_LEGACY)
    local g = main_state.event_index(MAIN.BUTTON.ASSIST_BPMGUIDE)
    local flg = (a == 1) or (b == 1) or (c == 1) or (d == 1) or (e == 1) or (f == 1) or (g == 1)
    return flg
end
m.isCounseWithin5 = function()
	return (main_state.option(MAIN.OP.GRADEBAR)) and (main_state.text(MAIN.STRING.COURSE6_TITLE) == "")
end
m.isCounseOver6 = function()
	return (main_state.option(MAIN.OP.GRADEBAR)) and (main_state.text(MAIN.STRING.COURSE6_TITLE) ~= "")
end

-- 指定残り秒数を切ったか（プレイスキン）
m.isRemainSec = function(sec)
    local nowSec = (main_state.number(MAIN.NUM.TIMELEFT_MINUTE) * 60) + main_state.number(MAIN.NUM.TIMELEFT_SECOND)
    return nowSec < sec
end

-- 指定区間の秒数を過ぎたか（プレイスキン）
-- numer: 分子
-- denom: 分母
m.isSectionfRemain = function(numer, denom)
    local songLimitSec = (((main_state.number(MAIN.NUM.SONGLENGTH_MINUTE) * 60) + main_state.number(MAIN.NUM.SONGLENGTH_SECOND)) / denom) * numer
    local nowSec = CUSTOM.NUM.elapsedTimeFromStart()
    if (main_state.timer(MAIN.TIMER.PLAY) ~= main_state.timer_off_value) then
        return songLimitSec < nowSec
    else
        return false
    end
end

-- 点滅ゲージか（プレイスキン）
m.isBrinkGauge = function()
	return m.isGaugeExHard() or m.isGaugeHazard() or m.isGaugeExGrade() or m.isGaugeExhardGrade()
end

-- 譜面プレビュー有効でないかつ読み込み中の時
m.isPreviewOFF = function()
    local flg = main_state.timer(MAIN.TIMER.PREVIEW)
    local flg2 = main_state.option(MAIN.OP.NOW_LOADING)
    if (flg == main_state.timer_off_value) and flg2 then
        return true
    else
        return false
    end
end
return m