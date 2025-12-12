local main_state = require("main_state")

local v = require("lua/values")

local notes = require("lua/notes")
local bombs = require("lua/bombs")
local gauge = require("lua/gauge")
local judge = require("lua/judge")
local keys = require("lua/keys")
local songprogress = require("lua/songprogress")
local graph = require("lua/graph")
local animations = require("lua/animations")
local opt = require("lua/options")

local header = {
    type = 4,        -- skin type: 9keys
    name = "DotPop-9k-"..v.nameSuffix,
    w = v.scr_w,
    h = v.scr_h,
    playstart = 1000,
    scene = 3600000,
    input = 500,
    close = 1500,
    fadeout = 1000,
    property = opt.makePropertyList(opt.list),
    filepath = {
        {name = "Background", path = "custom/background/*.png", def = "default.png"},
        {name = "Lane Background", path = "custom/lanebackground/*.png", def = "black.png"},
        {name = "Lane Cover", path = "custom/lanecover/*.png", def = "default.png"},
        {name = "Judge", path = "graphics/"..v.scr_h.."/judge/*.png", def = "judge-default.png"},
        {name = "Noteskin", path = "graphics/"..v.scr_h.."/notes/*.png", def = "default.png"},
        {name = "Critical Line", path = "graphics/"..v.scr_h.."/critline/*.png", def = "newpink.png"},
        {name = "Keybeams", path = "graphics/"..v.scr_h.."/keybeam/*.png", def = "default.png"},
    },
    offset = {
        {name = 'Background BGA dimming', id = 60, a = true},
        {name = 'Windowed BGA dimming',  id = 61, a = true},
        -- {name = 'Lane alpha', id = 62, a = true} -- needs rework
    }
}


local function main()
    local skin = {}
    for k, val in pairs (header) do
        skin[k] = val
    end

    skin.source = {
        {id = "src-background", path = "custom/background/*.png"},
        {id = "src-lanebackground", path = "custom/lanebackground/*.png"},
        {id = "src-lanecover", path = "custom/lanecover/*.png"},
		{id = "src-notes", path = "graphics/"..v.scr_h.."/notes/*.png"},
        {id = "src-frame", path = "graphics/"..v.scr_h.."/frame.png"},
        {id = "src-frame-top", path =  "graphics/"..v.scr_h.."/frame-top.png"},
        {id = "src-lanecolours", path = "graphics/"..v.scr_h.."/lanecolours.png"},
        {id = "src-laneline", path = "graphics/"..v.scr_h.."/laneline.png"},
        {id = "src-critline", path = "graphics/"..v.scr_h.."/critline/*.png"},
        {id = "src-keybeam", path = "graphics/"..v.scr_h.."/keybeam/*.png"},
        {id = "src-keybeam-overlay", path = "graphics/"..v.scr_h.."/keybeam-overlay/*.png"},
        {id = "src-judge", path = "graphics/"..v.scr_h.."/judge/*.png"},
        {id = "src-video-frame", path = "graphics/"..v.scr_h.."/video-frame.png"},
        {id = "src-no-bga", path = "graphics/"..v.scr_h.."/nobga-image.png"},
        {id = "src-buttons", path = "graphics/"..v.scr_h.."/buttons-sheet.png"},
        {id = "src-lane-bottom-shadow", path = "graphics/"..v.scr_h.."/lane-bottom-shadow.png"},
        {id = "src-bombsheet", path = "graphics/"..v.scr_h.."/bombsheet-large.png"},
        {id = "src-numbers-score", path = "graphics/"..v.scr_h.."/numbers-score.png"},
        {id = "src-numbers-s", path = "graphics/"..v.scr_h.."/numbers-s.png"},
        {id = "src-numbers-timing", path = "graphics/"..v.scr_h.."/numbers-timing.png"},
        {id = "src-gauge", path = "graphics/"..v.scr_h.."/gauge.png"},
        {id = "src-songprogress", path = "graphics/"..v.scr_h.."/songprogress.png"},
        {id = "src-judgecount-box", path = "graphics/"..v.scr_h.."/judgecount-box.png"},
        {id = "src-graph", path = "graphics/"..v.scr_h.."/graph-bars.png"},
        {id = "src-graph-bg", path = "graphics/"..v.scr_h.."/graph-bg.png"},
        {id = "src-graph-slim", path = "graphics/"..v.scr_h.."/graph-slim.png"},
        {id = "src-fc-sheet", path = "graphics/"..v.scr_h.."/fc-sheet.png"},
        {id = "src-fade-sheet", path = "graphics/"..v.scr_h.."/fade-sheet.png"},
        {id = "src-s-colours", path = "graphics/fixed/simple-colours.png"},
        {id = "src-songinfo", path = "graphics/"..v.scr_h.."/songinfo.png"}
    }
    skin.font = {
        {id = 'main-font', path = "font/MPLUSRounded1c-Black.ttf"}
    }
    skin.image = {
        {id = "background", src = "src-background", x = 0, y = 0, w = -1, h = -1},
        {id = "lanebackground", src = "src-lanebackground", x = 0, y = 0, w = -1, h = -1},
        {id = "tempsquare", src = "src-tempsquare", x = 0, y = 0, w = 500, h = 500},
        {id = "frame", src = "src-frame", x = 0, y = 0, w = 248*v.x, h = 360*v.x},
        {id = "frame-top", src = "src-frame-top", x = 0, y = 0, w = -1, h = -1},
        {id = "lanecolours", src = "src-lanecolours", x = 0, y = 0, w = -1, h = -1},
        {id = "laneline", src = "src-laneline", x = 0, y = 0, w = 4*v.x, h = 1*v.x},
        {id = "critline",      src = "src-critline", x = 0, y = 4*v.x, w = 1*v.x, h = 4*v.x},
        {id = "critline-glow", src = "src-critline", x = 1*v.x, y = 0, w = 1*v.x, h = 10*v.x},
        {id = "video-frame", src = "src-video-frame", x = 0, y = 0, w = 192*v.x, h = 192*v.x},
        {id = "lane-bottom-shadow", src = "src-lane-bottom-shadow", x = 0, y = 0, w = -1, h = -1, act = 1000},
        {id = "judgecount-box", src = "src-judgecount-box", x = 0, y = 0, w = -1, h = -1},
        {id = "songinfo", src = "src-songinfo", x = 0, y = 0, w = -1, h = -1},
        {id = "c-black",    src = "src-s-colours", x = 0, y = 0, w = 1, h = 1},
        {id = "c-p-white",  src = "src-s-colours", x = 1, y = 0, w = 1, h = 1},
        {id = "c-p-yellow", src = "src-s-colours", x = 2, y = 0, w = 1, h = 1},
        {id = "c-p-green",  src = "src-s-colours", x = 3, y = 0, w = 1, h = 1},
        {id = "c-p-blue",   src = "src-s-colours", x = 4, y = 0, w = 1, h = 1},
        {id = "c-p-red",    src = "src-s-colours", x = 5, y = 0, w = 1, h = 1},
        {id = "c-white",    src = "src-s-colours", x = 6, y = 0, w = 1, h = 1},
        {id = "c-66grey",    src = "src-s-colours", x = 7, y = 0, w = 1, h = 1},
        {id = "keybeam-norm", src = "src-keybeam", x = 51*v.x, y = 0, w = 1*v.x, h = -1},
        {id = "keybeam-pg",   src = "src-keybeam", x = 52*v.x, y = 0, w = 1*v.x, h = -1},
        {id = "keybeam-overlay-0", src = "src-keybeam", x = 0*v.x, y = 0, w = 23*v.x, h = -1},
        {id = "keybeam-overlay-1", src = "src-keybeam", x = 23*v.x, y = 0, w = 28*v.x, h = -1},
        {id = "no-bga", src = "src-no-bga", x = 0, y = 0, w = -1, h = -1}
    }
    skin.imageset = {
        {id = "keybeam1", ref = 501, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam2", ref = 502, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam3", ref = 503, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam4", ref = 504, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam5", ref = 505, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam6", ref = 506, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam7", ref = 507, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam8", ref = 508, images = {"keybeam-norm","keybeam-pg"}},
        {id = "keybeam9", ref = 509, images = {"keybeam-norm","keybeam-pg"}},
    }
    local n_score_digit_w = 14*v.x
    local n_score_digit_h = 16*v.x
    local num_s_w = 5 * v.x
    local num_s_h = 8 * v.x
    skin.value = {
        {id = "n-score", src = "src-numbers-score", x = 0, y = 0*n_score_digit_h, w = n_score_digit_w*11, h = n_score_digit_h, divx = 11, digit = 6, align = 2, ref = 100},
        {id = "n-exscore", src = "src-numbers-score", x = 0, y = 0*n_score_digit_h, w = n_score_digit_w*11, h = n_score_digit_h, divx = 11, digit = 6, align = 2, ref = 101},
        {id = "n-combo", src = "src-numbers-score", x = 0, y = 1*n_score_digit_h, w = n_score_digit_w*11, h = n_score_digit_h, divx = 11, digit = 4, align = 2, ref = 105},
        {id = "n-duration-green", src = "src-numbers-s", x = 0, y = 3*num_s_h, w = 10*num_s_w, h = num_s_h, divx = 10, digit = 4, align = 2, ref = 313},
        {id = "n-lift",           src = "src-numbers-s", x = 0, y = 0*num_s_h, w = 10*num_s_w, h = num_s_h, divx = 10, digit = 4, align = 2, ref = 314},
        {id = "n-lanecover",      src = "src-numbers-s", x = 0, y = 0*num_s_h, w = 10*num_s_w, h = num_s_h, divx = 10, digit = 4, align = 2, ref = 14},
    }
    skin.text = {
        {id = "song-title", font = 'main-font', size = 11*v.x, align = 1, ref = 12, overflow = 1}
    }
    skin.graph = {}
    skin.slider = {
        {id = "lanecover", src = "src-lanecover", x = 0, y = 0, w = -1, h = -1, angle = 2, range = v.notearea_h, type = 4}
    }
    notes.create(skin)
    skin.bga = {id = "bga"}

    function buttonPressTimer()
        -- create custom timers that are just the inverse of the keypress timers
        -- this means the unpressed buttons are only visible when they key *isnt* pressed
        -- there must be a better way of doing this lol
        for i = 1,9,1 do
            if main_state.timer(100+i) > 0 then
                main_state.set_timer(10100+i, v.min_int)
            else
                main_state.set_timer(10100+i, 1000)
            end
        end
    end
    skin.customTimers = {
        {id = 10000, timer = "buttonPressTimer"}
    }

    -- print the left song info box
    local function extendedSongInfo()
        local infoRefs = {16,13,1001,1002}
        local boxWidth = 176 * v.x
        local start_tx = 178 * v.x
        local start_bx = 62 * v.x
        local start_ty = 347 * v.x
        local inc_x = 4 * v.x
        local inc_y = 12 * v.x

        local inc = 0
        for i, ref in ipairs(infoRefs) do
            if main_state.text(ref) ~= '' then
                table.insert(skin.destination, {id = "songinfo", dst = {{x = start_bx + inc_x*inc, y=start_ty - inc_y*inc + 1, w=140*v.x, h=11*v.x}}})
                table.insert(skin.text, {id = "infotext-"..i, font = 'main-font', size = 8*v.x, align = 2, ref = ref, overflow = 1})
                table.insert(skin.destination, {id = "infotext-"..i, dst = {{x = start_tx + inc_x*inc, y = start_ty - inc_y*inc + 1*v.x, w = boxWidth, h = 8*v.x}}})
                inc = inc+1
            end
        end
    end

    ----------------------------- Build Destination ----------------------------
    skin.destination = {}

    table.insert(skin.destination, {id = "background", dst = {{x = 0,y = 0,w = v.scr_w,h = v.scr_h}}})

    -- Background BGA
    table.insert(skin.destination, {id = "bga", op = {opt.itemValue('bga_bg','on'), 171}, stretch = 3, dst = {
        {time = 0, x = 0, y = 0, w = v.scr_w, h = v.scr_h, a = 255},
    }})
    -- table.insert(skin.destination, {id = "bga", op = {opt.itemValue('bga_bg','on')}, stretch = 1, dst = {
    --     {x = 0, y = 0, w = v.scr_w, h = v.scr_h, a = 255}
    -- }}) --unstretched video doesnt make for now since its always covered by the lane
    table.insert(skin.destination, {id = "c-black", offset = 60, op = {opt.itemValue('bga_bg','on'), 171}, dst = {
        {x = 0, y = 0, w = v.scr_w, h = v.scr_h, a = 0}
    }})

    if opt.checkConfig('extended_info','on') then
        extendedSongInfo()
    end

    table.insert(skin.destination, {id = "lanebackground", stretch = 3, dst = {{x = v.lanes_x, y = v.lanes_y, w = v.lanes_w, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "lanecolours", dst = {{x = 204*v.x, y = 64*v.x, w = 232*v.x, h = 266*v.x, a = 60}}})

    keys.insertKeybeams(skin.destination)

    --all central lane lines, edges later
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[2]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[3]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[4]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[5]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[6]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[7]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[8]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[9]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})

    --TODO: its just going under the actual critline atm
    --loading bar line
    table.insert(skin.graph, {id = "load-progress",  src = "src-critline", x = 0, y = 4*v.x, w = 1*v.x, h = 4*v.x, angle = 0, type = 102})
    table.insert(skin.destination, {id = "load-progress", offsets = {3}, dst = {
        {x = v.lanes_x, y = v.notearea_y, w = v.lanes_w, h = 4*v.x},
    }})

    table.insert(skin.destination, {id = "critline", timer = 40, loop = 1000, offsets = {3}, dst = {
        {time = 0, x = v.lanes_x, y = v.notearea_y, w = v.lanes_w, h = 4*v.x, a = 0},
        {time = 1000, a = 255}
    }})
    table.insert(skin.destination, {id = "critline-glow", timer = 140, offsets = {3}, dst = {
        {time = 0, x = v.lanes_x, y = v.notearea_y-2*v.x, w = v.lanes_w, h = 10*v.x, a = 255},
        {time = 800, a = 128},
        {time  = 1000, a = 255}
    }})

    table.insert(skin.destination, {id = "notes"})

    table.insert(skin.destination, {id = "lanecover", stretch = 3, dst = {
        {x = v.lanes_x, y = v.lanes_y+v.lanes_h, w = v.lanes_w, h = v.notearea_h}}
    })
    table.insert(skin.destination, {id = "n-duration-green", offset = 4, op = {270}, dst = {
        { x = v.lanes_x + v.lanes_w/2 - num_s_w*2, y = v.lanes_y+v.lanes_h-num_s_h, w = num_s_w, h = num_s_h}
    }})
    table.insert(skin.destination, {id = "n-lanecover", offset = 4, op = {270}, dst = {
        { x = v.lanes_x + v.lanes_w/2 - num_s_w*2, y = v.lanes_y+v.lanes_h, w = num_s_w, h = num_s_h}
    }})

    -- 2 extra lane lines, used as shadows for frame
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[1]-2*v.x, y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})
    table.insert(skin.destination, {id = "laneline", dst = {{x = v.note_x_list[9]-2*v.x+v.lane_w_list[9], y = v.lanes_y, w = 4*v.x, h = v.lanes_h}}})

    table.insert(skin.destination, {id = "lane-bottom-shadow", dst = {{x = v.lanes_x, y = v.lanes_y, w = v.lanes_w, h = 18*v.x}}})

    keys.buttons(skin)


    -- video on left
    if opt.checkConfig('bga_window','left') or opt.checkConfig('bga_window','both') then
        table.insert(skin.destination, {id = "video-frame", dst = {{x = 2*v.x, y = 94*v.x, w = 192*v.x, h = 192*v.x}}})
        table.insert(skin.destination, {id = "bga", op = {171}, stretch = 1, dst = {
            {time = 0, x = 8*v.x, y = 100*v.x, w = 180*v.x, h = 180*v.x, a = 255},
        }})
        table.insert(skin.destination, {id = "no-bga", timer = 41, loop = 200, op = {170}, stretch = 1, dst = {
            {time = 0, x = 8*v.x, y = 100*v.x, w = 180*v.x, h = 180*v.x, a = 0},
            {time = 200, a = 255}
        }})
        table.insert(skin.destination, {id = "c-black", timer = 41, op = {171}, offset = 61, dst = {
            {x = 8*v.x, y = 100*v.x, w = 180*v.x, h = 180*v.x, a = 0}
        }}) -- dimming
    end
    -- video on right
    if opt.checkConfig('bga_window','right') or opt.checkConfig('bga_window','both') then
        table.insert(skin.destination, {id = "video-frame", dst = {
            {x = 446*v.x, y = 94*v.x, w = 192*v.x, h = 192*v.x}
        }})
        table.insert(skin.destination, {id = "bga", timer = 41, loop = 200, op = {171}, stretch = 1, dst = {
            {time = 0, x = 452*v.x, y = 100*v.x, w = 180*v.x, h = 180*v.x, a = 0},
            {time = 200, a = 255}
        }})
        table.insert(skin.destination, {id = "no-bga", timer = 41, loop = 200, op = {170}, stretch = 1, dst = {
            {time = 0, x = 452*v.x, y = 100*v.x, w = 180*v.x, h = 180*v.x, a = 0},
            {time = 200, a = 255}
        }})
        table.insert(skin.destination, {id = "c-black", timer = 41, op = {171}, offset = 61, dst = {
            {x = 452*v.x, y = 100*v.x, w = 180*v.x, h = 180*v.x, a = 0}
        }}) -- dimming
    end

    --graph
    graph.create(skin)

    -- judge count box
    if opt.checkConfig('judge_count','on') then
        judge.count(skin)
    end

    -- static frames
    table.insert(skin.destination, {id = "frame", offset = 62, dst = {{x = 196*v.x, y = 0, w = 248*v.x, h = 360*v.x}}})
    table.insert(skin.destination, {id = "frame-top", dst = {{x = 0,y = 0,w = v.scr_w,h = v.scr_h}}})
    songprogress.create(skin)
    table.insert(skin.destination, {id = "song-title", dst = {{x = v.scr_w/2, y = v.scr_h-19*v.x, w = (242-6)*v.x, h = 11*v.x}}})
    gauge.create(skin)

    if opt.checkConfig('score_style','score') then
        table.insert(skin.destination, {id = "n-score", dst = {{x = 81*v.x, y = 58*v.x, w = n_score_digit_w, h = n_score_digit_h}}})
    elseif opt.checkConfig('score_style','exscore') then
        table.insert(skin.destination, {id = "n-exscore", dst = {{x = 81*v.x, y = 58*v.x, w = n_score_digit_w, h = n_score_digit_h}}})
    end
    table.insert(skin.destination, {id = "n-combo", dst = {{x = 99*v.x, y = 28*v.x, w = n_score_digit_w, h = n_score_digit_h}}})

    bombs.create(skin)

    -- judges
    judge.addJudge(skin)

    animations.fc(skin)
    animations.fades(skin)
    animations.fail(skin)

    return skin
end

return {
    header = header,
    main = main
}
