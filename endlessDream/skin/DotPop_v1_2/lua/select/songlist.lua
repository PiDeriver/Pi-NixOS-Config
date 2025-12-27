local songlist={}
local v = require("lua/values")

function songlist.create(skin)
    
    -- build list resources

    local bar_ids = {'bar-song', 'bar-command', 'bar-grade', 'bar-nosong', 'bar-table', 'bar-folder', 'bar-search'}

    local songbar_height = 20*v.x
    local songbar_width = 276*v.x
    for i = 1,7,1 do
        table.insert(skin.image, {id = bar_ids[i], src = "src-bars", x = 0, y = (i-1)*songbar_height, w = songbar_width, h = songbar_height})
    end

    v.print_r(skin.source)
    v.print_r(skin.image)

    table.insert(skin.imageset, {id = "bar", images = bar_ids})

    -- todo: add numbers to value

    -- build list
    --copied from modernchic atm

    local liston = {}
    local listoff = {}

    local songlist_num = 17
    local songlist_loop = {1650, 1600, 1550, 1500, 1450, 1400, 1350, 1300, 1250, 1300, 1350, 1400, 1450, 1500, 1550, 1600, 1650}
    local songlist_start = {1400, 1350, 1300, 1250, 1200, 1150, 1100, 1050, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400}
    -- local songlist_x = {10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1160, 1160, 1160, 1160, 1160, 1160}
    -- y座標の指定
    -- local songlist_y = {1065, 995, 925, 855, 785, 715, 645, 575, 505, 435, 365, 295, 225, 155, 85, 15, -55}
    local list_start_y = 1065
    -- バーの表示位置決定
    for i = 1, songlist_num, 1 do
        table.insert(liston, {id = "bar", dst = {{x = 1125, y = list_start_y-(i-1)*songbar_height, w = songbar_width, h = songbar_height}}})
        table.insert(listoff, {id = "bar", loop = songlist_loop[i], dst = {
                {time = songlist_start[i], x = 1920, y =  list_start_y-(i-1)*songbar_height, w = songbar_width, h = songbar_height, acc = 2},
                {time = songlist_loop[i], x = 1160}
            }
        })
    end

    -- v.print_r(liston)
    -- v.print_r(listoff)

    table.insert(skin.text, 
        {id = "songlist-text", font = "main-font", size = 10*v.x, overflow = 1, 
         shadowOffsetX = 0.5*v.x, shadowOffsetY = 1*v.x, shadowColor = "00000000"}
    )


    --text setup
    --generic? normal
    --generic? new
    --song
    --song new
    --folder
    --folder new
    --table / hash
    --grade
    --song / grade (dont have song)
    --command / container
    --searchword


    skin.songlist = {
		id = "songlist",
		center = 8,
		clickable = {6,7,8,9,10},
		liston = liston,
		listoff = listoff,
		level = {},
		label = {},
		text = {
            {id = "songlist-text", dst = {{x = 60, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 65, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 70, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 75, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 80, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 85, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 90, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 95, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 100, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 105, y = 3.5*v.x, w = 500, h = 10*v.x}}},
            {id = "songlist-text", dst = {{x = 110, y = 3.5*v.x, w = 500, h = 10*v.x}}},
        },	
		lamp = {},
		playerlamp = {},
		rivallamp = {},
		trophy = {},
		graph = {
			-- id = "graph-lamp", dst = {
			-- 	{x = 40, y = 5, w = 650, h = 10}
			-- },
		},
	}

    table.insert(skin.destination, {id = "songlist"})

    table.insert(skin.destination, {id = "bar-song", dst = {{x = 0,y = 0,w = songbar_width,h = songbar_height}}})

end

return songlist