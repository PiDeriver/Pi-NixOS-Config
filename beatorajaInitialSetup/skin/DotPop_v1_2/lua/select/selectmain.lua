local main_state = require("main_state")

local v = require("lua/values")

local songlist = require("lua/select/songlist")

-- local notes = require("lua/notes")
-- local bombs = require("lua/bombs")
-- local gauge = require("lua/gauge")
-- local judge = require("lua/judge")
-- local keys = require("lua/keys")
-- local songprogress = require("lua/songprogress")
-- local graph = require("lua/graph")
-- local animations = require("lua/animations")
-- local opt = require("lua/options")

local header = {
    type = 5,        -- skin type: select
    name = "DotPop-Select-"..v.nameSuffix,
    w = v.scr_w,
    h = v.scr_h,
    input = 500,
    fadeout = 500,
    scene = 3000,
    -- property = opt.makePropertyList(opt.list),
    filepath = {
        {name = "Background", path = "custom/background/*.png", def = "default.png"},
    },
    offset = {
    }
}

local function main()
    local skin = {}
    for k, val in pairs (header) do
        skin[k] = val
    end

    skin.source = {
        {id = "src-background", path = "custom/background/*.png"},
        {id = "src-bars", path = "sel_graphics/"..v.scr_h.."/sel-test.png"}
    }
    skin.font = {
        {id = 'main-font', path = "font/MPLUSRounded1c-Black.ttf"}
    }
    skin.image = {
        {id = "background", src = "src-background", x = 0, y = 0, w = -1, h = -1},
    }
    skin.imageset = {
    }
    skin.value = {
        -- todo: level numbers
    }
    skin.text = {
    }
    skin.slider = {
    }

    ----------------------------- Build Destination ----------------------------
    skin.destination = {}

    table.insert(skin.destination, {id = "background", dst = {{x = 0,y = 0,w = v.scr_w,h = v.scr_h}}})

    songlist.create(skin)

    return skin
end

return {
    header = header,
    main = main
}
