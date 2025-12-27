--[[
	キー入力の回数を表示、ファイル入出力する
	@author : KEH
]]
--local DEBUG = true
--local main_state = {} -- 警告無視用
--local MAIN = {}

local holdThreshold = 250000 -- LN判定する押し続け時間(us)
local ld_max = 10 -- レーン密度最大値
local cntmax = 1000 -- 累計打鍵数最大値
local t_sample = 640 -- トレンドグラフのサンプル数
local graphdelay = 512
local bound = 60
local t_freq = 16666 -- サンプル収集周期(us)
local t_max = 50 -- トレンドグラフの最大値
local frq_fineness = 5 -- 連打分布グラフの細かさ(1/n打/s単位で1データ)
local frq_min = 1 -- 連打分布グラフの最小連打数
local frq_max = 10 -- 連打分布グラフの最大連打数

-- 皿1-7
local keycolor = {
    r = {255,255,128,255,128,255,128,255},
    g = {128,255,128,255,128,255,128,255},
    b = {128,255,255,255,255,255,255,255}
}

-- local bx, by = 598, 281 -- bgaエリア基準点

local lgwidth = 15

-- 一時的に移植 打鍵ログ描画情報
local tbasey = 850
local tpos = {y = {tbasey, tbasey - 22 * 1, tbasey - 22 * 2, tbasey - 22 * 3, tbasey - 22 * 4, tbasey - 22 * 5, tbasey - 22 * 6, tbasey - 22 * 7,}}
local trgb = {
    r = {255,255,128,255,128,255,128,255},
    g = {128,255,128,255,128,255,128,255},
    b = {128,255,255,255,255,255,255,255}
}
-- 一時的に移植ここまで
-- 新規作成＆初期化
local function init_file(path, keys)
    local f = io.open(path, "w")
-- 5鍵後に7鍵盤をプレイするとバグるため初期化処理は強制的に7鍵状態で記録するように変更しました
    for i = 1, 8, 1 do
        f:write(0 .."\n")
    end
    f:close()
    if DEBUG then print("bgaareainfo:" ..path .."作成 & 初期化完了") end
end
-- 読み込み
local function lines_to_list(path)
    local t = {}
    local fh = io.open(path)
    for line in fh:lines() do
        table.insert(t, line)
    end
    fh:close()
    if DEBUG then print("bgaareainfo:" ..path .."読み込み完了") end
    return t
end
-- 書き込み
local function list_to_file(list, path)
    local fh = io.open(path, "w")
    for i = 1, #list do
        fh:write(list[i].."\n")
    end
    if DEBUG then print("bgaareainfo:" ..path .."書き込み") end
    return true
end

local function createTimertable(keys)
    local timertable
    if keys == 6 then
		if main_state.option(MAIN.OP.AUTOPLAYOFF) then
			timertable = {
				MAIN.TIMER.KEYON_1P_SCRATCH,
				MAIN.TIMER.KEYON_1P_KEY1,
				MAIN.TIMER.KEYON_1P_KEY2,
				MAIN.TIMER.KEYON_1P_KEY3,
				MAIN.TIMER.KEYON_1P_KEY4,
				MAIN.TIMER.KEYON_1P_KEY5
			}
		end
		if main_state.option(MAIN.OP.AUTOPLAYON) then
			timertable = {
				MAIN.TIMER.BOMB_1P_SCRATCH,
				MAIN.TIMER.BOMB_1P_KEY1,
				MAIN.TIMER.BOMB_1P_KEY2,
				MAIN.TIMER.BOMB_1P_KEY3,
				MAIN.TIMER.BOMB_1P_KEY4,
				MAIN.TIMER.BOMB_1P_KEY5
			}
		end
    elseif keys == 8 then
		if main_state.option(MAIN.OP.AUTOPLAYOFF) then
			timertable = {
				MAIN.TIMER.KEYON_1P_SCRATCH,
				MAIN.TIMER.KEYON_1P_KEY1,
				MAIN.TIMER.KEYON_1P_KEY2,
				MAIN.TIMER.KEYON_1P_KEY3,
				MAIN.TIMER.KEYON_1P_KEY4,
				MAIN.TIMER.KEYON_1P_KEY5,
				MAIN.TIMER.KEYON_1P_KEY6,
				MAIN.TIMER.KEYON_1P_KEY7
			}
		end
		if main_state.option(MAIN.OP.AUTOPLAYON) then
			timertable = {
				MAIN.TIMER.BOMB_1P_SCRATCH,
				MAIN.TIMER.BOMB_1P_KEY1,
				MAIN.TIMER.BOMB_1P_KEY2,
				MAIN.TIMER.BOMB_1P_KEY3,
				MAIN.TIMER.BOMB_1P_KEY4,
				MAIN.TIMER.BOMB_1P_KEY5,
				MAIN.TIMER.BOMB_1P_KEY6,
				MAIN.TIMER.BOMB_1P_KEY7
			}
		end
    end
    return timertable
end

local function load(keys)
    local bx, by = BASE.infoPositionX + 28, 281 -- bgaエリア基準点

    -- 制御変数定義
    local m = require("Play.lua.sp.detailinfo.inputinformation").load(keys, graphdelay)
    local trendfactory = require("Play.lua.sp.detailinfo.trend")
    local util = require("Play.lua.sp.detailinfo.util")
    local nentyaku = require("Play.lua.sp.detailinfo.nentyakuinfo")
    local rendafrq = require("Play.lua.sp.detailinfo.rendafrequency")
    local timers = createTimertable(keys)
    local counted = {}
    local keyontimes = {}
    local decaydiffs = {}
    local decayprevs = {}
    local lanedensmax = {}
    local once = 1
    local todaykey = {}
    local totalkey = {}
    local todayln = {}
    local totalln = {}
    local pps = 0
    local ppstemp = 0
    local prev = 0
    local title, ntitle, ndata, count
    local youbi = os.date('*t').wday
    local e_const = 1 / (math.exp(1) - 1)
    local filename = os.date("%Y-%m-%d", os.time() - 3600 * 6) .. ".txt"
    for _ = 1, keys do
        table.insert(counted, false)
        table.insert(keyontimes, -1)
        table.insert(decaydiffs, 0)
        table.insert(decayprevs, 1)
        table.insert(lanedensmax, 0)
        table.insert(todaykey, 0)
        table.insert(totalkey, 0)
        table.insert(todayln, 0)
        table.insert(totalln, 0)
    end

    -- トレンド作成 キー毎と合計
    local trend = trendfactory.create(bound)
    local trend2 = trendfactory.create(t_sample - bound)
    local t_prev = 0

    -- 粘着
    ntitle, ndata, count = nentyaku.getnentyakudata()
    title = string.sub(main_state.text(12),1,32)

    -- 連打分布 1～frq_maxまでfrq_fineness刻みで作成
    rendafrq.init(frq_fineness, frq_min, frq_max)

    -- 画像定義 開始
    local parts = {}

    -- 使いまわしたい定義
    local imgdef = {
        value = {
            toa20r = {src = 31, x = 0, y = 0, w = 209, h = 25, divx = 11, divy = 1},
            toa20i = {src = 31, x = 0, y = 25, w = 209, h = 25, divx = 11, divy = 1},
            toa20n = {src = 31, x = 0, y = 50, w = 209, h = 25, divx = 11, divy = 1},
            toa16 = {src = 31, x = 0, y = 75, w = 167, h = 20, divx = 11, divy = 1},
            toa16n = {src = 31, x = 169, y = 75, w = 167, h = 20, divx = 11, divy = 1},
            toayoubi = {src = 31, x = 0, y = 95, w = 297, h = 27, divx = 11, divy = 1},
            kasako27 = {src = 1, x = 1400, y = 101, w = 297, h = 20, divx = 11, divy = 1},
        },
        image = {
            date_format = {src = 31, x = 401, y = 0, w = 388, h = 29},
            text_lanedensity = {src = 31, x = 403, y = 28, w = 136, h = 30},
            text_totalcount = {src = 31, x = 549, y = 28, w = 136, h = 30},
            text_kukan = {src = 31, x = 403, y = 59, w = 110, h = 30},
            text_saidai = {src = 31, x = 523, y = 59, w = 110, h = 30},
            text_shunkan = {src = 31, x = 643, y = 59, w = 110, h = 30},
            text_hosei = {src = 31, x = 763, y = 59, w = 110, h = 30},
            text_dot = {src = 31, x = 715, y = 29, w = 8, h = 30},
            n_count = {src = 31, x = 404, y = 88, w = 37, h = 20},
            n_note = {src = 31, x = 445, y = 88, w = 50, h = 20},
            n_rate = {src = 31, x = 501, y = 88, w = 50, h = 20},
            n_miss = {src = 31, x = 557, y = 88, w = 50, h = 20},
            n_fast = {src = 31, x = 612, y = 88, w = 50, h = 20},
            n_slow = {src = 31, x = 666, y = 88, w = 50, h = 20},
            n_info = {src = 31, x = 717, y = 88, w = 75, h = 20},
            n_emergency = {src = 31, x = 401, y = 151, w = 280, h = 38},
            n_alart = {src = 31, x = 401, y = 107, w = 280, h = 38},
            n_exalart = {src = 31, x = 401, y = 193, w = 280, h = 38},
            n_kinkyu = {src = 31, x = 401, y = 231, w = 280, h = 38},
        },
        const = {
            white = {src = 31, x = 399, y = 1, w = 1, h = 1},
            clear = {src = 31, x = 404, y = 1, w = 1, h = 1}
        }
    }

    -- 繰り返しのないパーツ
    parts.image = {
        {id = "date_format", imgdef = imgdef.image.date_format},
        {id = "text_lanedensity", imgdef = imgdef.image.text_lanedensity},
        {id = "text_totalcount", imgdef = imgdef.image.text_totalcount},
        {id = "text_kukan", imgdef = imgdef.image.text_kukan},
        {id = "text_saidai", imgdef = imgdef.image.text_saidai},
        {id = "text_shunkan", imgdef = imgdef.image.text_shunkan},
        {id = "text_hosei", imgdef = imgdef.image.text_hosei},
        {id = "text_dot", imgdef = imgdef.image.text_dot},
    }
    parts.value = {
        {id = "date_year", imgdef = imgdef.value.toa20r, digit = 4, ref = MAIN.NUM.TIME_YEAR},
        {id = "date_month", imgdef = imgdef.value.toa20r, digit = 2, ref = MAIN.NUM.TIME_MONTH},
        {id = "date_day", imgdef = imgdef.value.toa20r, digit = 2, ref = MAIN.NUM.TIME_DAY},
        {id = "date_youbi", imgdef = imgdef.value.toayoubi, digit = 1, value = function() return youbi end},
        {id = "date_hour", imgdef = imgdef.value.toa20r, digit = 2, ref = MAIN.NUM.TIME_HOUR},
        {id = "date_minute", imgdef = imgdef.value.toa20r, digit = 2, ref = MAIN.NUM.TIME_MINUTE},
        {id = "date_second", imgdef = imgdef.value.toa20r, digit = 2, ref = MAIN.NUM.TIME_SECOND},
    }

    parts.judgegraph = { {id = "bgajdg", type = 1, backTexOff = MAIN.JUDGEGRAPH.BACKTEX.ON} }
    parts.bpmgraph = { {id = "bgabpm"} }
    parts.graph = {}
    parts.slider = {}

    -- 粘着中なら粘着情報
    if title == ntitle then
        table.insert(parts.image, {id = "n_count", imgdef = imgdef.image.n_count})
        table.insert(parts.image, {id = "n_note", imgdef = imgdef.image.n_note})
        table.insert(parts.image, {id = "n_rate", imgdef = imgdef.image.n_rate})
        table.insert(parts.image, {id = "n_miss", imgdef = imgdef.image.n_miss})
        table.insert(parts.image, {id = "n_fast", imgdef = imgdef.image.n_fast})
        table.insert(parts.image, {id = "n_slow", imgdef = imgdef.image.n_slow})
        table.insert(parts.image, {id = "n_info", imgdef = imgdef.image.n_info})
        if count >= 30 then
            table.insert(parts.image, {id = "n_alart", imgdef = imgdef.image.n_kinkyu})
        elseif count >= 20 then
            table.insert(parts.image, {id = "n_alart", imgdef = imgdef.image.n_exalart})
        elseif count >= 10 then
            table.insert(parts.image, {id = "n_alart", imgdef = imgdef.image.n_emergency})
        elseif count >= 5 then
            table.insert(parts.image, {id = "n_alart", imgdef = imgdef.image.n_alart})
        end
        for i = 1, #ndata do
            table.insert(parts.value, { id = "n_count_"..i, imgdef = imgdef.value.toa16n, digit = 2, value = function() return ndata[i][1] end})
            table.insert(parts.value, { id = "n_note_"..i, imgdef = imgdef.value.toa16n, digit = 4, value = function() return ndata[i][2] end})
            table.insert(parts.value, { id = "n_rate_"..i, imgdef = imgdef.value.toa16n, digit = 4, value = function() return ndata[i][3] end})
            table.insert(parts.value, { id = "n_miss_"..i, imgdef = imgdef.value.toa16n, digit = 4, value = function() return ndata[i][4] end})
            table.insert(parts.value, { id = "n_fast_"..i, imgdef = imgdef.value.toa16n, digit = 4, value = function() return ndata[i][5] end})
            table.insert(parts.value, { id = "n_slow_"..i, imgdef = imgdef.value.toa16n, digit = 4, value = function() return ndata[i][6] end})
        end
    end

    -- 目盛線の数字
    for i = 1, ld_max do
        table.insert(parts.value, {
            id = "num"..i, imgdef = imgdef.value.toa16n, digit = 2, align = MAIN.N_ALIGN.LEFT, value = function() return i end
        })
    end

    -- 鍵盤数依存の繰り返しパーツ
    for i = 1, keys do
        table.insert(parts.graph, {
            id = "lane_density"..i, imgdef = imgdef.const.white, angle = 1,
            value = function()
                return m.decayer[i].get() / ld_max
            end
        })
        table.insert(parts.graph, {
            id = "lane_loosedensity"..i, imgdef = imgdef.const.white, angle = 1,
            value = function()
                return m.looseDecayer[i].get() / ld_max
            end
        })
        table.insert(parts.graph, {
            id = "total_count"..i, imgdef = imgdef.const.white, angle = 1,
            value = function()
                return m.counter[i].get() / cntmax
            end
        })
        table.insert(parts.slider, {
            id = "lane_densmax"..i, imgdef = imgdef.const.white, angle = 0, changeable = false, range = 500,
            value = function()
                return lanedensmax[i] / ld_max
            end
        })
        table.insert(parts.value, {
            id = "count_key"..i, imgdef = imgdef.value.kasako27, digit = 3,
            value = function()
            return m.counter[i].get()
            end
        })
        table.insert(parts.value, {
            id = "total_key" .. i, imgdef = imgdef.value.kasako27, digit = 7, timer = MAIN.TIMER.ENDOFNOTE_1P,
            value = function()
                if main_state.timer(MAIN.TIMER.ENDOFNOTE_1P) ~= main_state.timer_off_value then
                    return util.number_increase(totalkey[i] - m.counter[i].get(), totalkey[i], 250, 750, (main_state.time() - main_state.timer(MAIN.TIMER.ENDOFNOTE_1P)) / 1000)
                end
                return totalkey[i]
            end
        })
        table.insert(parts.value, {
            id = "today_key" .. i, imgdef = imgdef.value.kasako27, digit = 5, timer = MAIN.TIMER.ENDOFNOTE_1P,
            value = function()
                if main_state.timer(MAIN.TIMER.ENDOFNOTE_1P) ~= main_state.timer_off_value then
                    return util.number_increase(todaykey[i] - m.counter[i].get(), todaykey[i], 250, 750, (main_state.time() - main_state.timer(MAIN.TIMER.ENDOFNOTE_1P)) / 1000)
                end
                return todaykey[i]
            end
        })
    end

    -- 各種数値
    table.insert(parts.value, {
        id = "shunkan_int", imgdef = imgdef.value.toa20n, digit = 3, value = function()
            return math.floor(m.decayer:sum())
        end
    })
    table.insert(parts.value, {
        id = "shunkan_frc", imgdef = imgdef.value.toa20r, digit = 2, value = function()
            local _, f = math.modf(m.decayer:sum())
            return math.floor(f*100)
        end
    })
    table.insert(parts.value, {
        id = "hosei_int", imgdef = imgdef.value.toa20n, digit = 3, value = function()
            return math.floor(m.delayedDecayer:sum())
        end
    })
    table.insert(parts.value, {
        id = "hosei_frc", imgdef = imgdef.value.toa20r, digit = 2, value = function()
            local _, f = math.modf(m.delayedDecayer:sum())
            return math.floor(f*100)
        end
    })

    -- トレンドグラフ
    for i = 1, t_sample - bound do
        table.insert(parts.graph, {
            id = "trend_total_s"..i, imgdef = imgdef.const.white, angle = 1,
            value = function()
                return trend2.getdata(i) / t_max
            end
        })
    end
    for i = 1, bound do
        table.insert(parts.graph, {
            id = "trend_total_s"..(t_sample-bound+i), imgdef = imgdef.const.white, angle = 1,
            value = function()
                return trend.getdata(i) / t_max
            end
        })
    end
    -- トレンドの平均と最大
    table.insert(parts.slider, {
        id = "trend_avg", imgdef = imgdef.const.white, angle = 0, changeable = false, range = 340,
        value = function()
            return trend2.getavg() / t_max
        end
    })
    table.insert(parts.slider, {
        id = "trend_max", imgdef = imgdef.const.white, angle = 0, changeable = false, range = 340,
        value = function()
            return trend2.getmax() / t_max
        end
    })
    table.insert(parts.value, {
        id = "trend_avg_int", imgdef = imgdef.value.toa20n, digit = 3, value = function()
            return math.floor(trend2.getavg())
        end
    })
    table.insert(parts.value, {
        id = "trend_avg_frc", imgdef = imgdef.value.toa20r, digit = 2, value = function()
            local _, f = math.modf(trend2.getavg())
            return math.floor(f*100)
        end
    })
    table.insert(parts.value, {
        id = "trend_max_int", imgdef = imgdef.value.toa20n, digit = 3, value = function()
            return math.floor(trend2.getmax())
        end
    })
    table.insert(parts.value, {
        id = "trend_max_frc", imgdef = imgdef.value.toa20r, digit = 2, value = function()
            local _, f = math.modf(trend2.getmax())
            return math.floor(f*100)
        end
    })

    -- 連打分布グラフ
    for i = 1, #rendafrq.getdata() do
        table.insert(parts.graph, {
            id = "frq_g_"..i, imgdef = imgdef.const.white, angle = 1,
            value = function()
                return rendafrq.getdata()[i] / rendafrq.getmax()
            end
        })
    end
    for i = frq_min, frq_max do
        table.insert(parts.value, {
            id = "frq_memori"..i, imgdef = imgdef.value.toa16n, digit = ((i < 10) and 1) or 2, value = function()
                return i
            end
        })
    end
    table.insert(parts.value, {
        id = "frq_nummax", imgdef = imgdef.value.toa16n, digit = 4, value = function()
            return rendafrq.getmax()
        end
    })

    -- imgdefテーブルのunpack
    for _, t in pairs(parts.image) do
        util.unpack(t, "imgdef")
    end
    for _, t in pairs(parts.value) do
        util.unpack(t, "imgdef")
    end
    for _, t in pairs(parts.graph) do
        util.unpack(t, "imgdef")
    end
    for _, t in pairs(parts.slider) do
        util.unpack(t, "imgdef")
    end

    -- 全体の処理とパフォーマンス測定
    table.insert(parts.value, {
        id = "performance", src = 31, x = 0, y = 25, w = 209, h = 25, divx = 11, divy = 1, digit = 3,
        value = function()
            local now = main_state.time()
            local flg = ((now - t_prev) > t_freq)
            for i = 1, keys do
                m:decay(i, now)
                local timervalue = main_state.timer(timers[i])
                if (timervalue ~= keyontimes[i] and timervalue ~= main_state.timer_off_value) then
                    counted[i] = true
                    m:increment(i)
                    local temp = (m.decayer[i].get() - decayprevs[i]) * decayprevs[i]
                    if temp > 1 then temp = 1 end
                    if temp < -1.5 then temp = -1.5 end
                    decaydiffs[i] = temp
                    decayprevs[i] = m.decayer[i].get()
                    rendafrq.insert(timervalue - keyontimes[i])
                    keyontimes[i] = timervalue
                end
                if (counted[i] and timervalue == main_state.timer_off_value) then
                    counted[i] = false
                    local pressingtime = now - keyontimes[i]
                    if pressingtime > holdThreshold then
                        m.adder[i].add(pressingtime/1000000)
                    end
                end
                if lanedensmax[i] < m.decayer[i].get() - e_const then
                    lanedensmax[i] = m.decayer[i].get() - e_const
                end
            end
            if flg then
                trend.insert(m.decayer:sum())
                trend2.insert(m.delayedDecayer:sum())
                t_prev = now
            end
            -- 演奏終了時に一度だけ実行し、ファイル入出力
            if (main_state.timer(MAIN.TIMER.ENDOFNOTE_1P) ~= main_state.timer_off_value or main_state.timer(MAIN.TIMER.FAILED) ~= main_state.timer_off_value) and once then
                once = false
                if not (main_state.option(MAIN.OP.AUTOPLAYON) or main_state.option(MAIN.OP.REPLAY_PLAYING)) then
                    local totalPath = skin_config.get_path("io/Play/sp/log/total.txt")
                    if CUSTOM.FUNC.existFile(totalPath) == false then
                        -- ファイル作成＆初期化処理
                        init_file(totalPath, keys)
                    end
                    totalkey = lines_to_list(totalPath)

                    local lntotalPath = skin_config.get_path("io/Play/sp/lnlog/total.txt")
                    if CUSTOM.FUNC.existFile(lntotalPath) == false then
                        -- ファイル作成＆初期化処理
                        init_file(lntotalPath, keys)
                    end
                    totalln = lines_to_list(lntotalPath)

                    local logdirPath = skin_config.get_path("io/Play/sp/log/" ..filename)
                    if CUSTOM.FUNC.existFile(logdirPath) == false then
                        -- ファイル作成＆初期化処理
                        init_file(logdirPath, keys)

                    end
                    todaykey = lines_to_list(logdirPath)

                    local lnlogdirPath = skin_config.get_path("io/Play/sp/lnlog/" ..filename)
                    if CUSTOM.FUNC.existFile(lnlogdirPath) == false then
                        -- ファイル作成＆初期化処理
                        init_file(lnlogdirPath, keys)

                    end
                    todayln = lines_to_list(lnlogdirPath)

                    for i = 1, keys do
                        totalkey[i] = totalkey[i] + m.counter[i].get()
                        todaykey[i] = todaykey[i] + m.counter[i].get()
                        totalln[i] = totalln[i] + m.adder[i].get()
                        todayln[i] = todayln[i] + m.adder[i].get()
                    end
                    -- 書き込み
                    list_to_file(totalkey, totalPath)
                    list_to_file(totalln, lntotalPath)
                    list_to_file(todaykey, logdirPath)
                    list_to_file(todayln, lnlogdirPath)

                    -- 粘着情報
                    local d = {}
                    table.insert(d, main_state.number(MAIN.NUM.PERFECT) + main_state.number(MAIN.NUM.GREAT) + main_state.number(MAIN.NUM.GOOD) + main_state.number(MAIN.NUM.BAD) + main_state.number(MAIN.NUM.POOR))
                    table.insert(d, math.floor(main_state.rate() * 10000))
                    table.insert(d, main_state.number(MAIN.NUM.BAD_PLUS_POOR_PLUS_MISS))
                    table.insert(d, main_state.number(MAIN.NUM.TOTALEARLY))
                    table.insert(d, main_state.number(MAIN.NUM.TOTALLATE))
                    nentyaku.updatehistory(title, d)
                end
            end

            if now - prev > 1000000 then
                pps = ppstemp
                ppstemp = 0
                prev = now
            end
            ppstemp = ppstemp + 1
            return pps
        end
    })

    -- 配置
    parts.destination = {}
    local dstdef_rep = {
        notesgraph = { { x = bx + 0, y = by + 35, w = 654, h = 166 } },
    }

    -- 繰り返しのないパーツ
    local dstdef = {
        { id = "date_format", dst = { { x = bx + 4, y = by + 2, w = 388, h = 29 } } },
        { id = "date_year", dst = { { x = bx + 5, y = by + 4, w = 19, h = 25 } } },
        { id = "date_month", dst = { { x = bx + 96, y = by + 4, w = 19, h = 25 } } },
        { id = "date_day", dst = { { x = bx + 149, y = by + 4, w = 19, h = 25 } } },
        { id = "date_youbi", dst = { { x = bx + 210, y = by + 3, w = 27, h = 27} } },
        { id = "date_hour", dst = { { x = bx + 263, y = by + 4, w = 19, h = 25} } },
        { id = "date_minute", dst = { { x = bx + 308, y = by + 4, w = 19, h = 25} } },
        { id = "date_second", dst = { { x = bx + 353, y = by + 4, w = 19, h = 25} } },
        { id = "text_lanedensity", dst = { { x = bx + 3, y = by + 203, w = 136, h = 30 } } },
        { id = "text_totalcount", dst = { { x = bx + 143, y = by + 203, w = 136, h = 30 } } },
        { id = MAIN.IMAGE.WHITE, dst = { { x = bx + 0, y = by + 234, w = 140, h = 2, a = 128 } } },
        { id = MAIN.IMAGE.WHITE, dst = { { x = bx + 142, y = by + 234, w = 140, h = 2, a = 128 } } },
        { id = MAIN.IMAGE.WHITE, dst = { { x = bx + 655 + t_sample - bound, y = by + 35, w = 1, h = 340, g = 0, b = 0} } }
    }

    -- 密度・打鍵グラフとMAXのスライダー
    for i = 1, keys do
        table.insert(dstdef, {
            id = "lane_loosedensity"..i, dst =  { { x = bx + 20 + lgwidth * (i - 1), y = by + 234, w = lgwidth, h = 500, r = keycolor.r[i] / 2, g = keycolor.g[i] / 2, b = keycolor.b[i] / 2} }
        })
        table.insert(dstdef, {
            id = "lane_density"..i, loop = 3000, timer = function()
                return main_state.time() - (1 - decaydiffs[i] + decayprevs[i] - m.decayer[i].get()) * 1000000
            end,
            dst =  {
                { time = 0000, x = bx + 20 + lgwidth * (i - 1), y = by + 234, w = lgwidth, h = 500, r = 255, g = 0, b = 0 },
                { time = 1000, r = keycolor.r[i], g = keycolor.g[i], b = keycolor.b[i]},
                { time = 2000, r = keycolor.r[i], g = keycolor.g[i], b = keycolor.b[i]},
                { time = 2500, r = 64, g = 64, b = 255},
                { time = 3000, r = keycolor.r[i], g = keycolor.g[i], b = keycolor.b[i]}
            }
        })
        table.insert(dstdef, {
            id = "total_count"..i, dst =  { { x = bx + 162 + lgwidth * (i - 1), y = by + 234, w = lgwidth, h = 500, r = keycolor.r[i], g = keycolor.g[i], b = keycolor.b[i]} }
        })
        table.insert(dstdef, {
            id = "lane_densmax"..i, dst =  { { x = bx + 20 + lgwidth * (i - 1), y = by + 234, w = lgwidth, h = 2, r = keycolor.r[i], g = keycolor.g[i], b = keycolor.b[i]} }
        })
    end

    -- グラフの目盛線と数字
    local span = 500 / ld_max
    for i = 1, ld_max do
        table.insert(dstdef, {
            id = MAIN.IMAGE.WHITE, dst = { { x = bx + 20, y = by + 234 + span * i, w = lgwidth * keys, h = 1 , r = 128, g = 128, b = 128} }
        })
        table.insert(dstdef, {
            id = MAIN.IMAGE.WHITE, dst = { { x = bx + 162, y = by + 234 + span * i, w = lgwidth * keys, h = 1 , r = 128, g = 128, b = 128} }
        })
        table.insert(dstdef, {
            id = "num"..i -1, dst = { { x = bx - 12, y = by + 200 + span * i, w = 16, h = 20 } }
        })
    end

    -- 配置ここから
    -- トレンドグラフ
    do
        local adposx = 655
        for i = 1, t_sample - bound do
            table.insert(parts.destination, {
                id = "trend_total_s"..i, loop = 5000, timer = function()
                    return main_state.time() - trend2.getdata(i) * 100000
                end, dst = {
                    { time = 0000, x = bx + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 0, g = 0, b = 255},
                    { time = 1000, x = bx + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 0, g = 255, b = 0},
                    { time = 2000, x = bx + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 255, b = 0},
                    { time = 3000, x = bx + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 0, b = 0},
                    { time = 4000, x = bx + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 0, b = 255},
                    { time = 5000, x = bx + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 255, b = 255},
                }
            })
        end
        for i = 1, bound do
            table.insert(parts.destination, {
                id = "trend_total_s"..(t_sample-bound+i), loop = 5000, timer = function()
                    return main_state.time() - trend.getdata(i) * 100000
                end, dst = {
                    { time = 0000, x = bx + t_sample - bound + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 0, g = 0, b = 255},
                    { time = 1000, x = bx + t_sample - bound + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 0, g = 255, b = 0},
                    { time = 2000, x = bx + t_sample - bound + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 255, b = 0},
                    { time = 3000, x = bx + t_sample - bound + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 0, b = 0},
                    { time = 4000, x = bx + t_sample - bound + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 0, b = 255},
                    { time = 5000, x = bx + t_sample - bound + adposx + 1 * i, y = by + 35, w = 1, h = 340 , r = 255, g = 255, b = 255},
                }
            })
        end

        -- トレンドグラフの目盛線
        local line_y = 0
        while line_y <= t_max do
            table.insert(parts.destination, {
                id = MAIN.IMAGE.WHITE, dst = { { x = bx + adposx, y = by + 35 + (line_y / t_max) * 340, w = t_sample, h = 1, r = 128, g = 128, b = 128 } }
            })
            line_y = line_y + 10
        end
        -- トレンドグラフのmaxとavg
        table.insert(parts.destination, {
            id = "trend_avg", blend = 9, dst = { { x = bx + adposx, y = by + 35, w = 640, h = 1} }
        })
        table.insert(parts.destination, {
            id = "trend_max", dst = { { x = bx + adposx, y = by + 35, w = 640, h = 1, r = 255, g = 200, b = 0} }
        })
        -- トレンドの文字
        table.insert(parts.destination, {
            id = "text_kukan", timer = function()
                return main_state.time() - (trend2.getavg() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx, y = by + 35, w = 110, h = 30 },
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "text_dot", timer = function()
                return main_state.time() - (trend2.getavg() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx + 167, y = by + 35, w = 8, h = 30 },
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "trend_avg_int", timer = function()
                return main_state.time() - (trend2.getavg() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx + 110 , y = by + 35, w = 19, h = 25 },
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "trend_avg_frc", timer = function()
                return main_state.time() - (trend2.getavg() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx + 175 , y = by + 35, w = 19, h = 25 },
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "text_saidai", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx + 230, y = by + 35, w = 110, h = 30 },
                { time = 3000, y = by + 35 + 1020 }
            }
        })
        table.insert(parts.destination, {
            id = "text_dot", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx + 397, y = by + 35, w = 8, h = 30 },
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "trend_max_int", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx + 340 , y = by + 35, w = 19, h = 25 },
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "trend_max_frc", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, dst  = {
                { time = 0, x = bx + adposx + 405 , y = by + 35, w = 19, h = 25 },
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        -- 最大密度更新時
        table.insert(parts.destination, {
            id = "text_saidai", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, draw = function()
                return trend2.getmaxupdateflg()
            end, dst  = {
                { time = 0, x = bx + adposx + 230, y = by + 35, w = 110, h = 30, r = 255, g = 200, b = 0},
                { time = 3000, y = by + 35 + 1020 }
            }
        })
        table.insert(parts.destination, {
            id = "text_dot", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, draw = function()
                return trend2.getmaxupdateflg()
            end, dst  = {
                { time = 0, x = bx + adposx + 397, y = by + 35, w = 8, h = 30, r = 255, g = 200, b = 0},
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "trend_max_int", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, draw = function()
                return trend2.getmaxupdateflg()
            end, dst  = {
                { time = 0, x = bx + adposx + 340 , y = by + 35, w = 19, h = 25, r = 255, g = 200, b = 0},
                { time = 3000, y = by + 35 + 1020 },
            }
        })
        table.insert(parts.destination, {
            id = "trend_max_frc", timer = function()
                return main_state.time() - (trend2.getmax() / t_max) * 1000000
            end, draw = function()
                return trend2.getmaxupdateflg()
            end, dst  = {
                { time = 0, x = bx + adposx + 405 , y = by + 35, w = 19, h = 25, r = 255, g = 200, b = 0},
                { time = 3000, y = by + 35 + 1020 },
            }
        })

        table.insert(parts.destination, {
            id = "text_hosei", dst  = {
                { time = 0, x = bx + adposx + 185, y = by, w = 110, h = 30 }
            }
        })
        table.insert(parts.destination, {
            id = "hosei_int", dst = { { x = bx + adposx + 295, y = by, w = 19, h = 25 } }
        })
        table.insert(parts.destination, {
            id = "text_dot", dst  = {
                { time = 0, x = bx + adposx + 352, y = by, w = 8, h = 30 }
            }
        })
        table.insert(parts.destination, {
            id = "hosei_frc", dst = { { x = bx + adposx + 360, y = by, w = 19, h = 25 } }
        })

        for _, tbl in ipairs(dstdef) do
            table.insert(parts.destination, tbl)
        end

        table.insert(parts.destination, {
            id = "text_shunkan", dst  = {
                { time = 0, x = bx + adposx + 420, y = by, w = 110, h = 30 }
            }
        })
        table.insert(parts.destination, {
            id = "shunkan_int", dst = { { x = bx + adposx + 530, y = by, w = 19, h = 25 } }
        })
        table.insert(parts.destination, {
            id = "text_dot", dst  = {
                { time = 0, x = bx + adposx + 587, y = by, w = 8, h = 30 }
            }
        })
        table.insert(parts.destination, {
            id = "shunkan_frc", dst = { { x = bx + adposx + 595, y = by, w = 19, h = 25 } }
        })
    end

    -- 連打分布グラフ
    local r_base = { x = bx + 284, y = by + 215 }
    local r_h = 172
    local r_w = 368 / #rendafrq.getdata()
    for i = 1, #rendafrq.getdata() do
        table.insert(parts.destination, {
            id = "frq_g_"..i, dst = { { x = r_base.x + r_w * (i - 1), y = r_base.y, w = r_w, h = r_h} }
        })
    end
    table.insert(parts.destination, {
         id = MAIN.IMAGE.WHITE, dst = { { x = r_base.x , y = r_base.y + r_h , w = 368 , h = 1, a = 128 } }
    })
    table.insert(parts.destination, {
        id = "frq_nummax", dst = { { x = r_base.x , y = r_base.y + r_h , w = 15 , h = 20 } }
    })
    local j = 0
    for i = frq_min, frq_max do
        table.insert(parts.destination, {
            id = "frq_memori"..i, dst = { { x = r_base.x + j * r_w * frq_fineness, y = r_base.y - 11, w = 8, h = 10 } }
        })
        table.insert(parts.destination, {
            id = MAIN.IMAGE.WHITE, dst = { {  x = r_base.x + j * r_w * frq_fineness, y = r_base.y - 3, w = 1, h = r_h + 3 , a = 92} }
        })
        j = j + 1
    end

    for _, tbl in ipairs(dstdef) do
        table.insert(parts.destination, tbl)
    end

    -- レーン毎カウンタ
    for i = 1, keys, 1 do
        table.insert(parts.destination, {
            id = "count_key"..i, dst = {
                {x = BASE.playsidePositionX + BASE.KEYCOUNT.x[i], y = BASE.KEYCOUNT.y[i], w = 22, h = 20, r = BASE.KEYCOUNT.r[i], g = BASE.KEYCOUNT.g[i], b = BASE.KEYCOUNT.b[i]},
            }
        })
    end
    
    -- 密度BPMグラフ
    table.insert(parts.destination, {
        id = "bgajdg", dst = dstdef_rep.notesgraph
    })
    table.insert(parts.destination, {
        id = "bgabpm", dst = dstdef_rep.notesgraph
    })

    -- 一時的に移植
    -- 累計カウンタ画像配置
    -- フレームを配置したい
    if keys == 6 then
        table.insert(parts.image, {id = "counterFrame", src = 31, x = 400, y = 400, w = 400, h = 190})
    elseif keys == 8 then
        table.insert(parts.image, {id = "counterFrame", src = 31, x = 0, y = 400, w = 400, h = 190})
    end
    table.insert(parts.destination, {
        id = "counterFrame", timer = MAIN.TIMER.ENDOFNOTE_1P, loop = 200, op = {-84, -33},
        dst = {
            {x = bx + 900, y = tpos.y[8] + 3, w = 400, h = 190, a = 0},
            {time = 200, a = 255}
        }
    })
    for i = 1, 8, 1 do
        table.insert(parts.destination, {
            id = "total_key" .. i, timer = MAIN.TIMER.ENDOFNOTE_1P, loop = 200, op = {-84, -33},
            dst = {
                {x = bx + 1000, y = tpos.y[i], w = 22, h = 20, r = trgb.r[i], g = trgb.g[i], b = trgb.b[i], a = 0},
                {time = 200, a = 255}
            }
        })
    end
    -- 日計カウンタ画像配置
    for i = 1, 8, 1 do
        table.insert(parts.destination, {
            id = "today_key" .. i, timer = MAIN.TIMER.ENDOFNOTE_1P, loop = 200, op = {-84, -33},
            dst = {
                {x = bx + 1170, y = tpos.y[i], w = 22, h = 20, r = trgb.r[i], g = trgb.g[i], b = trgb.b[i]},
                {time = 200, a = 255}
            }
        })
    end
    -- 一時的に移植ここまで

    --粘着情報配置
    if title == ntitle then
        local n_base = { x = bx + 290, y = by + 700 }
        table.insert(parts.destination, {id = "n_info", dst = { {x = n_base.x, y = n_base.y, w = 75, h = 20} } })
        table.insert(parts.destination, {id = "n_count", dst = { {x = n_base.x, y = n_base.y - 25, w = 37, h = 20} } })
        table.insert(parts.destination, {id = "n_note", dst = { {x = n_base.x + 55, y = n_base.y - 25, w = 50, h = 20} } })
        table.insert(parts.destination, {id = "n_rate", dst = { {x = n_base.x + 110, y = n_base.y - 25, w = 50, h = 20} } })
        table.insert(parts.destination, {id = "n_miss", dst = { {x = n_base.x + 165, y = n_base.y - 25, w = 50, h = 20} } })
        table.insert(parts.destination, {id = "n_fast", dst = { {x = n_base.x + 220, y = n_base.y - 25, w = 50, h = 20} } })
        table.insert(parts.destination, {id = "n_slow", dst = { {x = n_base.x + 275, y = n_base.y - 25, w = 50, h = 20} } })
        for i = 1, #ndata do
            table.insert(parts.destination, {id = "n_count_"..i, dst = { {x = n_base.x + 0, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
            table.insert(parts.destination, {id = "n_note_"..i, dst = { {x = n_base.x + 55, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
            table.insert(parts.destination, {id = "n_rate_"..i, dst = { {x = n_base.x + 110, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
            table.insert(parts.destination, {id = "n_miss_"..i, dst = { {x = n_base.x + 165, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
            if tonumber(ndata[i][5]) > tonumber(ndata[i][6]) then
                -- fast多い
                table.insert(parts.destination, {id = "n_fast_"..i, dst = { {x = n_base.x + 220, y = n_base.y - 25 * (i + 1), w = 12, h = 20, r = 0, g = 200, b = 250 } } })
                table.insert(parts.destination, {id = "n_slow_"..i, dst = { {x = n_base.x + 275, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
            elseif tonumber(ndata[i][5]) < tonumber(ndata[i][6]) then
                -- slow多い
                table.insert(parts.destination, {id = "n_fast_"..i, dst = { {x = n_base.x + 220, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
                table.insert(parts.destination, {id = "n_slow_"..i, dst = { {x = n_base.x + 275, y = n_base.y - 25 * (i + 1), w = 12, h = 20, r = 250, g = 76, b = 0 } } })
            else
                -- 同じ
                table.insert(parts.destination, {id = "n_fast_"..i, dst = { {x = n_base.x + 220, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
                table.insert(parts.destination, {id = "n_slow_"..i, dst = { {x = n_base.x + 275, y = n_base.y - 25 * (i + 1), w = 12, h = 20 } } })
            end
        end
        -- 注意報関係
        if #ndata >= 30 then
            table.insert(parts.destination, {id = "n_alart", loop = 3000,
            dst = {
                {time = 0, x = n_base.x + 80, y = n_base.y, w = 280, h = 38, r = 0, g = 0, b = 0},
                {time = 2500},
                {time = 3000, r = 255, g = 255, b = 255},
                {time = 4000, r = 0},
                {time = 5000, r = 255, g = 255, b = 255}
            }})
        elseif #ndata >= 20 then
            table.insert(parts.destination, {id = "n_alart", loop = 3000,
            dst = {
                {time = 0, x = n_base.x + 80, y = n_base.y, w = 280, h = 38, r = 0, g = 0, b = 0},
                {time = 2500},
                {time = 3000, r = 255, b = 255},
                {time = 4000, r = 0},
                {time = 5000, r = 255, b = 255}
            }})
        elseif #ndata >= 10 then
            table.insert(parts.destination, {id = "n_alart", loop = 3000,
            dst = {
                {time = 0, x = n_base.x + 80, y = n_base.y, w = 280, h = 38, r = 0, g = 0, b = 0},
                {time = 2500},
                {time = 3000, r = 255},
                {time = 4000, r = 0},
                {time = 5000, r = 255}
            }})
        elseif #ndata >= 5 then
            table.insert(parts.destination, {id = "n_alart", loop = 3000,
            dst = {
                {time = 0, x = n_base.x + 80, y = n_base.y, w = 280, h = 38, r = 0, g = 0, b = 0},
                {time = 2500},
                {time = 3000, r = 255, g = 255},
                {time = 5000, r = 0, g = 0},
                {time = 7000, r = 255, g = 255}
            }})
        end
    end

    -- パフォーマンス値
    table.insert(parts.destination, {
        id = "performance", dst = {
            {x = bx + 420, y = by + 4, w = 19, h = 25}
        }
    })

    return parts
end

return {
    load = load
}