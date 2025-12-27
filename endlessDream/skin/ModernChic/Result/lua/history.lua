--[[
    プレイ履歴保存機能
    @author : KASAKO
]]
-- 直近履歴
local function saveRecentlyHistory()
    local filePath = skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/history.txt")
    local content = {}
    do
        local i = 0
        -- 通算履歴をテーブルに格納
        local f = io.open(filePath, "r")
        for line in f:lines() do
            i = i + 1
            content[i] = line
        end
        f:close()
    end
    -- 順をひっくり返す
    local content2 = ""
    for j = #content, 1, -1 do
        content2 = content2 ..content[j] .."\n"
    end
    local filePath2 = skin_config.get_path("History/recent.txt")
    -- ファイルが存在しない場合は新規作成
    if CUSTOM.FUNC.existFile(filePath2) == false then
        CUSTOM.FUNC.createFile(filePath2)
    end 
    -- ファイル書き込み
    local g = io.open(filePath2, "w")
    g:write(content2)
    g:close()
    print("HISTORY:直近プレイ履歴追記完了")
end
-- 楽曲BGA検索用
-- TODO CSVで出力も考えたけど文字コードの都合上断念
local function saveSearchUrl()
    local filePath = skin_config.get_path("History/search.html")
    -- ファイルが存在しない場合は新規作成
    if CUSTOM.FUNC.existFile(filePath) == false then
        CUSTOM.FUNC.createFile(filePath)
    end
    local f = io.open(filePath, "w")
    local youtube = {}
    youtube.url = "https://www.youtube.com/results?search_query=" ..main_state.text(MAIN.STRING.TITLE)
    youtube.link = "<a href = \"" ..youtube.url .."\">" ..main_state.text(MAIN.STRING.TITLE) .."(YouTube)</a><br />"
    local niconico = {}
    niconico.url = "https://www.nicovideo.jp/search/" ..main_state.text(MAIN.STRING.TITLE)
    niconico.link = "<a href = \"" ..niconico.url .."\">" ..main_state.text(MAIN.STRING.TITLE) .."(niconico)</a>"
    f:write(youtube.link ..niconico.link)
    f:close()
    print("HISTORY:検索URL追記完了")
end
local function saveSearchUrlHistory(parts)
    table.insert(parts.image, {id = "saveSearchUrlBtn", src = 6, x = 0, y = 0, w = 1, h = 1, act = function() return saveSearchUrl() end})
    table.insert(parts.destination, {
        id = "saveSearchUrlBtn", dst = {
			{x = 700, y = 50, w = 520, h = 60},
		}
    })
end
-- プレイした曲名の履歴
local function saveTodayHistory()
    local filePath = skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/history.txt")
    -- ファイルが存在しない場合は新規作成
    if CUSTOM.FUNC.existFile(filePath) == false then
        CUSTOM.FUNC.mkdir(skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/"))
        CUSTOM.FUNC.createFile(filePath)
    end
    local count = CUSTOM.FUNC.countRecords(filePath, 1)
    local f = io.open(filePath, "a")
    -- 行番号_曲名
    f:write(count .."_" ..main_state.text(MAIN.STRING.FULLTITLE) .."_" ..CUSTOM.CLOCK.TIME .."\n")
    f:close()
    print("HISTORY:プレイ履歴追記完了")
end
-- クリアランプ更新した曲名の履歴更新
local function saveTodayClearUpdateHistory()
    -- クリアランプ更新しているか
    local flg = nil
    if PROPERTY.isupdateHistoryBorderOff() then
        flg = (main_state.number(MAIN.NUM.TARGET_CLEAR) > 0) and (main_state.number(MAIN.NUM.TARGET_CLEAR) < main_state.number(MAIN.NUM.CLEAR))
    elseif PROPERTY.isupdateHistoryBorderOn() then
        flg = (main_state.number(MAIN.NUM.TARGET_CLEAR) < main_state.number(MAIN.NUM.CLEAR))
    end
    if flg then
        local filePath = skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/clear.txt")
        -- ファイルが存在しない場合は新規作成
        if CUSTOM.FUNC.existFile(filePath) == false then
            CUSTOM.FUNC.mkdir(skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/"))
            CUSTOM.FUNC.createFile(filePath)
        end
        local prevRamp = CUSTOM.FUNC.rampConverter(main_state.number(MAIN.NUM.TARGET_CLEAR))
        local nowRamp = CUSTOM.FUNC.rampConverter(main_state.number(MAIN.NUM.CLEAR))
        local count = CUSTOM.FUNC.countRecords(filePath, 1)
        local f = io.open(filePath, "a")
        -- 行番号_曲名_プレイした時間
        f:write(count .."_" ..main_state.text(MAIN.STRING.FULLTITLE) .."_" ..prevRamp .."->" ..nowRamp .."_" ..CUSTOM.CLOCK.TIME .."\n")
        f:close()
        print("HISTORY:クリアランプ更新履歴追記完了")
        return
    end
end
-- ミスカン更新した曲名の履歴更新
local function saveTodayMisscountUpdateHistory()
    -- ミスカン更新しているか
    if (main_state.number(MAIN.NUM.TARGET_CLEAR) > 0) and (main_state.number(MAIN.NUM.DIFF_MISSCOUNT) < 0) then
        local filePath = skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/miss.txt")
        -- ファイルが存在しない場合は新規作成
        if CUSTOM.FUNC.existFile(filePath) == false then
            CUSTOM.FUNC.mkdir(skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/"))
            CUSTOM.FUNC.createFile(filePath)
        end
        local prev = main_state.number(MAIN.NUM.TARGET_MISSCOUNT)
        local now = main_state.number(MAIN.NUM.MISSCOUNT2)
        local count = CUSTOM.FUNC.countRecords(filePath, 1)
        local f = io.open(filePath, "a")
        -- 行番号_曲名_プレイした時間
        f:write(count .."_" ..main_state.text(MAIN.STRING.FULLTITLE) .."_MISSCOUNT(" ..prev .."->" ..now ..")_" ..CUSTOM.CLOCK.TIME .."\n")
        f:close()
        print("HISTORY:ミスカウント更新履歴追記完了")
        return
    end
end
-- スコア更新した曲名の履歴更新
local function saveTodayScoreUpdateHistory()
    -- NOPLAYは含めない
    if (main_state.number(MAIN.NUM.TARGET_CLEAR) > 0) and (main_state.number(MAIN.NUM.DIFF_HIGHSCORE2) > 0) then
        local filePath = skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/score.txt")
        -- ファイルが存在しない場合は新規作成
        if CUSTOM.FUNC.existFile(filePath) == false then
            CUSTOM.FUNC.mkdir(skin_config.get_path("History/" ..CUSTOM.CLOCK.DATE .."/"))
            CUSTOM.FUNC.createFile(filePath)
        end
        local prev = main_state.number(MAIN.NUM.HIGHSCORE2)
        local now = main_state.number(MAIN.NUM.SCORE3)
        local count = CUSTOM.FUNC.countRecords(filePath, 1)
        local f = io.open(filePath, "a")
        -- 行番号_曲名_プレイした時間
        f:write(count .."_" ..main_state.text(MAIN.STRING.FULLTITLE) .."_EXSCORE(" ..prev .."->" ..now ..")_" ..CUSTOM.CLOCK.TIME .."\n")
        f:close()
        print("HISTORY:EXSCORE更新履歴追記完了")
        return
    end
end

local function load()
    local parts = {}
    parts.image = {}
    parts.destination = {}
    -- 曲終了時にプレイ履歴を保存する
    saveTodayClearUpdateHistory()
    saveTodayMisscountUpdateHistory()
    saveTodayScoreUpdateHistory()
    saveTodayHistory()
    saveRecentlyHistory()
    saveSearchUrlHistory(parts)
    return parts
end

return {
    load = load
}
