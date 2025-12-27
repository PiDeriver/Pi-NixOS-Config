local gauge = {}
local v = require("lua/values")

function gauge.create(skin)
    --gauge bar
    local gauge_w = 6*v.x
    local gauge_h = 16*v.x
    local gauge_count = 40
    table.insert(skin.image, {id = "gauge-n1", src = "src-gauge", x = 0*gauge_w, y = 0*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-n2", src = "src-gauge", x = 1*gauge_w, y = 0*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-n3", src = "src-gauge", x = 2*gauge_w, y = 0*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-n4", src = "src-gauge", x = 3*gauge_w, y = 0*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-e1", src = "src-gauge", x = 0*gauge_w, y = 1*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-e2", src = "src-gauge", x = 1*gauge_w, y = 1*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-e3", src = "src-gauge", x = 2*gauge_w, y = 1*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-e4", src = "src-gauge", x = 3*gauge_w, y = 1*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-n5", src = "src-gauge", x = 0*gauge_w, y = 2*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-n6", src = "src-gauge", x = 1*gauge_w, y = 2*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-e5", src = "src-gauge", x = 2*gauge_w, y = 2*gauge_h, w = gauge_w, h = gauge_h})
    table.insert(skin.image, {id = "gauge-e6", src = "src-gauge", x = 3*gauge_w, y = 2*gauge_h, w = gauge_w, h = gauge_h})

    skin.gauge = {
        id = "gauge",
        nodes = {"gauge-n1","gauge-n2","gauge-n3","gauge-n4","gauge-e1","gauge-e2","gauge-e3","gauge-e4","gauge-n5","gauge-n6","gauge-e5","gauge-e6",},
        parts = gauge_count
    }

    table.insert(skin.destination, {id = "gauge", dst = {
        {x = 200*v.x, y = 28*v.x, w = gauge_w*gauge_count, h = gauge_h}
    }})

    --gauge numbers
    local n_gauge_start = 32*v.x
    local n_gauge_w = 9*v.x
    local n_gauge_h = 12*v.x
    local n_gauged_w = 6*v.x
    local n_gauged_h = 8*v.x
    table.insert(skin.value, {id = "n-gauge", src = "src-numbers-score", x = 0, y = n_gauge_start, w = n_gauge_w*11, h = n_gauge_h, divx = 11, digit = 3, ref = 107})
    table.insert(skin.value, {id = "n-gauge-dec", src = "src-numbers-score", x = 0, y = n_gauge_start+n_gauge_h, w = n_gauged_w*11, h = n_gauged_h, divx = 11, digit = 1, ref = 407})

    local n_gauge_x = 393*v.x
    local n_gauge_y = 14*v.x
    local n_gaugedot_w = 3*v.x
    local n_gaugep_w = 11*v.x

    table.insert(skin.image, {id = "n-gaugedot", src = "src-numbers-score", x = 0, y = n_gauge_start+n_gauge_h+n_gauged_h, w = n_gaugedot_w, h = n_gauge_h})
    table.insert(skin.image, {id = "n-gaugep", src = "src-numbers-score", x = n_gaugedot_w, y = n_gauge_start+n_gauge_h+n_gauged_h, w = n_gaugep_w, h = n_gauge_h})

    table.insert(skin.destination, {id = "n-gauge", dst = {{x = n_gauge_x, y = n_gauge_y, w = n_gauge_w, h = n_gauge_h}}})
    table.insert(skin.destination, {id = "n-gaugedot", dst = {{x = n_gauge_x+3*n_gauge_w, y = n_gauge_y, w = n_gaugedot_w, h = n_gauge_h}}})
    table.insert(skin.destination, {id = "n-gauge-dec", dst = {{x = n_gauge_x+3*n_gauge_w+n_gaugedot_w, y = n_gauge_y, w = n_gauged_w, h = n_gauged_h}}})
    table.insert(skin.destination, {id = "n-gaugep", dst = {{x = n_gauge_x+3*n_gauge_w+n_gaugedot_w+n_gauged_w, y = n_gauge_y, w = n_gaugep_w, h = n_gauge_h}}})

    --364
    table.insert(skin.value, {id = "n-bpm-current", src = "src-numbers-score", x = 0, y = n_gauge_start+n_gauge_h, w = n_gauged_w*11, h = n_gauged_h, divx = 11, digit = 4, ref = 160})
    table.insert(skin.destination, {id = "n-bpm-current", dst = {{x = 362*v.x, y = n_gauge_y, w = n_gauged_w, h = n_gauged_h}}})

    -- TODO: need to muck around with the numbers so leading zero doesn't look wrong
    -- table.insert(skin.value, {id = "n-hispeed", src = "src-numbers-score", x = 0, y = n_gauge_start+n_gauge_h, w = n_gauged_w*11, h = n_gauged_h, divx = 11, digit = 2, ref = 310})
    -- table.insert(skin.value, {id = "n-hispeed-dot", src = "src-numbers-score", x = 0, y = n_gauge_start+n_gauge_h, w = n_gauged_w*10, h = n_gauged_h, divx = 10, digit = 2, ref = 311})
    -- table.insert(skin.destination, {id = "n-hispeed", dst = {{x = 304*v.x, y = n_gauge_y, w = n_gauged_w, h = n_gauged_h}}})
    -- table.insert(skin.destination, {id = "n-gaugedot", dst = {{x = 316*v.x, y = n_gauge_y, w = n_gaugedot_w, h = n_gauge_h}}})
    -- table.insert(skin.destination, {id = "n-hispeed-dot", dst = {{x = 319*v.x, y = n_gauge_y, w = n_gauged_w, h = n_gauged_h}}})
end

return gauge
