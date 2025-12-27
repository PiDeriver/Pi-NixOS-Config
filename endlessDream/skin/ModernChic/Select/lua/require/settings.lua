local main_state = require("main_state")

local module = {}

-- 設定新規作成
local function createSettings(filePath)
    local f = io.open(filePath, "w")
    f:write("false\nfalse\nfalse\nfalse")
    f:close()
    print("sidemenu:開閉設定ファイル新規作成")
    return
end

-- 設定ファイルが存在するか
local function existSettings(filePath)
    local f = io.open(filePath, "r")
    if f == nil then
        print("sidemenu:開閉設定ファイルが存在しません")
        return false
    else
        print("sidemenu:開閉設定ファイル確認")
        return true
    end
    f:close()
    return
end

-- 設定読み込み
module.loadingSettings = function()
    local settings = {
        isLampMenuOpen = "",
        isRankingMenuOpen = "",
        isVolumeMenuOpen = "",
        isSettingMenuOpen = "",
    }
    -- 設定ファイルパス
    local filePath = skin_config.get_path("Select/lua/settings/sidemenu")
    if existSettings(filePath) == false then
        createSettings(filePath)
    end
    local f = io.open(filePath, "r")
    -- ファイル読み込み
    local count = 0
    for line in f:lines() do
        if count == 0 then
            settings.isLampMenuOpen = line
        elseif count == 1 then
            settings.isRankingMenuOpen = line
        elseif count == 2 then
            settings.isVolumeMenuOpen = line
        elseif count == 3 then
            settings.isSettingMenuOpen = line
        end
        count = count + 1
    end
    print("sidemenu:開閉設定ファイル読み込み完了")
    f:close()
    return settings
end

-- 設定保存
module.saveSettings = function(flg1, flg2, flg3, flg4)
    local filePath = skin_config.get_path("Select/lua/settings/sidemenu")
    local f = io.open(filePath, "w")
    f:write(tostring(flg1) .."\n" ..tostring(flg2) .."\n" ..tostring(flg3) .."\n" ..tostring(flg4))
    f:close()
--    print("sidemenu:開閉状態保存完了")
    return
end

-- 文字列を真偽値で返す
module.toboolean = function(val)
    if tostring(val) == "true" then
        return true
    end
    if tostring(val) == "false" then
        return false
    end
    return nil
end

return module