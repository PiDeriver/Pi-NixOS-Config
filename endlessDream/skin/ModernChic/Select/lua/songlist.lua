--[[
    曲リスト部分
    @author : KASAKO
]]
local function createSonglistProperty()
    local songlist = {}
    songlist.id = "songlist"
    songlist.center = 8
    songlist.clickable = {6,7,8,9,10}
    songlist.liston = {}
    songlist.listoff = {}
    songlist.level = {}
    songlist.label = {}
    songlist.text = {}
    songlist.lamp = {}
    songlist.playerlamp = {}
    songlist.rivallamp = {}
    songlist.trophy = {}
    songlist.graph = {id = "graph-lamp", dst = {{x = 40, y = 5, w = 650, h = 10}}}

    -- リスト表示位置
    do
        local songlist_num = 17
        local songlist_x = {}
        local songlist_loop = {1650, 1600, 1550, 1500, 1450, 1400, 1350, 1300, 1250, 1300, 1350, 1400, 1450, 1500, 1550, 1600, 1650}
        local songlist_start = {1400, 1350, 1300, 1250, 1200, 1150, 1100, 1050, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400}
        -- 各パターンのx座標を指定
        if PROPERTY.isSonglistStraight() then
            songlist_x = {1160, 1160, 1160, 1160, 1160, 1160, 1160, 1160, 1125, 1160, 1160, 1160, 1160, 1160, 1160, 1160, 1160}
        elseif  PROPERTY.isSonglistArch() then
            songlist_x = {1288, 1249, 1215, 1186, 1168, 1151, 1139, 1128, 1125, 1128, 1139, 1151, 1168, 1186, 1215, 1249, 1288}
        elseif PROPERTY.isSonglistDiagonally() then
            songlist_x = {1325, 1300, 1275, 1250, 1225, 1200, 1175, 1150, 1125, 1100, 1075, 1050, 1025, 1000, 975, 950, 925}
        end
        -- y座標の指定
        local songlist_y = {1065, 995, 925, 855, 785, 715, 645, 575, 505, 435, 365, 295, 225, 155, 85, 15, -55}
        -- バーの表示位置決定
        for i = 1, songlist_num, 1 do
            table.insert(songlist.liston, {
                id = "bar", dst = {
                    {x = 1125, y = songlist_y[i], w = 960, h = 70}
                }
            })
            table.insert(songlist.listoff, {
                id = "bar", loop = songlist_loop[i], dst = {
                    {time = songlist_start[i], x = 1920, y = songlist_y[i], w = 960, h = 70, acc = MAIN.ACC.DECELERATE},
                    {time = songlist_loop[i], x = songlist_x[i]}
                }
            })
        end
    end

    -- 難易度ごとのレベル表記
    do
        local diff = {"unknown", "beginner", "normal", "hyper", "another", "insane"}
        for i = 1, #diff, 1 do
            table.insert(songlist.level, {
                id = "level-" ..diff[i], dst = {
                    {x = 30, y = 13, w = 35, h = 42}
                }
            })
        end
    end

    -- 特殊なBMSの表示
    table.insert(songlist.label, {
        -- LNあり
        id = "label-ln", dst = {
            {x = -90, y = 5, w = 85, h = 54}
        }
    })
    table.insert(songlist.label, {
        -- RANDOMノートあり
        id = "label-random", dst = {
            {time = 0, x = 525, y = 6, w = 111, h = 54, a = 255},
            {time = 1000, a = 180},
            {time = 2000, a = 255}
        }
    })
    table.insert(songlist.label, {
        -- 地雷あり
        id = "label-bomb", dst = {
            {time = 0, x = 640, y = 6, w = 90, h = 54, a = 255},
            {time = 1000, a = 180},
            {time = 2000, a = 255}
        }
    })
    table.insert(songlist.label, {
        -- CN強制
        id = "label-cn", dst = {
            {x = -90, y = 5, w = 85, h = 54}
        }
    })
    table.insert(songlist.label, {
        -- HCN強制
        id = "label-hcn", dst = {
            {x = -90, y = 5, w = 85, h = 54}
        }
    })
    -- テキスト
    -- 通常
    -- 新規
    -- SongBar（通常）
    -- SongBar（新規）
    -- FolderBar（通常）
    -- FolderBar（新規）
    -- TableBar or HashBar
    -- GradeBar（曲所持）
    -- SongBar or GradeBar（曲未所持）
    -- CommandBar or ContainerBar
    -- SearchWordBar
    do
        local posX  = {130, 130, 130, 130, 50,  50,  50,  130, 130, 50,  50}
        local red   = {255, 255, 255, 255, 255, 255, 255, 255, 200, 255, 255}
        local green = {255, 255, 255, 255, 255, 255, 255, 255, 200, 255, 255}
        local blue  = {255, 0,   255, 0,   255, 0,   255, 255, 200, 255, 255}
        for i = 1, 11, 1 do
            table.insert(songlist.text, {
                id = "bartext", dst = {
                    {x = posX[i], y = 15, w = 500, h = 35, r = red[i], g = green[i], b = blue[i]}
                }
            })
        end
    end
    -- ランプ状況
    do
        -- マイランプ
        local lampName = {"failed", "assist", "laassist", "easy", "normal", "hard", "exhard", "fullcombo", "perfect", "max"}
        table.insert(songlist.lamp, {
            id = "lamp-noplay", dst = {
                {x = -8, y = -7, w = 41, h = 84}
            }
        })
        for i = 1, #lampName, 1 do
            table.insert(songlist.lamp, {
                id = "lamp-" ..lampName[i], dst = {
                    {time = 0, x = -8, y = -7, w = 41, h = 84},
                    {time = 1000, a = 200},
                    {time = 2000, a = 255},
                }
            })
        end
        -- マイランプ（ライバル選択時）
        table.insert(songlist.playerlamp, {
            id = "lamp-noplay", dst = {
                {x = -8, y = 30, w = 41, h = 42}
            }
        })
        for i = 1, #lampName, 1 do
            table.insert(songlist.playerlamp, {
                id = "lamp-" ..lampName[i], dst = {
                    {time = 0, x = -8, y = 30, w = 41, h = 42},
                    {time = 1000, a = 200},
                    {time = 2000, a = 255},
                }
            })
        end
        -- ライバルランプ（ライバル選択時）
        table.insert(songlist.rivallamp, {
            id = "lamp-noplay", dst = {
                {x = -8, y = -3, w = 41, h = 42}
            }
        })
        for i = 1, #lampName, 1 do
            table.insert(songlist.rivallamp, {
                id = "lamp-" ..lampName[i], dst = {
                    {time = 0, x = -8, y = -3, w = 41, h = 42},
                    {time = 1000, a = 200},
                    {time = 2000, a = 255},
                }
            })
        end
    end
    -- トロフィー機能
    do
        local trophyName = {"bronze", "silver", "gold"}
        for i = 1, #trophyName, 1 do
            table.insert(songlist.trophy, {
                id = "trophy-" ..trophyName[i], dst = {
                    {x = 37, y = 8, w = 54, h = 54}
                }
            })
        end
    end
    return songlist
end

local function load()
    local parts = {}

    local lampCycle = 50

    parts.image = {
        -- 選曲バー
        {id = "selectmusic-frame", src = 7, x = 0, y = 560, w = 990, h = 82},
        {id = "bar-song", src = 7, x = 0, y = 0, w = 960, h = 70},
        {id = "bar-command", src = 7, x = 0, y = 70, w = 960, h = 70},
        {id = "bar-grade", src = 7, x = 0, y = 140, w = 960, h = 70},
        {id = "bar-nosong", src = 7, x = 0, y = 420, w = 960, h = 70},
        {id = "bar-table", src = 7, x = 0, y = 210, w = 960, h = 70},
        {id = "bar-folder", src = 7, x = 0, y = 280, w = 960, h = 70},
        {id = "bar-search", src = 7, x = 0, y = 350, w = 960, h = 70},
        {id = "lamp-noplay", src = 7, x = 123, y = 660, w = 41, h = 84},
        {id = "lamp-failed", src = 7, x = 41, y = 660, w = 82, h = 84, divx = 2, cycle = lampCycle},
        {id = "lamp-assist", src = 7, x = 0, y = 1332, w = 41, h = 84},
        {id = "lamp-laassist", src = 7, x = 0, y = 1248, w = 41, h = 84},
        {id = "lamp-easy", src = 7, x = 0, y = 744, w = 41, h = 84},
        {id = "lamp-normal", src = 7, x = 0, y = 828, w = 41, h = 84},
        {id = "lamp-hard", src = 7, x = 0, y = 912, w = 41, h = 84},
        {id = "lamp-exhard", src = 7, x = 0, y = 996, w = 82, h = 84, divx = 2, cycle = lampCycle},
        {id = "lamp-fullcombo", src = 7, x = 0, y = 1080, w = 123, h = 84, divx = 3, cycle = lampCycle},
        {id = "lamp-perfect", src = 7, x = 0, y = 1164, w = 123, h = 84, divx = 3, cycle = lampCycle},
        {id = "lamp-max", src = 7, x = 0, y = 1164, w = 123, h = 84, divx = 3, cycle = lampCycle},
        {id = "label-ln", src = 7, x = 0, y = 499, w = 85, h = 54},
        {id = "label-cn", src = 7, x = 85, y = 499, w = 85, h = 54},
        {id = "label-hcn", src = 7, x = 170, y = 499, w = 85, h = 54},
        {id = "label-bomb", src = 7, x = 530, y = 499, w = 90, h = 54},
        {id = "label-random", src = 7, x = 620, y = 499, w = 111, h = 54},
        {id = "trophy-bronze", src = 7, x = 363, y = 499, w = 54, h = 54},
        {id = "trophy-silver", src = 7, x = 417, y = 499, w = 54, h = 54},
        {id = "trophy-gold", src = 7, x = 471, y = 499, w = 54, h = 54},
        -- 選択曲部分
		{id = "selectmusicFrameTop", src = 7, x = 0, y = 560, w = 17, h = 82},
		{id = "selectmusicFrameBottom", src = 7, x = 17, y = 560, w = 963, h = 82},
    }
	parts.imageset = {
		{id = "bar", images = {"bar-song", "bar-folder", "bar-table", "bar-grade", "bar-nosong", "bar-command", "bar-search"}},
    }
	parts.value = {
		-- 選曲レベル
		{id = "level-beginner", src = 7, x = 400, y = 702, w = 420, h = 42, divx = 10, digit = 2, align = 2, ref = 96},
		{id = "level-normal", src = 7, x = 400, y = 744, w = 420, h = 42, divx = 10, digit = 2, align = 2, ref = 96},
		{id = "level-hyper", src = 7, x = 400, y = 786, w = 420, h = 42, divx = 10, digit = 2, align = 2, ref = 96},
		{id = "level-another", src = 7, x = 400, y = 828, w = 420, h = 42, divx = 10, digit = 2, align = 2, ref = 96},
		{id = "level-insane", src = 7, x = 400, y = 870, w = 420, h = 42, divx = 10, digit = 2, align = 2, ref = 96},
		{id = "level-unknown", src = 7, x = 400, y = 912, w = 420, h = 42, divx = 10, digit = 2, align = 2,ref = 96},
    }
    parts.graph = {
        {id = "graph-lamp", src = 7, x = 1010, y = 90, w = 11, h = 60, divx = 11, divy = 6, cycle = 100, type = -1},
    }
    parts.songlist = createSonglistProperty()
    
	parts.destination = {
		-- リスト表示
		{id = "songlist"},
		-- 選択曲フレーム
		{id = "selectmusic-frame", dst = {
			{x = 1112, y = 499, w = 990, h = 82}
		}},
		{id = "selectmusicFrameTop", loop = 1000, blend = MAIN.BLEND.ADDITION, dst = {
			{time = 1000, x = 1112, y = 499, w = 17, h = 82, a = 0},
			{time = 1200, a = 255},
			{time = 2000},
			{time = 3000, a = 0},
			{time = 4000}
		}},
		{id = "selectmusicFrameBottom", loop = 1000, blend = MAIN.BLEND.ADDITION, dst = {
			{time = 1000, x = 1129, y = 499, w = 0, h = 82, a = 0},
			{time = 1200, w = 200, a = 255},
			{time = 2000, w = 963},
			{time = 3000, a = 0},
			{time = 4000}
		}},
    }
    
    return parts
end

return {
	load = load
}