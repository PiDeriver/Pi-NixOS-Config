local judge = {}
local v = require("lua/values")
local opt = require("lua/options")

function judge.addJudge(skin)

    local judge_h = 24*v.x
    local judge_w = 88*v.x

    table.insert(skin.image, {id = "judgef-pg",  src = "src-judge", x = 0, y = 0*judge_h, w = judge_w, h = judge_h*2, divy = 2, cycle = 100})
    table.insert(skin.image, {id = "judgef-pg2", src = "src-judge", x = 0, y = 0*judge_h, w = judge_w, h = judge_h*3, divy = 3, cycle = 100})
    table.insert(skin.image, {id = "judgef-gr",  src = "src-judge", x = 0, y = 3*judge_h, w = judge_w, h = judge_h})
    table.insert(skin.image, {id = "judgef-gd",  src = "src-judge", x = 0, y = 4*judge_h, w = judge_w, h = judge_h})
    table.insert(skin.image, {id = "judgef-bd",  src = "src-judge", x = 0, y = 5*judge_h, w = judge_w, h = judge_h})
    table.insert(skin.image, {id = "judgef-pr",  src = "src-judge", x = 0, y = 6*judge_h, w = judge_w, h = judge_h})
    table.insert(skin.image, {id = "judgef-ms",  src = "src-judge", x = 0, y = 7*judge_h, w = judge_w, h = judge_h})

    local n_judge_y = 192*v.x
    local n_judge_w = 16*v.x
    local n_judge_h = 20*v.x
    table.insert(skin.value, {id = "judgen-all", src = "src-judge", x = 0, y = n_judge_y, w = n_judge_w*10, h = n_judge_h, divx = 10, digit = 6, ref = 75})


    local judge_x_list = {244*v.x-judge_w/2, 320*v.x-judge_w/2, 396*v.x-judge_w/2}
    local judge_y = v.lanes_y + 60*v.x

    local judgeSuffixes = {"pg", "gr", "gd", "bd", "pr", "ms", "pg2"}
    local judgeTimer = {46, 47, 247}
    local judgeImages = {}
    local judgeNumbers = {}

    for i = 1,3,1 do
        local imgs = {}
        local nums = {}
        for j, suffix in  ipairs(judgeSuffixes) do
            table.insert(imgs, {id = "judgef-"..suffix,  loop = -1, timer = judgeTimer[i], offsets = {3,32}, dst = {
                {time = 0, x = judge_x_list[i], y = judge_y, w = judge_w, h = judge_h},
                {time = 500}
            }})
            if (true) then
                table.insert(nums, {id = "judgen-all",  loop = -1, timer = 445+i, offsets = {3,32}, dst = {
                    {time = 0, x = judge_w/2, y = -n_judge_h, w = n_judge_w, h = n_judge_h},
                    {time = 500}
                }})
            end
        end
        table.insert(judgeImages, imgs)
        table.insert(judgeNumbers, nums)
    end

    skin.judge = {
        {
            id = "judge1",
            index = 0,
            images = judgeImages[1],
            numbers = judgeNumbers[1],
            shift = false
        },
        {
            id = "judge2",
            index = 1,
            images = judgeImages[2],
            numbers = judgeNumbers[2],
            shift = false
        },
        {
            id = "judge3",
            index = 2,
            images = judgeImages[3],
            numbers = judgeNumbers[3],
            shift = false
        },
    }
    table.insert(skin.destination, {id = "judge1"})
    table.insert(skin.destination, {id = "judge2"})
    table.insert(skin.destination, {id = "judge3"})

    --add timing)

    local num_s_x = 0 * v.x
    local num_s_w = 8 * v.x
    local num_s_h = 10 * v.x
    local text_s_w = 40 * v.x

    local fastSlowOptions = {{1242,1243},{1262,1263},{1362,1363}}

    table.insert(skin.image, {id = "judge-fast", src = "src-numbers-timing", x = num_s_w*12, y = 0,         w = text_s_w, h = num_s_h})
    table.insert(skin.image, {id = "judge-slow", src = "src-numbers-timing", x = num_s_w*12, y = 1*num_s_h, w = text_s_w, h = num_s_h})
    for i = 1,3,1 do
        table.insert(skin.value, {id = "judge-timing"..i, src = "src-numbers-timing", x = num_s_x, y = 0, w = num_s_w*12, h = num_s_h*2, divx = 12, divy = 2, digit = 6, align = 2, ref = 524+i})
        table.insert(skin.destination, {id = "judge-timing"..i, op = {opt.itemValue('timing_display', 'time')}, loop = -1, timer = judgeTimer[i], offsets = {3,32,33}, dst = {
            {time = 0, x = judge_x_list[i]+judge_w/2-num_s_w*3, y = judge_y+judge_h, w = num_s_w, h = num_s_h},
            {time = 500}
        }})
        table.insert(skin.destination, {id = "judge-fast", op = {opt.itemValue('timing_display', 'text'), fastSlowOptions[i][1]}, loop = -1, timer = judgeTimer[i], offsets = {3,32,33}, dst = {
            {time = 0, x = judge_x_list[i]+judge_w/2-text_s_w/2, y = judge_y+judge_h, w = text_s_w, h = num_s_h},
            {time = 500}
        }})
        table.insert(skin.destination, {id = "judge-slow", op = {opt.itemValue('timing_display', 'text'), fastSlowOptions[i][2]}, loop = -1, timer = judgeTimer[i], offsets = {3,32,33}, dst = {
            {time = 0, x = judge_x_list[i]+judge_w/2-text_s_w/2, y = judge_y+judge_h, w = text_s_w, h = num_s_h},
            {time = 500}
        }})
    end

end

function judge.count(skin)
    local judgeSuffixes = {"pg", "gr", "gd", "bd", "pr", "ms", "pg2"}
    local num_s_x = 0 * v.x
    local num_s_w = 5 * v.x
    local num_s_h = 8 * v.x
    local judgecounts = {
        {
            {"n-count-pg", 0, 110},
            {"n-count-gr", 0, 111},
            {"n-count-gd", 0, 112},
            {"n-count-bd", 0, 113},
            {"n-count-pr", 0, 114},
            {"n-count-ms", 0, 420},
        },
        {
            -- {"n-count-pg-early", 1, 410},
            {"n-count-t-early", 1, 423},
            {"n-count-gr-early", 1, 412},
            {"n-count-gd-early", 1, 414},
            {"n-count-bd-early", 1, 416},
            {"n-count-pr-early", 1, 418},
            {"n-count-ms-early", 1, 421},
        },
        {
            -- {"n-count-pg-late", 2, 411},
            {"n-count-t-late", 2, 422},
            {"n-count-gr-late", 2, 413},
            {"n-count-gd-late", 2, 415},
            {"n-count-bd-late", 2, 417},
            {"n-count-pr-late", 2, 419},
            {"n-count-ms-late", 2, 422},
        },
    }

    local start_x = 478 * v.x
    local start_y = 77 * v.x
    local shift_x = 3 * v.x
    local gap_h = 1 * v.x + num_s_h
    local gap_w = 5 * v.x + num_s_w*4

    table.insert(skin.destination, {id = "judgecount-box", dst = {{x = 439*v.x, y = 18*v.x, w = 137*v.x, h = 72*v.x}}})

    for col = 1,3,1 do
        for row, count in ipairs(judgecounts[col]) do
            table.insert(skin.value, {id = count[1], src = "src-numbers-s", x = num_s_x, y = count[2]*num_s_h, w = num_s_w*11, h = num_s_h, divx = 11, digit = 4, ref = count[3]})
            table.insert(skin.destination, {id = count[1], dst = {
                {x = start_x + (col-1)*gap_w + (row-1)*shift_x, y = start_y - (row-1)*gap_h, w = num_s_w, h = num_s_h}
            }})
        end
    end
    local gap_ratedec = 12 * v.x
    local gap_brk = 50 * v.x
    table.insert(skin.value, {id = 'n-count-rate', src = "src-numbers-s", x = num_s_x, y = 0, w = num_s_w*11, h = num_s_h, divx = 11, digit = 2, ref = 102})
    table.insert(skin.value, {id = 'n-count-rate-dec', src = "src-numbers-s", x = num_s_x, y = 0, w = num_s_w*10, h = num_s_h, divx = 10, digit = 2, ref = 103})
    table.insert(skin.value, {id = 'n-count-cbreak', src = "src-numbers-s", x = num_s_x, y = 0, w = num_s_w*11, h = num_s_h, divx = 11, digit = 4, ref = 425})
    table.insert(skin.destination, {id = 'n-count-rate', dst = {{x = start_x + 6*shift_x, y = start_y - 6*gap_h, w = num_s_w, h = num_s_h}}})
    table.insert(skin.destination, {id = 'n-count-rate-dec', dst = {{x = start_x + 6*shift_x + gap_ratedec, y = start_y - 6*gap_h, w = num_s_w, h = num_s_h}}})
    table.insert(skin.destination, {id = 'n-count-cbreak', dst = {{x = start_x + 6*shift_x + gap_brk, y = start_y - 6*gap_h, w = num_s_w, h = num_s_h}}})
end

return judge
