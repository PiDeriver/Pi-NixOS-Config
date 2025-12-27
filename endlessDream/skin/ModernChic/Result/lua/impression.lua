--[[
	インプレ機能
	DATE:22/12/04
	@author : KASAKO
]]
--DEBUG = true

local function impression(parts)
	local sw = CONFIG.impression.sw
	local favbtn = false
	local pos = {
		base = {x = RESULT_BASE.CENTER_POS_X + ((520 - 309) / 2), y = 340},
		key = {{x = 21, y = 20},{x = 21, y = 124},{x = 118, y = 124},{x = 214, y = 124},{x = 21, y = 228},{x = 118, y = 228},{x = 214, y = 228},{x = 21, y = 333},{x = 118, y = 333},{x = 214, y = 333}},
		enter = {x = 124, y = 20},
		impnum = {x = 50, y = 457},
		item = {x = 60, y = 490},
		impcount = {x = 67, y = 157},
		favbtn = {x = 227, y = 475}
	}
	--本体
	table.insert(parts.image, {id = "calculatorbody", src = 6, x = 700, y = 0, w = 309, h = 554})
	-- 表示スイッチ
	table.insert(parts.image, {id = "calculatorswitch", src = 6, x = 560, y = 600, w = 60, h = 50, act = function()
		sw = not sw
		CUSTOM.SOUND.calculatorChangeSound()
	end})
	table.insert(parts.destination, {id = "calculatorswitch", dst = {
		{time = 0, x = 0, y = 0, w = 60, h = 50},
		{time = 2000, a = 100},
		{time = 4000, a = 255}
	}})
	-- お気に入りボタン
	table.insert(parts.image, {id = "favbtn_off", src = 6, x = 530, y = 700, w = 50, h = 50, act = function()
		favbtn = not favbtn
	end})
	table.insert(parts.image, {id = "favbtn_on", src = 6, x = 580, y = 700, w = 50, h = 50, act = function()
		favbtn = not favbtn
	end})
	
	if CONFIG.impression.type == 0 then
		-- 総合点パターン
		local inputNumber = {}
		local num = 0
		local flg = true
		for i = 0, 9, 1 do
			table.insert(parts.image, {id = "number" ..i, src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
				CUSTOM.SOUND.clickSound()
				table.insert(inputNumber, i)
				for j = 1, #inputNumber, 1 do
					if (j == 1) and (inputNumber[1] ~= 0) then
						num = inputNumber[1]
					elseif j == 2 then
						num = (inputNumber[1] * 10) + inputNumber[2]
					elseif j == 3 then
						num = (inputNumber[1] * 100) + (inputNumber[2] * 10) + inputNumber[3]
					elseif j == 4 then
						num = (inputNumber[1] * 1000) + (inputNumber[2] * 100) + (inputNumber[3] * 10) + inputNumber[4]
					else
						-- 5桁以上はリセット
						inputNumber = {}
						num = 0
						if DEBUG then print("impression:数値リセット") end
					end
				end
				if DEBUG then print("impression:" ..num) end
			end})
		end
		-- 決定キーで記録保存処理
		table.insert(parts.image, {id = "calculatorenter", src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
			CUSTOM.SOUND.enterSound()
			local filePath = skin_config.get_path("History/impression.txt")
			-- ファイルが存在しない場合は新規作成
			if CUSTOM.FUNC.existFile(filePath) == false then
				CUSTOM.FUNC.createFile(filePath)
			end
			local f = io.open(filePath, "a")
			if favbtn then
				f:write(main_state.text(MAIN.STRING.TITLE) .."_" ..num .."pts" .."_" ..CONFIG.impression.msg .."★★★" .."\n")
				if DEBUG then print("impression:お気に入り処理完了") end
			else
				f:write(main_state.text(MAIN.STRING.TITLE) .."_" ..num .."pts" .."_" ..CONFIG.impression.msg .."\n")
				if DEBUG then print("impression:通常処理") end
			end
			f:close()
			flg = false
			print("impression:インプレ追記完了\n")
		end})
		-- 表示用数値
		table.insert(parts.value, {id = "impnum", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.RIGHT, value = function() return num end})
		table.insert(parts.destination, {
			id = "calculatorbody", draw = function() return flg and sw end, dst = {
				{x = pos.base.x, y = pos.base.y, w = 309, h = 554},
			}
		})
		-- お気に入りボタン
		table.insert(parts.destination, {
			id = "favbtn_off", draw = function() return flg and sw and not favbtn end, dst = {
				{x = pos.base.x + pos.favbtn.x, y = pos.base.y + pos.favbtn.y, w = 50, h = 50},
			}
		})
		table.insert(parts.destination, {
			id = "favbtn_on", draw = function() return flg and sw and favbtn end, dst = {
				{x = pos.base.x + pos.favbtn.x, y = pos.base.y + pos.favbtn.y, w = 50, h = 50},
			}
		})
		-- ボタン配置
		for i = 0, 9, 1 do
			table.insert(parts.destination, {
				id = "number" ..i, draw = function() return flg and sw end, dst = {
					{x = pos.base.x + pos.key[i+1].x, y = pos.base.y + pos.key[i+1].y, w = 75, h = 95}
				}
			})
		end
		table.insert(parts.destination, {
			id = "calculatorenter", draw = function() return flg and sw end, dst = {
				{x = pos.base.x + pos.enter.x, y = pos.base.y + pos.enter.y, w = 172, h = 95}
			}
		})
		table.insert(parts.destination, {
			id = "impnum", draw = function() return sw end, dst = {
				{x = pos.base.x + pos.impnum.x, y = pos.base.y + pos.impnum.y, w = 44, h = 60}
			}
		})
		-- 保存完了後は画像切替
		table.insert(parts.image, {id = "calculatorbody_saved", src = 6, x = 700, y = 560, w = 309, h = 554})
		table.insert(parts.destination, {
			id = "calculatorbody_saved", draw = function() return not flg and sw end, dst = {
				{x = pos.base.x, y = pos.base.y, w = 309, h = 554},
			}
		})
		-- インプレカウンター
		table.insert(parts.value, {id = "impcount", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.CENTER, value = function() return CUSTOM.NUM.impressionCount end})
		table.insert(parts.destination, {
			id = "impcount", draw = function() return not flg and sw end, dst = {
				{x = pos.base.x + pos.impcount.x, y = pos.base.y + pos.impcount.y, w = 44, h = 60}
			}
		})
	elseif CONFIG.impression.type == 1 then
		-- 集計パターン
		local inputNumber = {song = {}, bga = {}, etc = {}}
		local num = {song = 0, bga = 0, etc = 0}
		local flg = {song = true, bga = true, last = true}
		-- 項目1
		for i = 0, 9, 1 do
			table.insert(parts.image, {id = "snum" ..i, src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
				CUSTOM.SOUND.clickSound()
				table.insert(inputNumber.song, i)
				for j = 1, #inputNumber.song, 1 do
					if (j == 1) and (inputNumber.song[1] ~= 0) then
						num.song = inputNumber.song[1]
					elseif j == 2 then
						num.song = (inputNumber.song[1] * 10) + inputNumber.song[2]
					elseif j == 3 then
						num.song = (inputNumber.song[1] * 100) + (inputNumber.song[2] * 10) + inputNumber.song[3]
					elseif j == 4 then
						num.song = (inputNumber.song[1] * 1000) + (inputNumber.song[2] * 100) + (inputNumber.song[3] * 10) + inputNumber.song[4]
					end
					if (inputNumber.song[1] == 0) or num.song > CONFIG.impression.songLimit then
						-- リセット処理
						inputNumber.song = {}
						num.song = 0
						if DEBUG then print("SONG:数値リセット") end
					end
				end
				if DEBUG then print("SONG:" ..num.song) end
			end})
		end
		-- 項目2
		for i = 0, 9, 1 do
			table.insert(parts.image, {id = "bnum" ..i, src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
				CUSTOM.SOUND.clickSound()
				table.insert(inputNumber.bga, i)
				for j = 1, #inputNumber.bga, 1 do
					if (j == 1) and (inputNumber.bga[1] ~= 0) then
						num.bga = inputNumber.bga[1]
					elseif j == 2 then
						num.bga = (inputNumber.bga[1] * 10) + inputNumber.bga[2]
					elseif j == 3 then
						num.bga = (inputNumber.bga[1] * 100) + (inputNumber.bga[2] * 10) + inputNumber.bga[3]
					elseif j == 4 then
						num.bga = (inputNumber.bga[1] * 1000) + (inputNumber.bga[2] * 100) + (inputNumber.bga[3] * 10) + inputNumber.bga[4]
					end
					if (inputNumber.bga[1] == 0) or num.bga > CONFIG.impression.bgaLimit then
						-- リセット処理
						inputNumber.bga = {}
						num.bga = 0
						if DEBUG then print("BGA:数値リセット") end
					end
				end
				if DEBUG then print("BGA:" ..num.bga) end
			end})
		end
		-- 項目3
		for i = 0, 9, 1 do
			table.insert(parts.image, {id = "enum" ..i, src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
				CUSTOM.SOUND.clickSound()
				table.insert(inputNumber.etc, i)
				for j = 1, #inputNumber.etc, 1 do
					if (j == 1) and (inputNumber.etc[1] ~= 0) then
						num.etc = inputNumber.etc[1]
					elseif j == 2 then
						num.etc = (inputNumber.etc[1] * 10) + inputNumber.etc[2]
					elseif j == 3 then
						num.etc = (inputNumber.etc[1] * 100) + (inputNumber.etc[2] * 10) + inputNumber.etc[3]
					elseif j == 4 then
						num.etc = (inputNumber.song[1] * 1000) + (inputNumber.etc[2] * 100) + (inputNumber.etc[3] * 10) + inputNumber.etc[4]
					end
					if (inputNumber.etc[1] == 0) or num.etc > CONFIG.impression.etcLimit then
						-- リセット処理
						inputNumber.etc = {}
						num.etc = 0
						if DEBUG then print("ETC:数値リセット") end
					end
				end
				if DEBUG then print("ETC:" ..num.etc) end
			end})
		end
		-- 表示用数値
		table.insert(parts.value, {id = "simpnum", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.RIGHT, value = function() return num.song end})
		table.insert(parts.value, {id = "bimpnum", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.RIGHT, value = function() return num.bga end})
		table.insert(parts.value, {id = "eimpnum", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.RIGHT, value = function() return num.etc end})
		-- 上限値
		table.insert(parts.value, {id = "songLimit", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.RIGHT, value = function() return CONFIG.impression.songLimit end})
		table.insert(parts.value, {id = "bgaLimit", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.RIGHT, value = function() return CONFIG.impression.bgaLimit end})
		table.insert(parts.value, {id = "etcLimit", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.RIGHT, value = function() return CONFIG.impression.etcLimit end})
		-- 計算機本体
		table.insert(parts.destination, {
			id = "calculatorbody", draw = function() return flg and sw end, dst = {
				{x = pos.base.x, y = pos.base.y, w = 309, h = 554},
			}
		})
		-- お気に入りボタン
		table.insert(parts.destination, {
			id = "favbtn_off", draw = function() return flg and sw and not favbtn end, dst = {
				{x = pos.base.x + pos.favbtn.x, y = pos.base.y + pos.favbtn.y, w = 50, h = 50},
			}
		})
		table.insert(parts.destination, {
			id = "favbtn_on", draw = function() return flg and sw and favbtn end, dst = {
				{x = pos.base.x + pos.favbtn.x, y = pos.base.y + pos.favbtn.y, w = 50, h = 50},
			}
		})
		-- 項目名と上限値
		table.insert(parts.destination, {
			id = "wd_song", draw = function() return flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.item.x, y = pos.base.y + pos.item.y, w = 309, h = 18},
			}
		})
		table.insert(parts.destination, {
			id = "songLimit", draw = function() return flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.item.x - 40, y = pos.base.y + pos.item.y - 25, w = 16, h = 22, r = 230, g = 100, b = 0},
			}
		})
		table.insert(parts.destination, {
			id = "wd_bga", draw = function() return not flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.item.x, y = pos.base.y + pos.item.y, w = 309, h = 18},
			}
		})
		table.insert(parts.destination, {
			id = "bgaLimit", draw = function() return not flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.item.x - 40, y = pos.base.y + pos.item.y - 25, w = 16, h = 22, r = 230, g = 100, b = 0},
			}
		})
		table.insert(parts.destination, {
			id = "wd_etc", draw = function() return not flg.song and not flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.item.x, y = pos.base.y + pos.item.y, w = 309, h = 18},
			}
		})
		table.insert(parts.destination, {
			id = "etcLimit", draw = function() return not flg.song and not flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.item.x - 40, y = pos.base.y + pos.item.y - 25, w = 16, h = 22, r = 230, g = 100, b = 0},
			}
		})
		-- ボタン
		for i = 0, 9, 1 do
			table.insert(parts.destination, {
				id = "snum" ..i, draw = function() return flg.song and flg.bga and flg.last and sw end, dst = {
					{x = pos.base.x + pos.key[i+1].x, y = pos.base.y + pos.key[i+1].y, w = 75, h = 95}
				}
			})
		end
		for i = 0, 9, 1 do
			table.insert(parts.destination, {
				id = "bnum" ..i, draw = function() return not flg.song and flg.bga and flg.last and sw end, dst = {
					{x = pos.base.x + pos.key[i+1].x, y = pos.base.y + pos.key[i+1].y, w = 75, h = 95}
				}
			})
		end
		for i = 0, 9, 1 do
			table.insert(parts.destination, {
				id = "enum" ..i, draw = function() return not flg.song and not flg.bga and flg.last and sw end, dst = {
					{x = pos.base.x + pos.key[i+1].x, y = pos.base.y + pos.key[i+1].y, w = 75, h = 95}
				}
			})
		end
		-- 入力中
		table.insert(parts.destination, {
			id = "simpnum", draw = function() return flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.impnum.x, y = pos.base.y + pos.impnum.y, w = 44, h = 60}
			}
		})
		table.insert(parts.destination, {
			id = "bimpnum", draw = function() return not flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.impnum.x, y = pos.base.y + pos.impnum.y, w = 44, h = 60}
			}
		})
		table.insert(parts.destination, {
			id = "eimpnum", draw = function() return not flg.song and not flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.impnum.x, y = pos.base.y + pos.impnum.y, w = 44, h = 60}
			}
		})
		-- 次へ(song→bga)
		table.insert(parts.image, {id = "next1", src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
			CUSTOM.SOUND.enterSound()
			flg.song = false
			print("SONG:インプレ完了。次へ")
		end})
		table.insert(parts.destination, {
			id = "next1", draw = function() return flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.enter.x, y = pos.base.y + pos.enter.y, w = 172, h = 95}
			}
		})
		-- 次へ(bga→etc)
		table.insert(parts.image, {id = "next2", src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
			CUSTOM.SOUND.enterSound()
			flg.bga = false
			print("BGA:インプレ完了。次へ")
		end})
		table.insert(parts.destination, {
			id = "next2", draw = function() return not flg.song and flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.enter.x, y = pos.base.y + pos.enter.y, w = 172, h = 95}
			}
		})
		-- 決定キーで記録保存処理
		table.insert(parts.image, {id = "calculatorenter", src = 6, x = 0, y = 0, w = 1, h = 1, act = function()
			CUSTOM.SOUND.enterSound()
			local filePath = skin_config.get_path("History/impression.txt")
			-- ファイルが存在しない場合は新規作成
			if CUSTOM.FUNC.existFile(filePath) == false then
				CUSTOM.FUNC.createFile(filePath)
			end
			local f = io.open(filePath, "a")
			if favbtn then
				f:write(main_state.text(MAIN.STRING.TITLE) .."_" ..num.song + num.bga + num.etc .."pts_" .."Song:" ..num.song .."/" ..CONFIG.impression.songLimit .."_Movie:" ..num.bga .."/" ..CONFIG.impression.bgaLimit .."_etc:" ..num.etc .."/" ..CONFIG.impression.etcLimit .."_" ..CONFIG.impression.msg .."★★★" .."\n")
				if DEBUG then print("impression:お気に入り処理完了") end
			else
				f:write(main_state.text(MAIN.STRING.TITLE) .."_" ..num.song + num.bga + num.etc .."pts_" .."Song:" ..num.song .."/" ..CONFIG.impression.songLimit .."_Movie:" ..num.bga .."/" ..CONFIG.impression.bgaLimit .."_etc:" ..num.etc .."/" ..CONFIG.impression.etcLimit .."_" ..CONFIG.impression.msg .."\n")
				if DEBUG then print("impression:通常処理") end
			end
			f:close()
			flg.last = false
			print("impression:インプレ追記完了\n")
		end})
		table.insert(parts.destination, {
			id = "calculatorenter", draw = function() return not flg.song and not flg.bga and flg.last and sw end, dst = {
				{x = pos.base.x + pos.enter.x, y = pos.base.y + pos.enter.y, w = 172, h = 95}
			}
		})
		-- 保存完了後は画像切替
		table.insert(parts.image, {id = "calculatorbody_saved", src = 6, x = 700, y = 560, w = 309, h = 554})
		table.insert(parts.destination, {
			id = "calculatorbody_saved", draw = function() return not flg.song and not flg.bga and not flg.last and sw end, dst = {
				{x = pos.base.x, y = pos.base.y, w = 309, h = 554},
			}
		})
		-- インプレカウンター
		table.insert(parts.value, {id = "impcount", src = 4, x = 0, y = 504, w = 440, h = 60, divx = 10, digit = 4, align = MAIN.N_ALIGN.CENTER, value = function() return CUSTOM.NUM.impressionCount end})
		table.insert(parts.destination, {
			id = "impcount", draw = function() return not flg.song and not flg.bga and not flg.last and sw end, dst = {
				{x = pos.base.x + pos.impcount.x, y = pos.base.y + pos.impcount.y, w = 44, h = 60}
			}
		})
	end
end

local function load()
	local parts = {}
	parts.image = {}
	parts.value = {}
	parts.destination = {}

	impression(parts)
	return parts
end

return {
	load = load
}