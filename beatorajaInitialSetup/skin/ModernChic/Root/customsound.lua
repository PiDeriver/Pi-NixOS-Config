--[[
    SE出力
    DATE:22/12/04
    @author : KASAKO
    参考
        https://libgdx.badlogicgames.com/ci/nightlies/docs/api/com/badlogic/gdx/Gdx.html
        https://libgdx.badlogicgames.com/ci/nightlies/docs/api/com/badlogic/gdx/Audio.html
]]
--local DEBUG = true

local flg = {
    isAchievementA = true,
    isAchievementAA = true,
    isAchievementAAA = true,
    isAchievementMybest = true,
    isAchievementHarf = true,
    isAchievementTarget = true,
    isFullcombo = true
}
local function selectCharctorVoice()
    local char
    if CONFIG.voice.charctor == 1 then char = "zundamon" end
    if CONFIG.voice.charctor == 2 then char = "tsumugi" end
    return char
end
local function selectSectionEffect(diffScore)
    if diffScore >= 0 then
        main_state.audio_play(skin_config.get_path("Root/sounds/section-win.ogg"), 2)
    else
        main_state.audio_play(skin_config.get_path("Root/sounds/section-lose.ogg"), 2)
    end
end

local m = {}
-- インプレ機能オンオフ音声
m.calculatorChangeSound = function()
    main_state.audio_play(skin_config.get_path("Root/sounds/change.ogg"))
end
-- メニュー切り替え音声
m.menuChangeSound = function()
    main_state.audio_play(skin_config.get_path("Root/sounds/change.ogg"))
end
-- クリック音
m.clickSound = function()
    main_state.audio_play(skin_config.get_path("Root/sounds/click.ogg"))
end
-- 決定音
m.enterSound = function()
    main_state.audio_play(skin_config.get_path("Root/sounds/enter.ogg"))
end
-- フルコンボ音声
m.fcSound = function()
    if (main_state.timer(MAIN.TIMER.FULLCOMBO_1P) ~= main_state.timer_off_value) and flg.isFullcombo then
        main_state.audio_play(skin_config.get_path("Root/sounds/fullcombo.ogg"), 2)
        flg.isFullcombo = not flg.isFullcombo
    end
    return false
end
-- ヘルプ画面
m.helpMotionSound = function(flg)
	if (flg == false) then
        main_state.audio_play(skin_config.get_path("Root/sounds/close.ogg"))
	else
        main_state.audio_play(skin_config.get_path("Root/sounds/open.ogg"))
	end
end
-- サイドメニュー開閉状態で音声を切り分け
m.windowMotionSound = function(f1, f2, f3, f4)
	if flg and (f1 == false) and (f2 == false) and (f3 == false) and (f4 == false) then
        main_state.audio_play(skin_config.get_path("Root/sounds/close.ogg"))
	else
        main_state.audio_play(skin_config.get_path("Root/sounds/open.ogg"))
	end
end
-- リザルトボイス
m.resultVoice = function()
    local char = selectCharctorVoice()
    if CUSTOM.OP.isCourse() then
        -- 残りゲージで変化させてみる
        if main_state.number(MAIN.NUM.GROOVEGAUGE) > 80 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/course/great.ogg"), 2)
        elseif main_state.number(MAIN.NUM.GROOVEGAUGE) > 40 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/course/good.ogg"), 2)
        elseif main_state.number(MAIN.NUM.GROOVEGAUGE) > 0 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/course/bad.ogg"), 2)
        else
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/failed.ogg"), 2)
        end
    elseif CONFIG.voice.result.type == 1 then
        if main_state.option(MAIN.OP.RESULT_F_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/F.ogg"), 2)
        elseif main_state.option(MAIN.OP.RESULT_E_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/E.ogg"), 2)
        elseif main_state.option(MAIN.OP.RESULT_D_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/D.ogg"), 2)
        elseif main_state.option(MAIN.OP.RESULT_C_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/C.ogg"), 2)
        elseif main_state.option(MAIN.OP.RESULT_B_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/B.ogg"), 2)
        elseif main_state.option(MAIN.OP.RESULT_A_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/A.ogg"), 2)
        elseif main_state.option(MAIN.OP.RESULT_AA_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AA.ogg"), 2)
        elseif main_state.option(MAIN.OP.RESULT_AAA_1P) then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AAA.ogg"), 2)
        end
    elseif CONFIG.voice.result.type == 2 then
        if main_state.number(MAIN.NUM.CLEAR) == 1 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/failed.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 2 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/assistop.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 3 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/assisteasy.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 4 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/easy.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 5 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/clear.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 6 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/hard.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 7 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/exhard.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 8 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/fullcombo.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 9 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/perfect.ogg"), 2)
        elseif main_state.number(MAIN.NUM.CLEAR) == 10 then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/max.ogg"), 2)
        end
    elseif CONFIG.voice.result.type == 3 then
        if CUSTOM.OP.isNotFirstPlay() then
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/update/hiscore.ogg"), 2)
        end
    end
end

-- 達成ボイス
m.achievementVoice = function()
    local char = selectCharctorVoice()
    if CONFIG.voice.play.achievement then
        if main_state.option(MAIN.OP.A) and flg.isAchievementA then
            flg.isAchievementA = not flg.isAchievementA
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/A.ogg"), 2)
        elseif main_state.option(MAIN.OP.AA) and flg.isAchievementAA then
            flg.isAchievementAA = not flg.isAchievementAA
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AA.ogg"), 2)
        elseif main_state.option(MAIN.OP.AAA) and flg.isAchievementAAA then
            flg.isAchievementAAA = not flg.isAchievementAAA
            main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AAA.ogg"), 2)
        end
    end
    if CUSTOM.OP.isNotFirstPlay2() and (CUSTOM.OP.isTimerOn(MAIN.TIMER.SCORE_BEST)) and flg.isAchievementMybest and CONFIG.voice.play.mybest then
        flg.isAchievementMybest = not flg.isAchievementMybest
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/update/hiscore.ogg"), 2)
    end
    if (CUSTOM.OP.isTimerOn(MAIN.TIMER.SCORE_TARGET)) and flg.isAchievementTarget and CONFIG.voice.play.target then
        flg.isAchievementTarget = not flg.isAchievementTarget
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/update/target.ogg"), 2)
    end
    if CUSTOM.OP.isSectionfRemain(1, 2) and flg.isAchievementHarf and CONFIG.voice.play.harfRemain then
        flg.isAchievementHarf = not flg.isAchievementHarf
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/harf.ogg"), 2)
    end
    return false
end

-- 区間突破時音声
m.sectionScoreEffect = function()
    if CUSTOM.OP.isSectionfRemain(1, 4) and CUSTOM.sectionScore.oneFour.sFlg then
        CUSTOM.sectionScore.oneFour.sFlg = not CUSTOM.sectionScore.oneFour.sFlg
        if CONFIG.play.sectionScore.sound.type == 1 then
            main_state.audio_play(skin_config.get_path("Root/sounds/section.ogg"), 2)
        elseif CONFIG.play.sectionScore.sound.type == 2 then
            selectSectionEffect(CUSTOM.sectionScore.oneFour.tgtDiff)
        end
    end
    if CUSTOM.OP.isSectionfRemain(2, 4) and CUSTOM.sectionScore.twoFour.sFlg then
        CUSTOM.sectionScore.twoFour.sFlg = not CUSTOM.sectionScore.twoFour.sFlg
        if CONFIG.play.sectionScore.sound.type == 1 then
            main_state.audio_play(skin_config.get_path("Root/sounds/section.ogg"), 2)
        elseif CONFIG.play.sectionScore.sound.type == 2 then
            selectSectionEffect(CUSTOM.sectionScore.twoFour.tgtDiff)
        end
    end
    if CUSTOM.OP.isSectionfRemain(3, 4) and CUSTOM.sectionScore.threeFour.sFlg then
        CUSTOM.sectionScore.threeFour.sFlg = not CUSTOM.sectionScore.threeFour.sFlg
        if CONFIG.play.sectionScore.sound.type == 1 then
            main_state.audio_play(skin_config.get_path("Root/sounds/section.ogg"), 2)
        elseif CONFIG.play.sectionScore.sound.type == 2 then
            selectSectionEffect(CUSTOM.sectionScore.threeFour.tgtDiff)
        end
    end
    if CUSTOM.OP.isSectionfRemain(4, 4) and CUSTOM.sectionScore.fourFour.sFlg then
        CUSTOM.sectionScore.fourFour.sFlg = not CUSTOM.sectionScore.fourFour.sFlg
        if CONFIG.play.sectionScore.sound.type == 1 then
            main_state.audio_play(skin_config.get_path("Root/sounds/section.ogg"), 2)
        elseif CONFIG.play.sectionScore.sound.type == 2 then
            selectSectionEffect(CUSTOM.sectionScore.fourFour.tgtDiff)
        end
    end
    return false
end

m.initAchievementVoice = function()
    local vol = 0.001
    local char = selectCharctorVoice()
    main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/A.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AA.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AAA.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/update/hiscore.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/update/target.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/harf.ogg"), vol)
    if DEBUG then print("achievementVoice読み込み完了") end
end
m.initSectionSE = function()
    local vol = 0.001
    main_state.audio_play(skin_config.get_path("Root/sounds/section.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/section-win.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/section-lose.ogg"), vol)
    if DEBUG then print("sectionSE読み込み完了") end
end
m.initResultSE = function()
    local vol = 0.001
    main_state.audio_play(skin_config.get_path("Root/sounds/change.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/click.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/enter.ogg"), vol)
    if DEBUG then print("resultSE読み込み完了") end
end
m.initResultVoice = function()
    local vol = 0.001
    local char = selectCharctorVoice()
    if CUSTOM.OP.isCourse() then
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/course/great.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/course/good.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/course/bad.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/failed.ogg"), vol)
    elseif CONFIG.voice.result.type == 1 then
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/F.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/E.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/D.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/C.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/B.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/A.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AA.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/rank/AAA.ogg"), vol)
    elseif CONFIG.voice.result.type == 2 then
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/failed.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/assistop.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/assisteasy.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/easy.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/clear.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/hard.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/exhard.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/fullcombo.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/perfect.ogg"), vol)
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/clear/max.ogg"), vol)
    elseif CONFIG.voice.result.type == 3 then
        main_state.audio_play(skin_config.get_path("Root/sounds/vo/" ..char .."/update/hiscore.ogg"), vol)
    end
    if DEBUG then print("resultVoice読み込み完了") end
end
m.initSelectSE = function()
    local vol = 0.001
    main_state.audio_play(skin_config.get_path("Root/sounds/close.ogg"), vol)
    main_state.audio_play(skin_config.get_path("Root/sounds/open.ogg"), vol)
    if DEBUG then print("selectSE読み込み完了") end
end
m.initFcSE = function()
    local vol = 0.001
    main_state.audio_play(skin_config.get_path("Root/sounds/fullcombo.ogg"), vol)
    if DEBUG then print("FcSE読み込み完了") end
end

return m