--[[
    参考
    https://blog.officekoma.co.jp/2016/07/urlconnectionhttpurlconnectionget.html
    https://developer.mozilla.org/ja/docs/Web/HTTP/Status
    https://www.javadrive.jp/start/stream/index3.html
    @author : KASAKO
]]
local luajava = require("luajava")
local module = {}
-- 文字列を真偽値に変換
local function toboolean(val)
    if tostring(val) == "true" then
        return true
    end
    if tostring(val) == "false" then
        return false
    end
    return nil
end
local function httpConnection(url)
    local lines = {}
    local url2 = luajava.newInstance("java.net.URL", url);
    local urlConn = url2:openConnection()
    urlConn:setRequestMethod("GET")
    urlConn:setConnectTimeout(200)
    if pcall(function() urlConn:connect() end) then
        -- HTTPステータスコード取得
        local status = urlConn:getResponseCode()
        -- 成功
        if status == 200 then
            print("http:接続成功")
            local reader = luajava.newInstance("java.io.BufferedReader", luajava.newInstance("java.io.InputStreamReader", urlConn:getInputStream(), "utf8"))
            local hasLine = true
            while hasLine do
                -- テキストを1行単位で読む 終わりに達するとnull
                local line = reader:readLine()
                if line then
                    table.insert(lines, line)
                else
                    hasLine = false
                end
            end
        else
            print("HTTPステータスエラー：" ..status)
        end
    else
        print("error:接続失敗")
        return
    end
    -- テキストを返す
    return lines
end
--[[
    次回チェックファイル確認
    存在する場合はtrueを返す
]]
local function existFile(filePath)
    local f = io.open(filePath, "r")
    if f == nil then
        print("http:バージョンチェックファイルが見つかりません")
        return false
    else
        print("http:バージョンチェックファイル確認")
        f:close()
        return true
    end
end
--[[
    次回チェックファイルを作成
    1行目：日時
    2行目：新バージョンがあることが分かっている場合はtrue
]]
local function createFile(filePath)
    local f = io.open(filePath, "w")
    f:write(0 .."\n" .."false")
    f:close()
    print("http:バージョンチェックファイル新規作成")
    return
end
--[[
    次回チェック更新
    1行目：次回更新日時
    2行目：新バージョン情報
]]
local function updateFile(filePath, isNewVer)
    local f = io.open(filePath, "w")
    f:write(os.time() + 60 * 60 * 24 * 7 .."\n" ..tostring(isNewVer))
    f:close()
    print("http:次回チェック日時更新")
end
-- ファイルを読み込む
local function readFile(filePath)
    local contents = {}
    local f = io.open(filePath, "r")
    local count = 0
    for line in f:lines() do
        if count == 0 then
            contents.time = line
        elseif count == 1 then
            contents.exsistNewversion = line
        end
        count = count + 1
    end
    f:close()
    print("http:バージョンチェックファイル読み込み完了")
    return contents
end
-- 更新時かどうかを判断
local function compare(filePath)
    local flg = {}
    flg.time = false
    flg.newversion = false

    local checkData = readFile(filePath)
    -- すでに新バージョンがあると分かっている場合はtrue
    if toboolean(checkData.exsistNewversion) then
        flg.newversion = true
        return flg
    end
    -- 一定時間経過している場合はtrue
    local nowTime = os.time()
    local diff = checkData.time - nowTime
    if diff <= 0 then
        flg.time = true
        return flg
    else
        local hour = math.floor(diff / 60 / 60)
        local min = math.floor((diff - (hour * 60 * 60)) / 60)
        local sec = math.ceil((diff - (hour * 60 * 60)) - (min * 60))
        print("http:次回のチェックは" ..hour .."時間" ..min .."分" ..sec .."秒後です")
        return flg
    end
end
--[[
    バージョンを比較
    最新版が存在する場合はtrueを返す
]]
module.skinVersionCheck = function(version)
    local url = "https://access.kasacontent.com/mcskin/select"
    local filePath = skin_config.get_path("Select/lua/settings/checkversion")
    if existFile(filePath) == false then
        createFile(filePath)
    end
    -- 日時チェック
    local compareFlg, compareValue = pcall(compare, filePath)
    -- 正常に動作したか？
    if compareFlg == false then
        print("error:compareFunctionFailed")
        return false
    elseif toboolean(compareValue.newversion) then
        print("info：スキンが更新されています")
        return true
    elseif compareValue.time == false then
        print("http:一定時間経っていないためバージョンチェックは行いませんでした。")
        return false
    end
    -- バージョンを比較する
    local hcFlg, hcValue = pcall(httpConnection, url)
    if (hcFlg == false) or (hcValue[1] == nil) then
        print("error:httpConnectionFunctionFailed")
        return false
    else
        local isNewVer = tonumber(hcValue[1]) > tonumber(version)
--             print("最新版は" ..hcValue[1])
--             print("このバージョンは" ..version)
        if isNewVer == true then
            local newVerNum = math.max(tonumber(hcValue[1]), tonumber(version))
            print ("http:バージョン" ..newVerNum .."が公開されています。")
        end
        -- 次回のチェック日時を更新
        updateFile(filePath, isNewVer)
        return isNewVer
    end
end
return module
