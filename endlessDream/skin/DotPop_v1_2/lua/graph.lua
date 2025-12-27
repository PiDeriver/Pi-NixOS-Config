local graph={}
local v = require("lua/values")
local opt = require("lua/options")


local graph_src_w = 40 * v.x
local graph_src_h = 180 * v.x

local graph_w = 40 * v.x
local graph_h = 180 * v.x
local graph_x
local graph_y = 100 * v.x
local graph_gap = 0

local graph_bg_src = 'src-graph-bg'

local graph_bg_x
local graph_bg_y = graph_y-6*v.x
local graph_bg_w = 154*v.x
local graph_bg_h = 192*v.x

function graph.create(skin)
   
   
    --regular old graph style
    if opt.checkConfig('graph', 'right') then
        graph_x = 493 * v.x
        graph_bg_x = graph_x-28*v.x
    elseif opt.checkConfig('graph', 'left') then
        graph_x = 49 * v.x
        graph_bg_x = graph_x-28*v.x
    elseif opt.checkConfig('graph', 'slim_r') then 
        --overwrite graph sizes,
        graph_w = 20 * v.x
        graph_h = 225 * v.x
        graph_x = 456 * v.x
        graph_y = 96 * v.x
        graph_gap = 3 * v.x
        graph_bg_src = 'src-graph-slim'
        graph_bg_x = graph_x-20*v.x
        graph_bg_y = graph_y-3*v.x
        graph_bg_w = 92*v.x
        graph_bg_h = 231*v.x
    else
        --graph is set to disabled (or the option is messed up lol), return
        return
    end

    table.insert(skin.graph, {id = "graph-now", src = "src-graph", x = 0, y = 0, w = graph_src_w, h = graph_src_h, type = 110})
    table.insert(skin.graph, {id = "graph-best", src = "src-graph", x = graph_src_w*1, y = 0, w = graph_src_w, h = graph_src_h, type = 112})
    table.insert(skin.graph, {id = "graph-target",  src = "src-graph", x = graph_src_w*2, y = 0, w = graph_src_w, h = graph_src_h, type = 114})
    table.insert(skin.graph, {id = "graph-now-ghost", src = "src-graph", x = graph_src_w*3, y = 0, w = graph_src_w, h = graph_src_h, type = 111})
    table.insert(skin.graph, {id = "graph-best-ghost", src = "src-graph", x = graph_src_w*3, y = 0, w = graph_src_w, h = graph_src_h, type = 113})
    table.insert(skin.graph, {id = "graph-target-ghost", src = "src-graph", x = graph_src_w*3, y = 0, w = graph_src_w, h = graph_src_h, type = 115})


    table.insert(skin.image, {id = "graph-bg", src = graph_bg_src, x = 0, y = 0, w = -1, h = -1})

    table.insert(skin.destination, {id = "graph-bg", dst = {
        {x = graph_bg_x, y = graph_bg_y, w = graph_bg_w, h = graph_bg_h}
    }})

    table.insert(skin.destination, {id = "graph-now-ghost", dst = {
        {x = graph_x,           y = graph_y, w = graph_w, h = graph_h}
    }})
    table.insert(skin.destination, {id = "graph-now", dst = {
        {x = graph_x,           y = graph_y, w = graph_w, h = graph_h}
    }})
    table.insert(skin.destination, {id = "graph-best-ghost", dst = {
        {x = graph_x+graph_w*1+graph_gap*1, y = graph_y, w = graph_w, h = graph_h}
    }})
    table.insert(skin.destination, {id = "graph-best", dst = {
        {x = graph_x+graph_w*1+graph_gap*1, y = graph_y, w = graph_w, h = graph_h}
    }})
    table.insert(skin.destination, {id = "graph-target-ghost", dst = {
        {x = graph_x+graph_w*2+graph_gap*2, y = graph_y, w = graph_w, h = graph_h}
    }})
    table.insert(skin.destination, {id = "graph-target", dst = {
        {x = graph_x+graph_w*2+graph_gap*2, y = graph_y, w = graph_w, h = graph_h}
    }})
    
end

return graph
