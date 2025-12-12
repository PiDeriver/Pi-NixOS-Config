--[[
    動作条件
    オートプレイではない or リプレイ再生時ではない
    動作タイミング
    閉店時 or 曲終了時

    ファイルをオープンし、リストに読み込む
    1行目がプレイ中曲のタイトルに一致しないなら
        1行目にプレイ中曲のタイトルを代入
        2行目にプレイ情報を代入
    そうでないなら(粘着中)
        最終行に現在のプレイ情報を挿入
    ファイルを保存して閉じる

    プレイ情報
    回数 到達ノート数 スコアレート FAST SLOW
    ]]
    DEBUG = false
    local m = {}
    -- 粘着データパス
    local FILEPATH = skin_config.get_path("io/Play/sp/nentyaku.txt")

    local function split(line, delimiter)
        if delimiter == nil then return {} end
        local t = {}
        for s in string.gmatch(line, "([^"..delimiter.."]+)") do
            t[#t+1] = s
        end
        return t
    end
    
    m.updatehistory = function(title, data)
        local lined = {}
        -- ファイルが存在しない場合は新規作成
        if CUSTOM.FUNC.existFile(FILEPATH) == false then
            CUSTOM.FUNC.createFile(FILEPATH)
        end
        local fh = io.open(FILEPATH)
        for line in fh:lines() do
            lined[#lined + 1] = line
        end
        fh:close()
        local ftitle = lined[1]
        if title == ftitle then
            -- 2回目以降の粘着は追記
            fh = io.open(FILEPATH, "a")
            fh:write(string.format("%02d", #lined) .. "\t" .. table.concat(data, "\t") .. "\n")
        else
            -- 初回時はタイトル開業後にデータの書き込み
            fh = io.open(FILEPATH, "w")
            fh:write(title .. "\n")
            fh:write(string.format("%02d", 1) .. "\t" .. table.concat(data, "\t") .. "\n")
        end
        fh:close()
    end
    
    m.getnentyakudata = function()
        -- ファイルが存在しない場合は新規作成
        if CUSTOM.FUNC.existFile(FILEPATH) == false then
            CUSTOM.FUNC.createFile(FILEPATH)
        end
        local fh = io.open(FILEPATH)
        local lined = {}
        local data = {}
        local title = nil
        for line in fh:lines() do
            if title then
                lined[#lined + 1] = line
            else
                title = line
            end
        end
        for _, line in ipairs(lined) do
            data[#data + 1] = split(line, "\t")
        end
        -- データをひっくり返す
        local data2 = {}
        local count = 1
        for i = #data, 1, -1 do
            -- 10件以上は取得しない（表示領域を超えてしまうため）
            if count <= 10 then
                data2[count] = data[i]
                count = count + 1
            else
                break
            end
        end

        return title, data2, #data
    end
    
    return m