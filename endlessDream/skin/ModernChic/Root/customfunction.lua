--[[
    独自定義関数
    DATE:22/06/15
    @author : KASAKO
]]
--local DEBUG = true
local luajava = require("luajava")
local File = luajava.bindClass("java.io.File")

local m = {}
-- ファイル新規作成
m.createFile = function(filePath)
    local f = io.open(filePath, "w")
    f:close()
    if DEBUG then print("CF:" ..filePath .."作成完了") end
end
-- ファイルが存在するか？
m.existFile = function(filePath)
    local f = io.open(filePath, "r")
    if f == nil then
        if DEBUG then print("CF:" ..filePath .."が存在しません") end
        return false
    else
        if DEBUG then print("CF:" ..filePath .."履歴ファイル確認") end
         f:close()
        return true
    end
end
-- レコード数取得処理
m.countRecords = function(filePath, startCount)
    local f = io.open(filePath, "r")
    -- レコード数を取得
    local count = startCount
    for line in f:lines() do
        count = count + 1
    end
    f:close()
    return count
end
-- ファイル内のレコード数か初期値を返す
m.countFileRecords = function(filePath, startCount)
    local count = nil
    -- ファイルが存在しない場合は初期値を返す
    if m.existFile(filePath) == false then
        count = startCount
    else
        count = m.countRecords(filePath, startCount)
    end
    if DEBUG then print("CF:" ..filePath .."レコード数:" ..count) end
    return count
end
-- ランプ変換
m.rampConverter = function(num)
    local name = nil
    if num == 0 then
        name = "NOPLAY"
    elseif num == 1 then
        name = "FAILED"
    elseif num == 2 then
        name = "LASSIST"
    elseif num == 3 then
        name = "ASSIST"
    elseif num == 4 then
        name = "EASY"
    elseif num == 5 then
        name = "NORMAL"
    elseif num == 6 then
        name = "HARD"
    elseif num == 7 then
        name = "EXHARD"
    elseif num == 8 then
        name = "FULLCOMBO"
    elseif num == 9 then
        name = "PERFECT"
    elseif num == 10 then
        name = "MAX"
    end
    return name
end
-- 判定レベル変換
m.judgeLevel = function()
    local msg = "判定レベル "
    if main_state.option(MAIN.OP.JUDGE_VERYEASY) then
        msg = msg .."VERYEASY _ "
    elseif main_state.option(MAIN.OP.JUDGE_EASY) then
        msg = msg .."EASY _ "
    elseif main_state.option(MAIN.OP.JUDGE_NORMAL) then
        msg = msg .."NORMAL _ "
    elseif main_state.option(MAIN.OP.JUDGE_HARD) then
        msg = msg .."HARD _ "
    elseif main_state.option(MAIN.OP.JUDGE_VERYHARD) then
        msg = msg .."VERYHARD _ "
    else
        msg = msg .."UNKNOWN _ "
    end
    return msg
end
--[[
    指定フォルダの作成
    path: フォルダパス
]]
m.mkdir = function(path)
    local dir = luajava.new(File, path)
    local flg = dir:mkdir()
    if flg then
        if DEBUG then print("CF: " ..path .."作成完了") end
    else
        if DEBUG then print("CF: " ..path .."フォルダ作成済み") end
    end
end
-- 指定フォルダの検索条件にあったファイルのパスと検索数を取得
m.getSearchFiles = function(path, regexp)
    local con = ""
    local dir = luajava.new(File, path)
    local target
    local a,b
    local count = 0
    -- フォルダ内ファイル名取得
    local filelists = dir:listFiles()
    -- ファイル名の整形
    for i = 1, #filelists, 1 do
--        if DEBUG then print("gSF:" ..tostring(filelists[i])) end
        a = tostring(filelists[i])
        b = string.gsub(a, "\\", "/")
        target = string.match(b, regexp)
--        if DEBUG then print(target) end
        if target ~= nil then
            con = con ..target .."\n"
            count = count + 1
        end
    end
    -- 整形したファイルパスと件数を返す
    return con, count
end
-- ファイルの作成と初期化処理
m.writeFile = function(path, con)
    local f = io.open(path, "w")
    f:write(con)
    f:close()
    if DEBUG then print("CF:" ..path .."書き込み完了_writeFile") end
end
-- ファイルに追記
m.postscriptFile = function(path, con)
    local f = io.open(path, "a")
    f:write(con)
    f:close()
    if DEBUG then print("CF:" ..path .."追記完了_postscriptFile") end
end
-- ファイルの読み込み
m.loadFile = function(path)
    local pathfile = io.open(path)
    local pathlist = {}
    for line in pathfile:lines() do
        pathlist[#pathlist+1] = line
        if DEBUG then print("CF:" ..line) end
    end
    pathfile:close()
    if DEBUG then print("CF:" ..path .."読み込み完了_loadFile") end
    return pathlist
end
-- 変数への格納
m.storeFile = function(con)
    local content = ""
    for i = 1, #con, 1 do
        content = content ..con[i]
    end
    return content
end
-- ファイルのリセット
m.resetFile = function(path)
    local f = io.open(path, "w")
    f:write()
    f:close()
    if DEBUG then print("CF:" ..path .."リセット完了_resetFile") end
end
-- すべてのファイルリストから除外対象を除外
m.choiceList = function(stringList, stringExcludeList)
    local cl = {}
    local flag
    for _,v in ipairs(stringList) do
        flag = 1
        for _,v2 in ipairs(stringExcludeList) do
            if v == v2 then
                flag = nil
                break
            end
        end
        if flag then
            cl[#cl + 1] = v
        end
    end
    return cl
end

--[[
    ローテーション用（汎用）
    partsFolder: 検索フォルダ
    logFolder: ログ出力先
    regexp: 正規表現パタン
]]
m.randomChoice = function(partsFolder, logFolder, regexp)
    -- パーツ場所フォルダ
    local parts = skin_config.get_path(partsFolder)
    -- ログ出力先
    local all = skin_config.get_path(logFolder .."pathList.txt")
    local exclusion = skin_config.get_path(logFolder .."excludeList.txt")
    -- 検索
    local con, fcount = m.getSearchFiles(parts, regexp)
    -- ファイル存在チェック
    if m.existFile(all) == false then
        m.writeFile(all, con)
    end
    if m.existFile(exclusion) == false then
        m.createFile(exclusion)
    end
    -- フォルダの件数とファイルの件数が一致しない場合は更新処理
    if fcount ~= m.countRecords(all, 0) then
        m.writeFile(all, con)
        m.resetFile(exclusion)
        print("CF:ALL_EXCLUDE_INIT")
    end
    -- 全ファイルと除外ファイルの読み込み
    local pathlist = m.loadFile(all)
    local excludelist = m.loadFile(exclusion)
    -- 除外ファイル数がすべてのファイル数以上のときは一巡したと判断して初期化
    if #excludelist >= #pathlist then
        m.resetFile(exclusion)
        excludelist = {}
        print("CF:EXCLUDE_RESET")
    end
    local choicePathList = m.choiceList(pathlist, excludelist)
    -- 除外されたリストからランダムで選択
    local choicePath = choicePathList[math.random(#choicePathList)]
    -- 除外リストに追加
    io.open(exclusion, "a"):write(choicePath.."\n"):close()
    print("CF:ALL_" ..partsFolder .." : " ..#pathlist)
    print("CF:EXCLUDE_" ..logFolder .." : " ..#excludelist + 1)
    return choicePath
end

--[[
    ローテーション用（2段階用）
    partsFolder: 検索フォルダ
    logFolder: ログ出力先
    regexp: 正規表現パタン
    init: 初期化を必要とする場合はtrue
]]
m.randomChoiceStep1 = function(partsFolder, logFolder, regexp, init)
    -- パーツ場所フォルダ
    local parts = skin_config.get_path(partsFolder)
    -- ログ出力先
    local all = skin_config.get_path(logFolder .."pathList.txt")
    local exclusion = skin_config.get_path(logFolder .."excludeList.txt")
    local temp = skin_config.get_path(logFolder .."temp.txt")
    -- 検索
    local con, fcount = m.getSearchFiles(parts, regexp)
    -- ファイル存在チェック
    if m.existFile(all) == false then
        m.writeFile(all, con)
    end
    if m.existFile(exclusion) == false then
        m.createFile(exclusion)
    end
    if m.existFile(temp) == false then
        m.createFile(temp)
    end
    -- 一時ファイルのリセット
    if init then
        m.resetFile(temp)
    end
    -- フォルダの件数とファイルの件数が一致しない場合は更新処理
    if fcount ~= m.countRecords(all, 0) then
        m.writeFile(all, con)
        m.resetFile(exclusion)
        m.resetFile(temp)
        print("CF:ALL_EXCLUDE_INIT")
    end
    -- 全ファイルと除外ファイルの読み込み
    local pathlist = m.loadFile(all)
    local excludelist = m.loadFile(exclusion)
    -- 除外ファイル数がすべてのファイル数以上のときは一巡したと判断して初期化
    if #excludelist >= #pathlist then
        m.resetFile(exclusion)
        excludelist = {}
        print("CF:EXCLUDE_RESET")
    end
    local choicePathList = m.choiceList(pathlist, excludelist)
    -- 除外されたリストからランダムで選択
    local choicePath = choicePathList[math.random(#choicePathList)]
    -- 一時対比ファイルに選択されたパスを追記
    m.postscriptFile(temp, choicePath .."\n")
    print("CF:ALL_" ..partsFolder .." : " ..#pathlist)
    print("CF:EXCLUDE_" ..logFolder .." : " ..#excludelist + 1)
    return choicePath
end
--[[
    ローテーション用（2段階用）
    一時退避した対象を除外対象に追加
]]
m.randomChoiceStep2 = function(logFolder)
    local exclusion = skin_config.get_path(logFolder .."excludeList.txt")
    local temp = skin_config.get_path(logFolder .."temp.txt")
    -- 一時退避ファイルの読み込み
	local file = io.open(temp, "r")
	local path = ""
	for line in file:lines() do
--        path = line
        path = path ..line .."\n"
	end
	file:close()
    -- 除外ファイルに追記
    m.postscriptFile(exclusion, path)
end

--[[
    -- 掲示板出力機能
    flg: 0:play, 5:select, 6:decide, 7:result, 15:course
]]
m.infoOutput = function(flg)
    local msg = ""
    local filePath = skin_config.get_path("History/information.txt")
    -- ファイルが存在しない場合は新規作成
    if m.existFile(filePath) == false then
        m.createFile(filePath)
    end
    local f = io.open(filePath, "w")
    if flg == 0 then
        local fulltitle = main_state.text(MAIN.STRING.FULLTITLE) .." _ "
        local artist = main_state.text(MAIN.STRING.ARTIST) .." _ "
        local genre = main_state.text(MAIN.STRING.GENRE) .." _ "
        local peak = "最大瞬間密度 " ..main_state.number(MAIN.NUM.DENSITY_PEAK) .."." ..main_state.number(MAIN.NUM.DENSITY_PEAK_AFTERDOT) .." notes/sec _ "
        local average = "平均密度 " ..main_state.number(MAIN.NUM.DENSITY_AVERAGE) .."." ..main_state.number(MAIN.NUM.DENSITY_AVERAGE_AFTERDOT) .." notes/sec _ "
        local playtime = "演奏時間 " ..main_state.number(MAIN.NUM.TIMELEFT_MINUTE) .."分" ..main_state.number(MAIN.NUM.TIMELEFT_SECOND) .."秒 _ "
        local notes = "ノート数 " ..main_state.number(MAIN.NUM.TOTALNOTES) .." _ "
        local judgelevel = m.judgeLevel()
        if CONFIG.play.playscreenMessage == 0 then
            f:write(fulltitle ..artist ..genre)
        elseif CONFIG.play.playscreenMessage == 1 then
            f:write(fulltitle ..artist ..genre ..peak ..average)
        elseif CONFIG.play.playscreenMessage == 2 then
            f:write(fulltitle ..artist ..genre ..peak ..average ..judgelevel ..playtime ..notes)
        end
        msg = "CF:プレイ中タイトル出力完了"
    elseif flg == 5 then
        if PROPERTY.isviewHistoryOff() then
            f:write("Welcome to " ..main_state.text(MAIN.STRING.VERSION) .." world!!! ModernChicSkin.." ..main_state.text(MAIN.STRING.IR_NAME) .."..ACCESS....")
            msg = "CF:セレクトインフォメーション出力完了"
        elseif PROPERTY.isviewHistoryOn() then
            local date = main_state.number(MAIN.NUM.TIME_YEAR) .."/" ..main_state.number(MAIN.NUM.TIME_MONTH) .."/" ..main_state.number(MAIN.NUM.TIME_DAY) .." "
            local play = "プレイ数：" ..CUSTOM.NUM.todaySongUpdateCount .." _ "
            local clear  = "ランプ更新数：" ..CUSTOM.NUM.todayClearUpdateCount .." _ "
            local score  = "スコア更新数：" ..CUSTOM.NUM.todayScoreUpdateCount .." _ "
            local miss  = "ミスカン更新数：" ..CUSTOM.NUM.todayMissUpdateCount .." _ "
            local msg = main_state.text(MAIN.STRING.VERSION) .."..ModernChicSkin.." ..main_state.text(MAIN.STRING.IR_NAME) .."..ACCESS...."
            f:write(date ..play ..clear ..score ..miss ..msg)
            msg = "CF:セレクトインフォメーション出力完了"
        end
    elseif flg == 7 then
        f:write(m.rampConverter(main_state.number(MAIN.NUM.CLEAR)) .." ")
        msg = "CF:リザルトインフォメーション出力完了"
    elseif flg == 15 then
        f:write("COURSE:" ..m.rampConverter(main_state.number(MAIN.NUM.CLEAR)) .." ")
        msg = "CF:コースインフォメーション出力完了"
    end
    f:close()
    if DEBUG then print(msg) end
end

--[[
    BPM連動版ぽみゅきゃらみたいなやつのキャラクター選択
]]
m.selectBpmLinkChar = function()
    local char
    if CONFIG.bpmLinkChar.charctor == 0 then char = "*" return char end
    if CONFIG.bpmLinkChar.charctor == 1 then char = "zundamon"  return char end
    if CONFIG.bpmLinkChar.charctor == 2 then char = "zundamon2"  return char end
    if CONFIG.bpmLinkChar.charctor == 3 then char = "zundamon3"  return char end
    if CONFIG.bpmLinkChar.charctor == 4 then char = "tsumugi"  return char end
    if CONFIG.bpmLinkChar.charctor == 5 then char = "yuki"  return char end
    char = "*"
    return char
end

return m