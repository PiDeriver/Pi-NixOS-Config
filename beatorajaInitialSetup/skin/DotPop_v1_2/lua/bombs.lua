local bombs = {}
local v = require("lua/values")

function bombs.create(skin)
    --add images for each bomb
    local bomb_h = 62 * v.x
    local bomb_w = 166 * v.x
    local bomb_y = (v.notearea_y - bomb_h/2)
    local bomb_cycle = 128*2
    for i = 1,9,1 do
        local bomb_x = (v.note_x_list[i] + v.lane_w_list[i]/2) - bomb_w/2
        -- regular bomb
        table.insert(skin.image, {id = "bomb-"..i, src = "src-bombsheet", x = 0, y = 0, w = bomb_w, h = bomb_h*8, divy = 8, timer = 50+i, cycle = bomb_cycle})
        table.insert(skin.destination, {id = "bomb-"..i, offset = 3, timer = 50+i, loop = -1, dst = {
            {time = 0, x = bomb_x, y = bomb_y, w = bomb_w, h = bomb_h},
            {time = bomb_cycle}
        }})
    end
end

return bombs
