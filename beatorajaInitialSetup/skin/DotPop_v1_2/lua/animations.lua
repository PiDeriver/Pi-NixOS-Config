local animations={}
local v = require("lua/values")

function animations.fc(skin)

    local text_w = 286*v.x
    local text_h = 62*v.x
    local banner_w = 640*v.x
    local banner_h =  62*v.x
    local flash_w = 352*v.x
    local flash_h = 170*v.x

    table.insert(skin.image, {id = "fc-text", src = "src-fc-sheet", x = 0, y = banner_h, w = text_w, h = text_h})
    table.insert(skin.image, {id = "fc-banner", src = "src-fc-sheet", x = 0, y = 0, w = banner_w, h = banner_h})
    table.insert(skin.image, {id = "fc-flash", src = "src-fc-sheet", x = text_w, y = banner_h, w = flash_w, h = flash_h})

    table.insert(skin.destination, {id = "fc-banner", timer = 48, loop = 500, dst = {
        {time = 0, x = 0, y = 209*v.x, w = banner_w, h = 0, a = 0},
        {time = 300, y = 178*v.x, h = banner_h, a = 255},
        {time = 400, y = 174*v.x, h = banner_h + 8*v.x, a = 255},
        {time = 500, y = 178*v.x, h = banner_h, a = 255}
    }})
    table.insert(skin.destination, {id = "fc-flash", timer = 48, loop = 100, dst = {
        {time = 0, x = 144*v.x, y = 209*v.x, w = 0, h = 0, a = 0},
        {time = 100, y = 124*v.x, w = flash_w, h = flash_h, a = 255},
        {time = 400, a = 215},
        {time = 700, a = 255}
    }})
    table.insert(skin.destination, {id = "fc-text", timer = 48, loop = 300, dst = {
        {time = 0, x = 177*v.x, y = 166*v.x, w = text_w, h = text_h, a = 0},
        {time = 50, y = 166*v.x, a = 0},
        {time = 300, y = 178*v.x, a = 255}
    }})

end

function animations.fades(skin)

    local fade_w = 1*v.x
    local fade_h = 260*v.x

    table.insert(skin.image, {id = "fade-top", src = "src-fade-sheet", x=0, y=0, w=fade_w, h=fade_h})
    table.insert(skin.image, {id = "fade-bottom", src = "src-fade-sheet", x=fade_w, y=0, w=fade_w, h=fade_h})

    -- fade in
    table.insert(skin.destination, {id = "fade-top", loop = -1, dst = {
        {time = 0, x = 0, y = v.scr_h - fade_h, w = v.scr_w, h = fade_h},
        {time = 1000, y = v.scr_h}
    }})
    table.insert(skin.destination, {id = "fade-bottom", loop = -1, dst = {
        {time = 0, x = 0, y = 0, w = v.scr_w, h = fade_h},
        {time = 1000, y = -fade_h}
    }})

    -- fade out
    local fadetimers = {2,3} --add the same fade to the fail animation
    for i=1, #fadetimers do
        table.insert(skin.destination, {id = "fade-top", timer = fadetimers[i], loop = 1000, dst = {
            {time = 0, x = 0, y = v.scr_h, w = v.scr_w, h = fade_h},
            {time = 1000, y = v.scr_h - fade_h}
        }})
        table.insert(skin.destination, {id = "fade-bottom", timer = fadetimers[i], loop = 1000, dst = {
            {time = 0, x = 0, y = -fade_h, w = v.scr_w, h = fade_h},
            {time = 1000, y = 0}
        }})
    end


end

function animations.fail(skin)
    local fail_src_x = 2*v.x
    local fail_w = 198*v.x
    local fail_h = 84*v.x
    local fail_x = v.scr_w/2 - fail_w/2
    local fail_y = v.scr_h/2 - fail_h/2

    table.insert(skin.image, {id = "fail-text", src = "src-fade-sheet", x = fail_src_x, y = 0, w = fail_w, h = fail_h})

    table.insert(skin.destination, {id = "fail-text", timer = 3, loop = 300, dst = {
        {time = 0, x = fail_x, y = fail_y, w = fail_w, h = fail_h, a = 0},
        {time = 300, a = 255}
    }})
end

return animations
