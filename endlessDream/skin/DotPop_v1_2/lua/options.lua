local options = {}
local v = require("lua/values")

-- generate option ids, 900-999 should be safe values
local optNumber = 899
-- local function newNumber()
--     optNumber = optNumber + 1
--     return optNumber
-- end
local function newNumber(localNumber)
    return optNumber + localNumber
end


-- hi if you're trying to work out what i'm doing here; don't - this is a really unintuative way of organising this info
options.list = {
    timing_display = {name = "Timing display type", def = 'text', item = {
        none = {name = "None", number = newNumber(1)},
        text = {name = "EARLY/LATE", number = newNumber(2)},
        time = {name = "+/- ms", number = newNumber(3)},
    }},
    score_style = {name = "Score display type", def = 'score', item = {
        score = {name = "Score", number = newNumber(4)},
        exscore = {name = "Exscore", number = newNumber(5)}
    }},
    judge_count = {name = "Judge count box", def = 'on', item = {
        on = {name = "On", number = newNumber(6)},
        off = {name = "Off", number = newNumber(7)}
    }},
    graph = {name = "Scoregraph display", def = 'right', item = {
        left = {name = "Left", number = newNumber(8)},
        right = {name = "Right", number = newNumber(9)},
        slim_r = {name = "Slim (Right Only)", number = newNumber(21)},
        off = {name = "Off", number = newNumber(10)}
    }},
    bga_window = {name = "BGA window display", def = 'left', item = {
        left = {name = "Left", number = newNumber(11)},
        right = {name = "Right", number = newNumber(12)},
        both = {name = "Both", number = newNumber(13)},
        off = {name = "Off", number = newNumber(14)}
    }},
    bga_bg = {name = "BGA in background", def = 'off', item = {
        on = {name = "On", number = newNumber(15)},
        off = {name = "Off", number = newNumber(16)}
    }},
    extended_info = {name = "Display extra song info", def = "on", item = {
        on = {name = "On", number = newNumber(17)},
        off = {name = "Off", number = newNumber(18)}
    }},
    note_expansion = {name = "Notes bounce to beat", def = 'on', item = {
        on = {name = "On", number = newNumber(19)},
        off = {name = "Off", number = newNumber(20)}
    }},
}

--current final option number: #21

-- oh yeah lua tables dont have an explicit order :(
local listOrder = {'timing_display', 'score_style', 'judge_count', 'graph', 'bga_window', 'bga_bg', 'extended_info', 'note_expansion'}

function options.propName(propv)
    return options.list[propv].name
end

function options.itemValue(propv, itemv)
    return options.list[propv].item[itemv].number
end

function options.checkConfig(propv, itemv)
    local propertyName = options.list[propv].name
    local itemValue = options.list[propv].item[itemv].number
    if skin_config.option[propertyName] == itemValue then
        return true
    else
        return false
    end
end

-- this is what actually builds the skin properties, the rest is for easy reference elsewhere
function options.makePropertyList(list)
    local propertyList = {}
    for i, optionVal in ipairs(listOrder) do
        local option = list[optionVal]
        local newProp = {}
        newProp.name = option.name
        newProp.item = {}
        for iKey, item in pairs(option.item) do
            local currentItem = {
                    name = item.name,
                    op = item.number
            }
            table.insert(newProp.item, currentItem)
        end
        table.sort(newProp.item, function(a,b) return a.op < b.op end)
        if option['def'] ~= nil then
            newProp.def = option.item[option.def].name
        end
        table.insert(propertyList, newProp)
    end
    return propertyList
end

return options
