local songprogress = {}
local v = require("lua/values")

function songprogress.create(skin)
    local songprogress_w = 8 * v.x
    local songprogress_h = 2 * v.x
    local songprogress_ex_w = 8 * v.x
    local songprogress_ex_h = 8 * v.x
    local songprogress_range = 240 * v.x
    local songprogress_start_x = 200 * v.x
    local songprogress_start_y = 50 * v.x
    table.insert(skin.slider, {id = "songprogress", src = "src-songprogress",
        x = 0, y = 0, w = songprogress_w, h = songprogress_h, angle = 1, range = songprogress_range-songprogress_w, type = 6
    })
    table.insert(skin.slider, {id = "songprogress-glow", src = "src-songprogress",
        x = 1*songprogress_w, y = 0, w = songprogress_w+songprogress_ex_w, h = songprogress_h+songprogress_ex_h, angle = 1, range = songprogress_range-songprogress_w, type = 6
    })

    table.insert(skin.destination, {id = "songprogress-glow", timer = 140, loop = 0, dst = {
        {time = 0, a = 255, x = songprogress_start_x-songprogress_ex_w/2, y = songprogress_start_y-songprogress_ex_h/2, w = songprogress_w+songprogress_ex_w, h = songprogress_h+songprogress_ex_h},
        {time = 800, a = 0},
        {time = 1000, a = 255}
    }})
    table.insert(skin.destination, {id = "songprogress", dst = {
        {x = songprogress_start_x, y = songprogress_start_y, w = songprogress_w, h = songprogress_h}
    }})
end

return songprogress
