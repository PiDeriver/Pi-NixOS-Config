local keys = {}
local v = require("lua/values")

function keys.insertKeybeams(skinDest)
    for i = 1,9,1 do
        table.insert(skinDest, {id = "keybeam"..i, timer = 100+i, loop = 50, offsets = {3}, dst = {
            {time = 0, x = v.note_x_list[i], y = v.notearea_y, w = v.lane_w_list[i], h = v.notearea_h, a = 100},
            {time = 50, a = 255},
        }})
        table.insert(skinDest, {id = "keybeam"..i, timer = 120+i, loop =  -1, offsets = {3}, dst = {
            {time = 0, x = v.note_x_list[i], y = v.notearea_y, w = v.lane_w_list[i], h = v.notearea_h, a = 255},
            {time = 200, x = v.note_x_list[i]+3*v.lane_w_list[i]/8, w = v.lane_w_list[i]/4, a = 0},
        }})
        -- overlay
        table.insert(skinDest, {id = "keybeam-overlay-"..i%2, timer = 100+i, loop = 50, offsets = {3}, dst = {
            {time = 0, x = v.note_x_list[i], y = v.notearea_y, w = v.lane_w_list[i], h = v.notearea_h, a = 100},
            {time = 50, a = 255},
        }})
        table.insert(skinDest, {id = "keybeam-overlay-"..i%2, timer = 120+i, loop =  -1, offsets = {3}, dst = {
            {time = 0, x = v.note_x_list[i], y = v.notearea_y, w = v.lane_w_list[i], h = v.notearea_h, a = 255},
            {time = 200, x = v.note_x_list[i]+3*v.lane_w_list[i]/8, w = v.lane_w_list[i]/4, a = 0},
        }})
    end
end

function keys.buttons(skin)
    for i = 1,5,1 do
        table.insert(skin.image, {id = "button-"..i,   src = "src-buttons", x = 26*(i-1)*v.x, y = 0,       w = 26*v.x, h = 15*v.x})
        table.insert(skin.image, {id = "button-d-"..i, src = "src-buttons", x = 26*(i-1)*v.x, y = 15*v.x, w = 26*v.x, h = 16*v.x})
    end

    local buttons_y = {65,69,65,69,65,69,65,69,65}
    local buttons_x = {205, 230, 256, 281, 307, 333, 358, 384, 409}
    local buttoncolour = {1,2,3,4,5,4,3,2,1}

    for i = 1,9,1 do
        table.insert(skin.customTimers, {id = 10100+i})
        -- timer = 120+i
        table.insert(skin.destination, {id = "button-"..buttoncolour[i], timer = 10100+i, loop = 1, dst = {
            {x = buttons_x[i]*v.x, y = buttons_y[i]*v.x, w = 26*v.x, h = 15*v.x}
        }})
        table.insert(skin.destination, {id = "button-d-"..buttoncolour[i], timer = 100+i, dst = {
            {x = buttons_x[i]*v.x, y = buttons_y[i]*v.x, w = 26*v.x, h = 16*v.x}
        }})
    end
end

return keys
