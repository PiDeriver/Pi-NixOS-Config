--[[
    ランダムローテーション
    DATE:22/07/05
    @author : KASAKO
]]
local module = {}
module.backgroundRandomChoice = function(info, num)
    -- パーツ場所フォルダ
    local parts = skin_config.get_path(info.partsFolder[num])
    -- ログ出力先
    local all = skin_config.get_path(info.logFolder ..info.path[num] .."_pathList.txt")
    local exclusion = skin_config.get_path(info.logFolder ..info.path[num] .."_excludeList.txt")
    -- 検索
    local con, fcount = CUSTOM.FUNC.getSearchFiles(parts, "Result.+%.png")
    -- ファイル存在チェック
    if CUSTOM.FUNC.existFile(all) == false then
        CUSTOM.FUNC.writeFile(all, con)
    end
    if CUSTOM.FUNC.existFile(exclusion) == false then
        CUSTOM.FUNC.createFile(exclusion)
    end
    -- フォルダの件数とファイルの件数が一致しない場合は更新処理
    if fcount ~= CUSTOM.FUNC.countRecords(all, 0) then
        CUSTOM.FUNC.writeFile(all, con)
        CUSTOM.FUNC.resetFile(exclusion)
        print("BG_ALL_EXCLUDE_INIT")
    end
    -- 全ファイルと除外ファイルの読み込み
    local pathlist = CUSTOM.FUNC.loadFile(all)
    local excludelist = CUSTOM.FUNC.loadFile(exclusion)
    -- 除外ファイル数がすべてのファイル数以上のときは一巡したと判断して初期化
    if #excludelist >= #pathlist then
        CUSTOM.FUNC.resetFile(exclusion)
        excludelist = {}
        print("BG_EXCLUDE_RESET")
    end
    local choicePathList = CUSTOM.FUNC.choiceList(pathlist, excludelist)
    -- 除外されたリストからランダムで選択
    local choicePath = choicePathList[math.random(#choicePathList)]
    -- 実際に使われた場合のみ除外対象に追加する必要がある-----------------------------
    if PROPERTY.isBackgroundClearFailed() then
        for i = 1, 2, 1 do
            if (num == i) and (main_state.option(info.op[num])) then
                io.open(exclusion, "a"):write(choicePath.."\n"):close()
                print("BGCF_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                print("BGCF_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
            end
        end
    elseif PROPERTY.isBackgroundAll() then
        io.open(exclusion, "a"):write(choicePath.."\n"):close()
        print("BGALL_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
        print("BGALL_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
    elseif PROPERTY.isBackgroundRank() then
        for i = 1, 8, 1 do
            if (num == i) and (main_state.option(info.op[num])) then
                io.open(exclusion, "a"):write(choicePath.."\n"):close()
                print("BGRANK_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                print("BGRANK_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
            end
        end
    elseif PROPERTY.isBackgroundClearType() then
        if CUSTOM.OP.isCourse() then
            for i = 1, 2, 1 do
                if (num == i) and (main_state.option(info.op[num])) then
                    io.open(exclusion, "a"):write(choicePath.."\n"):close()
                    print("BG_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                    print("BG_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
                end
            end
        else
            for i = 1, 10, 1 do
                if (num == i) and ( i == main_state.event_index(MAIN.NUM.CLEAR))then
                    io.open(exclusion, "a"):write(choicePath.."\n"):close()
                    print("ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                    print("EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
                end
            end
        end
    end
    return choicePath
end

-- キャラクター表示用
module.charctorRandomChoice = function(info, num)
    -- パーツ場所フォルダ
    local parts = skin_config.get_path(info.partsFolder[num])
    -- ログ出力先
    local all = skin_config.get_path(info.logFolder ..info.path[num] .."_pathList.txt")
    local exclusion = skin_config.get_path(info.logFolder ..info.path[num] .."_excludeList.txt")
    -- 検索
    local con, fcount = CUSTOM.FUNC.getSearchFiles(parts, "Result.+%.png")
    -- ファイル存在チェック
    if CUSTOM.FUNC.existFile(all) == false then
        CUSTOM.FUNC.writeFile(all, con)
    end
    if CUSTOM.FUNC.existFile(exclusion) == false then
        CUSTOM.FUNC.createFile(exclusion)
    end
    -- フォルダの件数とファイルの件数が一致しない場合は更新処理
    if fcount ~= CUSTOM.FUNC.countRecords(all, 0) then
        CUSTOM.FUNC.writeFile(all, con)
        CUSTOM.FUNC.resetFile(exclusion)
        print("CHAR_ALL_EXCLUDE_INIT")
    end
    -- 全ファイルと除外ファイルの読み込み
    local pathlist = CUSTOM.FUNC.loadFile(all)
    local excludelist = CUSTOM.FUNC.loadFile(exclusion)
    -- 除外ファイル数がすべてのファイル数以上のときは一巡したと判断して初期化
    if #excludelist >= #pathlist then
        CUSTOM.FUNC.resetFile(exclusion)
        excludelist = {}
        print("CHAR_EXCLUDE_RESET")
    end
    local choicePathList = CUSTOM.FUNC.choiceList(pathlist, excludelist)
    -- 除外されたリストからランダムで選択
    local choicePath = choicePathList[math.random(#choicePathList)]
    -- 実際に使われた場合のみ除外対象に追加する必要がある-----------------------------
    -- キャラクター
    if PROPERTY.isCharClearFailed() then
        for i = 1, 2, 1 do
            if (num == i) and (main_state.option(info.op[num])) then
                io.open(exclusion, "a"):write(choicePath.."\n"):close()
                print("CHARCF_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                print("CHARCF_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
            end
        end
    elseif PROPERTY.isCharAll() then
        io.open(exclusion, "a"):write(choicePath.."\n"):close()
        print("CHARALL_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
        print("CHARALL_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
    elseif PROPERTY.isCharRank() then
        for i = 1, 8, 1 do
            if (num == i) and (main_state.option(info.op[num])) then
                io.open(exclusion, "a"):write(choicePath.."\n"):close()
                print("CHARRANK_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                print("CHARRANK_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
            end
        end
    elseif PROPERTY.isCharClearType() then
        if CUSTOM.OP.isCourse() then
            for i = 1, 2, 1 do
                if (num == i) and (main_state.option(info.op[num])) then
                    io.open(exclusion, "a"):write(choicePath.."\n"):close()
                    print("CHAR_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                    print("CHAR_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
                end
            end
        else
            for i = 1, 10, 1 do
                if (num == i) and ( i == main_state.event_index(MAIN.NUM.CLEAR))then
                    io.open(exclusion, "a"):write(choicePath.."\n"):close()
                    print("CHAR_ALL_" ..info.partsFolder[num] .." : " ..#pathlist)
                    print("CHAR_EXCLUDE_" ..info.logFolder ..info.path[num] .." : " ..#excludelist + 1)
                end
            end
        end
    end
    return choicePath
end

return module