local v = {}

v.min_int = -9223372036854775808 --there must be a nicer way than this lol

local nameSuffixes = {
    "INVALID-size1",
    "720p",
    "1080p",
    "1440p",
    "INVALID-size5",
    "2160p"
}

-- screen
v.x = screensize --global from .luaskin file
v.scr_w = 640 * v.x
v.scr_h = 360 * v.x
v.nameSuffix = nameSuffixes[v.x]

-- notes and play area
v.note_x_list = {204*v.x,232*v.x,255*v.x,283*v.x,306*v.x,334*v.x,357*v.x,385*v.x,408*v.x}
v.lane_w_list = {28*v.x,23*v.x,28*v.x,23*v.x,28*v.x,23*v.x,28*v.x,23*v.x,28*v.x}

v.lanes_y = 64*v.x
v.lanes_x = 204*v.x
v.lanes_h = 266*v.x
v.notearea_y = 86*v.x
v.notearea_h = v.lanes_h - v.notearea_y + v.lanes_y
v.lanes_w = 0
for i=1,9,1 do
    v.lanes_w = v.lanes_w + v.lane_w_list[i]
end

function v.print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(v.print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..v.print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end


return v
