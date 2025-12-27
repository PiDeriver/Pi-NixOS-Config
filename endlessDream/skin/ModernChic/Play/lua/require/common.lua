--[[
	共通化処理
	@author : KASAKO
]]
local module = {}

-- 小節線明るさ調整
module.offsetBarlineBright = function(offsetProperty)
	local num
	local def = 255
	local alpha = offsetProperty
	if alpha == 0 then
		num = def
	elseif (alpha > 0) and (alpha <= 255) then
		num = def - alpha
	else
		num = def
	end
	if DEBUG then
		print("小節線の明るさ:" ..num)
	end
	return num
end

-- ボムサイズオフセット
module.offsetBombSize = function(width, height, adjustPosY, offsetProperty)
	local magnification = offsetProperty
	if DEBUG then
		print("ボムサイズオフセット" ..magnification .."%")
	end
	if magnification < 1 or magnification > 100 then
		return width, height, adjustPosY
	else
		width = width * (magnification / 100)
		height = height * (magnification / 100)
		adjustPosY = adjustPosY * (magnification / 100)
		return width, height, adjustPosY
	end
end

module.offsetJudgelineHeight = function(offsetProperty)
	local def = 12 -- 判定ライン高さのデフォルト値
	local height = offsetProperty
	if height < 1 then
		return def
	end
	return height
end

module.offsetGlowlampHeight = function(offsetProperty)
	local def = 48
	local height = offsetProperty
	if height < 1 then
		return def
	end
	return height
end

-- キービームの高さ調節
module.setKeybeamHeight = function()
	local height = 564
	if PROPERTY.isBeamHeight100() then
		height = height * 1
	elseif PROPERTY.isBeamHeight90() then
		height = height * 0.9
	elseif PROPERTY.isBeamHeight80() then
		height = height * 0.8
	elseif PROPERTY.isBeamHeight70() then
		height = height * 0.7
	elseif PROPERTY.isBeamHeight60() then
		height = height * 0.6
	elseif PROPERTY.isBeamHeight50() then
		height = height * 0.5
	elseif PROPERTY.isBeamHeight40() then
		height = height * 0.4
	elseif PROPERTY.isBeamHeight30() then
		height = height * 0.3
	elseif PROPERTY.isBeamHeight20() then
		height = height * 0.2
	elseif PROPERTY.isBeamHeight10() then
		height = height * 0.1
	end
	if DEBUG then
		print("キービーム高さ：" ..height)
	end
	return height
end

-- キービーム消失時間（ミリ秒）
module.setTimeKeyOff = function()
	local time = 100
	if PROPERTY.isBeamDisappearanceTimeNormal() then
		time = 100
	elseif PROPERTY.isBeamDisappearanceTimeShort() then
		time = 50
	elseif PROPERTY.isBeamDisappearanceTimeLong() then
		time = 200
	end
	if DEBUG then
		print("キービーム消失時間：" ..time .."ミリ秒")
	end
	return time
end

module.setRGB = function()
	-- 難易度によって色を変えてみる
	local RGB = {255, 255, 255}
	if main_state.option(MAIN.OP.DIFFICULTY1) then
		RGB = {6, 255, 0}
	elseif main_state.option(MAIN.OP.DIFFICULTY2) then
		RGB = {18, 210, 215}
	elseif main_state.option(MAIN.OP.DIFFICULTY3) then
		RGB = {255, 192, 0}
	elseif main_state.option(MAIN.OP.DIFFICULTY4) then
		RGB = {255, 0, 0}
	elseif main_state.option(MAIN.OP.DIFFICULTY5) then
		RGB = {168, 64, 170}
	elseif main_state.option(MAIN.OP.DIFFICULTY0) then
		RGB = {195, 195, 195}
	end
	if DEBUG then
		print("タイトル部RGB値：" ..RGB[1] .."," ..RGB[2] .."," ..RGB[3])
	end
	return RGB
end

return module