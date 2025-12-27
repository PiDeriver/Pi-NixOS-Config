local notes = {}
local v = require("lua/values")
local opt = require("lua/options")

function notes.create(skin)
    local noteXOffset = {0,26,47,73,94}
    local wTop = 21
    local wBot = 26
    local noteWidth = {wBot,wTop,wBot,wTop,wBot,wTop,wBot,wTop,wBot}

    -- spritesheet offsets
     local typeYOffset = {note = 0,
                          lns = 31, lne = 14, lnb = 28, lna = 30,
                          hcns = 31, hcne = 14, hcnb = 28, hcna = 30, hcnd = 28, hcnr = 29,
                          mine = 45}
     local typeHeight = {note = 14,
                          lns = 14, lne = 14, lnb = 1, lna = 1,
                          hcns = 14, hcne = 14, hcnb = 1, hcna = 1, hcnd = 1, hcnr = 1,
                          mine = 14}

    --distance from bottom of graphic to timing baseline
    local noteYoffset = 5*v.x
    -- discrepency between lane width and note graphic width
    local noteSizeFixL = (v.lane_w_list[1] - noteWidth[1]*v.x)/2
    local noteSizeFixS = (v.lane_w_list[2] - noteWidth[2]*v.x)/2

    for i = 1,9,1 do
        for type, yOffset in pairs(typeYOffset) do
            local noteXi = i <=  5 and i or 10-i -- i if < = 5 otherwise 10-i
            table.insert(skin.image, {
                id = (type.."-"..i),
                src = "src-notes",
                x = noteXOffset[noteXi]*v.x,
                y = yOffset*v.x,
                w = noteWidth[i]*v.x,
                h = typeHeight[type]*v.x
            })
        end
    end

    local expansionrate
    if opt.checkConfig('note_expansion', 'on') then
        expansionrate = {124, 114}
    else
        expansionrate = {100, 100}
    end

    skin.note = {
        id = "notes",
        note =        {"note-1","note-2","note-3","note-4","note-5","note-6","note-7","note-8","note-9"},
        lnend =       {"lne-1","lne-2","lne-3","lne-4","lne-5","lne-6","lne-7","lne-8","lne-9"},
        lnstart =     {"lns-1","lns-2","lns-3","lns-4","lns-5","lns-6","lns-7","lns-8","lns-9"},
        lnbody =      {"lnb-1","lnb-2","lnb-3","lnb-4","lnb-5","lnb-6","lnb-7","lnb-8","lnb-9"},
        lnactive =    {"lna-1","lna-2","lna-3","lna-4","lna-5","lna-6","lna-7","lna-8","lna-9"},
        hcnend =      {"hcne-1","hcne-2","hcne-3","hcne-4","hcne-5","hcne-6","hcne-7","hcne-8","hcne-9"},
        hcnstart =    {"hcns-1","hcns-2","hcns-3","hcns-4","hcns-5","hcns-6","hcns-7","hcns-8","hcns-9"},
        hcnbody =     {"hcnb-1","hcnb-2","hcnb-3","hcnb-4","hcnb-5","hcnb-6","hcnb-7","hcnb-8","hcnb-9"},
        hcnactive =   {"hcna-1","hcna-2","hcna-3","hcna-4","hcna-5","hcna-6","hcna-7","hcna-8","hcna-9"},
        hcndamage =   {"hcnd-1","hcnd-2","hcnd-3","hcnd-4","hcnd-5","hcnd-6","hcnd-7","hcnd-8","hcnd-9"},
        hcnreactive = {"hcnr-1","hcnr-2","hcnr-3","hcnr-4","hcnr-5","hcnr-6","hcnr-7","hcnr-8","hcnr-9"},
        mine  =       {"mine-1","mine-2","mine-3","mine-4","mine-5","mine-6","mine-7","mine-8","mine-9"},
        hidden = {},
        processed = {},
        dst = {
            {x = v.note_x_list[1]+noteSizeFixL, y = v.notearea_y-noteYoffset, w = noteWidth[1]*v.x, h = v.notearea_h},
            {x = v.note_x_list[2]+noteSizeFixS, y = v.notearea_y-noteYoffset, w = noteWidth[2]*v.x, h = v.notearea_h},
            {x = v.note_x_list[3]+noteSizeFixL, y = v.notearea_y-noteYoffset, w = noteWidth[3]*v.x, h = v.notearea_h},
            {x = v.note_x_list[4]+noteSizeFixS, y = v.notearea_y-noteYoffset, w = noteWidth[4]*v.x, h = v.notearea_h},
            {x = v.note_x_list[5]+noteSizeFixL, y = v.notearea_y-noteYoffset, w = noteWidth[5]*v.x, h = v.notearea_h},
            {x = v.note_x_list[6]+noteSizeFixS, y = v.notearea_y-noteYoffset, w = noteWidth[6]*v.x, h = v.notearea_h},
            {x = v.note_x_list[7]+noteSizeFixL, y = v.notearea_y-noteYoffset, w = noteWidth[7]*v.x, h = v.notearea_h},
            {x = v.note_x_list[8]+noteSizeFixS, y = v.notearea_y-noteYoffset, w = noteWidth[8]*v.x, h = v.notearea_h},
            {x = v.note_x_list[9]+noteSizeFixL, y = v.notearea_y-noteYoffset, w = noteWidth[9]*v.x, h = v.notearea_h}
        },
        expansionrate = expansionrate, --bop it
        dst2 = v.lanes_y - typeHeight.note*v.x, --scroll just out of sight under the frame on a miss
        group = {{id = "c-66grey", offset = 3, timer = 40, loop = 1000, dst = {{time = 0, x = 204*v.x, y = v.notearea_y, w = v.lanes_w, h = 1*v.x, a = 0},{time = 1000, a = 170}}}},
        time =  {{id = "c-p-red", offset = 3, dst = {{x = 204*v.x, y = v.notearea_y, w = v.lanes_w, h = 1*v.x, a = 170}}}},
        bpm =   {{id = "c-p-green", offset = 3, dst = {{x = 204*v.x, y = v.notearea_y, w = v.lanes_w, h = 1*v.x, a = 170}}}},
        stop =  {{id = "c-p-yellow", offset = 3, dst = {{x = 204*v.x, y = v.notearea_y, w = v.lanes_w, h = 1*v.x, a = 170}}}}
    }
end


return notes
