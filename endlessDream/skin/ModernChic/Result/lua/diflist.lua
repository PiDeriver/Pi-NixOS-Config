--[[
    自作難易度表への追加
    @author : KASAKO
]]
-- 直近履歴
local function saveDifList()
    -- TODO jsonで出力してしまうとスキンと認識されて強制終了してしまうのでtxtで回避
    local filePath = skin_config.get_path("difflist.txt")
    -- ファイルが存在しない場合は新規作成
    if CUSTOM.FUNC.existFile(filePath) == false then
        CUSTOM.FUNC.writeFile(filePath, "[{" .."\"title\":\"" ..main_state.text(MAIN.STRING.TITLE) .."\"," .."\"artist\":\"" ..main_state.text(MAIN.STRING.ARTIST) .."\"," .."\"level\":\"" ..main_state.number(MAIN.NUM.PLAYLEVEL) .."\"," .."\"md5\":\"" ..main_state.text(MAIN.STRING.SONG_HASH_MD5) .."\"," .."\"sha256\":\"" ..main_state.text(MAIN.STRING.SONG_HASH_SHA256) .."\"" .."}]")
        return
    end
     -- これまでの情報をテーブルに格納
    local content = CUSTOM.FUNC.loadFile(filePath)
    local content2 = CUSTOM.FUNC.storeFile(content)
    -- 末尾の]を取り除く
    local content3 = string.sub(content2, 1, -2)
    -- 追記書き込み
    local g = io.open(filePath, "w")
    g:write(content3 ..",{" .."\"title\":\"" ..main_state.text(MAIN.STRING.TITLE) .."\"," .."\"artist\":\"" ..main_state.text(MAIN.STRING.ARTIST) .."\"," .."\"level\":\"" ..main_state.number(MAIN.NUM.PLAYLEVEL) .."\"," .."\"md5\":\"" ..main_state.text(MAIN.STRING.SONG_HASH_MD5) .."\"," .."\"sha256\":\"" ..main_state.text(MAIN.STRING.SONG_HASH_SHA256) .."\"" .."}]")
    g:close()
    print("DIFLIST:難易度表追記完了")
end

local function difBtn(parts)
    local difBtn = true
	-- 表示スイッチ
	table.insert(parts.image, {id = "difBtn", src = 6, x = 560, y = 750, w = 60, h = 50, act = function()
		difBtn = not difBtn
        saveDifList()
		CUSTOM.SOUND.calculatorChangeSound()
	end})
	table.insert(parts.destination, {id = "difBtn", draw = function()
        return difBtn
    end, dst = {
		{time = 0, x = 1920 - 60, y = 0, w = 60, h = 50},
		{time = 2000, a = 100},
		{time = 4000, a = 255}
	}})
end

local function load()
    local parts = {}
    parts.image = {}
    parts.destination = {}
    difBtn(parts)
    return parts
end

return {
    load = load
}
