--[[
    背景表示
	@author : KASAKO
]]
local function fcEffect(parts)
    table.insert(parts.destination, {id = MAIN.IMAGE.BLACK, draw = function ()
        return CUSTOM.SOUND.fcSound()
    end, dst = {{x = 0, y = 0, w = 1, h = 1, a = 0}}})
end

local function load(imageId)
    local parts = {}
    parts.image = {}
    parts.destination = {}
    if CONFIG.voice.play.sw and main_state.option(MAIN.OP.AUTOPLAYOFF) then
        CUSTOM.SOUND.initAchievementVoice()
        table.insert(parts.destination, {id = MAIN.IMAGE.BLACK, draw = function() return CUSTOM.SOUND.achievementVoice() end, dst = {{x = 0, y = 0, w = 1, h = 1, a = 0}}})
    end
    -- 背景
    table.insert(parts.image, {id = "bg", src = imageId, x = 0, y = 0, w = 1920, h = 1080})
	table.insert(parts.destination, {id = "bg", dst = {{x = 0, y = 0, w = 1920, h = 1080}}})
	-- 背景の明るさ調節
	table.insert(parts.destination, {id = MAIN.IMAGE.BLACK, offset = PROPERTY.offsetBgBrightness.num, dst = {{x = 0, y = 0, w = 1920, h = 1080, a = 0}}})
    -- フルコン時エフェクト音声
    if CONFIG.play.fcEffect then
        CUSTOM.SOUND.initFcSE()
        fcEffect(parts)
    end
    if CONFIG.infoOutput then CUSTOM.FUNC.infoOutput(0) end
    return parts
end

return {
    load = load
}