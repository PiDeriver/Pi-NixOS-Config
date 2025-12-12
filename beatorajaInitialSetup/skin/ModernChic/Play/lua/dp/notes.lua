--[[
    ノート定義と配置
    @author : KASAKO
]]

local function createNotesProperty(notesInfo, key)
    local keyLeftPosX = {}
    local keyRightPosX = {}
    local notesProperty = {}
    notesProperty.note = {}
    notesProperty.lnend = {}
    notesProperty.lnstart = {}
    notesProperty.lnbody = {}
    notesProperty.lnactive = {}
    notesProperty.hcnend = {}
    notesProperty.hcnstart = {}
    notesProperty.hcnbody = {}
    notesProperty.hcnactive = {}
    notesProperty.hcndamage = {}
    notesProperty.hcnreactive = {}
    notesProperty.mine = {}
    notesProperty.dst = {}

    if key == 10 then
        keyLeftPosX = {114, 177, 228, 291, 342, 3}
        keyRightPosX = {117, 180, 231, 294, 345, 408}
        notesProperty.note = {"note-w", "note-b", "note-w", "note-b", "note-w", "note-s", "note-w", "note-b", "note-w", "note-b", "note-w", "note-s"}
        notesProperty.lnend = {"lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-s", "lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-s"}
        notesProperty.lnstart = {"lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-s", "lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-s"}
        notesProperty.lnbody = {"lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-s", "lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-s"}
        notesProperty.lnactive = {"lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-s", "lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-s"}
        notesProperty.hcnend = {"hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-s", "hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-s"}
        notesProperty.hcnstart = {"hcns-w", "hcns-b", "hcns-w",  "hcns-b", "hcns-w", "hcns-s", "hcns-w", "hcns-b", "hcns-w",  "hcns-b", "hcns-w", "hcns-s"}
        notesProperty.hcnbody = {"hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-s", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-s"}
        notesProperty.hcnactive = {"hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-s", "hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-s"}
        notesProperty.hcndamage = {"hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-s", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-s"}
        notesProperty.hcnreactive = {"hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-s", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-s"}
        notesProperty.mine = {"mine-w", "mine-b", "mine-w", "mine-b", "mine-w", "mine-s", "mine-w", "mine-b", "mine-w", "mine-b", "mine-w","mine-s"}
        notesProperty.dst = {
            -- L1鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[1], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- L2鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[2], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- L3鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[3], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- L4鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[4], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- L5鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[5], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- L皿
            {x = BASE.laneLeftPosX + keyLeftPosX[6], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.scWidth, h = BASE.LANE_LENGTH - 12},
            -- R1鍵
            {x = BASE.laneRightPosX + keyRightPosX[1], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- R2鍵
            {x = BASE.laneRightPosX + keyRightPosX[2], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- R3鍵
            {x = BASE.laneRightPosX + keyRightPosX[3], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- R4鍵
            {x = BASE.laneRightPosX + keyRightPosX[4], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- R5鍵
            {x = BASE.laneRightPosX + keyRightPosX[5], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- R6皿
            {x = BASE.laneRightPosX + keyRightPosX[6], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.scWidth, h = BASE.LANE_LENGTH - 12},
		}
    elseif key == 14 then
        keyLeftPosX = {114, 177, 228, 291, 342, 405, 456, 3}
        keyRightPosX = {3, 66, 117, 180, 231, 294, 345, 408}
        notesProperty.note = {"note-w", "note-b", "note-w", "note-b", "note-w", "note-b", "note-w", "note-s", "note-w", "note-b", "note-w", "note-b", "note-w", "note-b", "note-w", "note-s"}
        notesProperty.lnend = {"lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-s", "lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-s"}
        notesProperty.lnstart = {"lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-s", "lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-s"}
        notesProperty.lnbody = {"lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-s", "lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-s"}
        notesProperty.lnactive = {"lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-s", "lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-s"}
        notesProperty.hcnend = {"hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-s", "hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-s"}
        notesProperty.hcnstart = {"hcns-w", "hcns-b", "hcns-w", "hcns-b", "hcns-w",  "hcns-b", "hcns-w", "hcns-s", "hcns-w", "hcns-b", "hcns-w", "hcns-b", "hcns-w",  "hcns-b", "hcns-w", "hcns-s"}
        notesProperty.hcnbody = {"hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-s", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-s"}
        notesProperty.hcnactive = {"hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-s", "hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-s"}
        notesProperty.hcndamage = {"hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-s", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-s"}
        notesProperty.hcnreactive = {"hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-s", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-s"}
        notesProperty.mine = {"mine-w", "mine-b", "mine-w", "mine-b", "mine-w", "mine-b", "mine-w", "mine-s", "mine-w", "mine-b", "mine-w", "mine-b", "mine-w", "mine-b", "mine-w","mine-s"}
        notesProperty.dst = {
            -- L1鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[1], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- L2鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[2], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- L3鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[3], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- L4鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[4], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- L5鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[5], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- L6鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[6], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- L7鍵
            {x = BASE.laneLeftPosX + keyLeftPosX[7], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- L皿
            {x = BASE.laneLeftPosX + keyLeftPosX[8], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.scWidth, h = BASE.LANE_LENGTH - 12},
            -- R1鍵
            {x = BASE.laneRightPosX + keyRightPosX[1], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- R2鍵
            {x = BASE.laneRightPosX + keyRightPosX[2], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- R3鍵
            {x = BASE.laneRightPosX + keyRightPosX[3], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- R4鍵
            {x = BASE.laneRightPosX + keyRightPosX[4], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- R5鍵
            {x = BASE.laneRightPosX + keyRightPosX[5], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- R6鍵
            {x = BASE.laneRightPosX + keyRightPosX[6], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.blueWidth, h = BASE.LANE_LENGTH - 12},
            -- R7鍵
            {x = BASE.laneRightPosX + keyRightPosX[7], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.whiteWidth, h = BASE.LANE_LENGTH - 12},
            -- R皿
            {x = BASE.laneRightPosX + keyRightPosX[8], y = BASE.NOTES_JUDGE_Y - 12, w = notesInfo.scWidth, h = BASE.LANE_LENGTH - 12},
		}
    end
    return notesProperty
end

local function load(key)
    local parts = {}

    local notesInfo = {
        whiteWidth = 60,
        whitePosX = 216,
        blueWidth = 48,
        bluePosX = 276,
        scWidth = 108,
        scPosX = 108,
        acPosX = 0,
        stdPosY = 0,
        lnePosY = 36,
        lnsPosY = 72,
        lnbPosY = 144,
        lnaPosY = 108,
        hcnePosY = 216,
        hcnsPosY = 252,
        hcnbPosY = 288,
        hcnrPosY = 324,
        hcnaPosY = 108,
        hcndPosY = 288,
        lnCycle = 200,
        hcnCycle = 200,
        hcnDamageCycle = 100,
        barlineBright = COMMONFUNC.offsetBarlineBright(PROPERTY.offsetBarlineBrightness.alpha())
    }

    local notesProperty = createNotesProperty(notesInfo, key)

    parts.image = {
        -- 通常ノート b:2,4,6 w:1,3,5,7 s:皿
        {id = "note-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.stdPosY, w = notesInfo.whiteWidth, h = 36},
        {id = "note-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.stdPosY, w = notesInfo.blueWidth, h = 36},
        {id = "note-s", src = 6, x = notesInfo.scPosX, y = notesInfo.stdPosY, w = notesInfo.scWidth, h = 36},
        {id = "note-a", src = 6, x = notesInfo.acPosX, y = notesInfo.stdPosY, w = notesInfo.scWidth, h = 36},
        -- ln終了（上部分）
        {id = "lne-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.lnePosY, w = notesInfo.whiteWidth, h = 36},
        {id = "lne-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.lnePosY, w = notesInfo.blueWidth, h = 36},
        {id = "lne-s", src = 6, x = notesInfo.scPosX, y = notesInfo.lnePosY, w = notesInfo.scWidth, h = 36},
        {id = "lne-a", src = 6, x = notesInfo.acPosX, y = notesInfo.lnePosY, w = notesInfo.scWidth, h = 36},
        -- ln開始（下部分）
        {id = "lns-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.lnsPosY, w = notesInfo.whiteWidth, h = 36},
        {id = "lns-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.lnsPosY, w = notesInfo.blueWidth, h = 36},
        {id = "lns-s", src = 6, x = notesInfo.scPosX, y = notesInfo.lnsPosY, w = notesInfo.scWidth, h = 36},
        {id = "lns-a", src = 6, x = notesInfo.acPosX, y = notesInfo.lnsPosY, w = notesInfo.scWidth, h = 36},
        -- ln途中（離している状態）
        {id = "lna-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.lnaPosY, w = notesInfo.whiteWidth, h = 36},
        {id = "lna-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.lnaPosY, w = notesInfo.blueWidth, h = 36},
        {id = "lna-s", src = 6, x = notesInfo.scPosX, y = notesInfo.lnaPosY, w = notesInfo.scWidth, h = 36},
        {id = "lna-a", src = 6, x = notesInfo.acPosX, y = notesInfo.lnaPosY, w = notesInfo.scWidth, h = 36},
        -- hcn終了（上部分）
        {id = "hcne-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcnePosY, w = notesInfo.whiteWidth, h = 36},
        {id = "hcne-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcnePosY, w = notesInfo.blueWidth, h = 36},
        {id = "hcne-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcnePosY, w = notesInfo.scWidth, h = 36},
        {id = "hcne-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcnePosY, w = notesInfo.scWidth, h = 36},
        -- hcn 開始（上部分）
        {id = "hcns-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcnsPosY, w = notesInfo.whiteWidth, h = 36},
        {id = "hcns-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcnsPosY, w = notesInfo.blueWidth, h = 36},
        {id = "hcns-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcnsPosY, w = notesInfo.scWidth, h = 36},
        {id = "hcns-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcnsPosY, w = notesInfo.scWidth, h = 36},
        -- hcn 入力する前の状態
        {id = "hcna-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcnaPosY, w = notesInfo.whiteWidth, h = 18},
        {id = "hcna-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcnaPosY, w = notesInfo.blueWidth, h = 18},
        {id = "hcna-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcnaPosY, w = notesInfo.scWidth, h = 18},
        {id = "hcna-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcnaPosY, w = notesInfo.scWidth, h = 18},
        --地雷
        {id = "mine-w", src = 26, x = notesInfo.whitePosX, y = 0, w = notesInfo.whiteWidth, h = 36},
        {id = "mine-b", src = 26, x = notesInfo.bluePosX, y = 0, w = notesInfo.blueWidth, h = 36},
        {id = "mine-s", src = 26, x = notesInfo.scPosX, y = 0, w = notesInfo.scWidth, h = 36},
        -- 小節線
        {id = "section-line", src = 1, x = 1, y = 0, w = 1, h = 1},
    }
    
    if CONFIG.play.notesAnimation then
        -- ln途中（押している状態）
        table.insert(parts.image, {id = "lnb-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.lnbPosY, w = notesInfo.whiteWidth, h = 72, divy = 2, cycle = notesInfo.lnCycle})
        table.insert(parts.image, {id = "lnb-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.lnbPosY, w = notesInfo.blueWidth, h = 72, divy = 2, cycle = notesInfo.lnCycle})
        table.insert(parts.image, {id = "lnb-s", src = 6, x = notesInfo.scPosX, y = notesInfo.lnbPosY, w = notesInfo.scWidth, h = 72, divy = 2, cycle = notesInfo.lnCycle})
        table.insert(parts.image, {id = "lnb-a", src = 6, x = notesInfo.acPosX, y = notesInfo.lnbPosY, w = notesInfo.scWidth, h = 72, divy = 2, cycle = notesInfo.lnCycle})
        -- hcn 入力中
        table.insert(parts.image, {id = "hcnb-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcnbPosY, w = notesInfo.whiteWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
        table.insert(parts.image, {id = "hcnb-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcnbPosY, w = notesInfo.blueWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
        table.insert(parts.image, {id = "hcnb-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcnbPosY, w = notesInfo.scWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
        table.insert(parts.image, {id = "hcnb-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcnbPosY, w = notesInfo.scWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
        -- hcnダメージエフェクト
        table.insert(parts.image, {id = "hcnr-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcnrPosY, w = notesInfo.whiteWidth, h = 36, divy = 2, cycle = notesInfo.hcnDamageCycle})
        table.insert(parts.image, {id = "hcnr-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcnrPosY, w = notesInfo.blueWidth, h = 36, divy = 2, cycle = notesInfo.hcnDamageCycle})
        table.insert(parts.image, {id = "hcnr-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcnrPosY, w = notesInfo.scWidth, h = 36, divy = 2, cycle = notesInfo.hcnDamageCycle})
        table.insert(parts.image, {id = "hcnr-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcnrPosY, w = notesInfo.scWidth, h = 36, divy = 2, cycle = notesInfo.hcnDamageCycle})
        -- hcn 途中から押したとき
        table.insert(parts.image, {id = "hcnd-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcndPosY, w = notesInfo.whiteWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
        table.insert(parts.image, {id = "hcnd-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcndPosY, w = notesInfo.blueWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
        table.insert(parts.image, {id = "hcnd-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcndPosY, w = notesInfo.scWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
        table.insert(parts.image, {id = "hcnd-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcndPosY, w = notesInfo.scWidth, h = 36, divy = 2, cycle = notesInfo.hcnCycle})
    else
        -- ln途中（押している状態）
        table.insert(parts.image, {id = "lnb-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.lnbPosY, w = notesInfo.whiteWidth, h = 36})
        table.insert(parts.image, {id = "lnb-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.lnbPosY, w = notesInfo.blueWidth, h = 36})
        table.insert(parts.image, {id = "lnb-s", src = 6, x = notesInfo.scPosX, y = notesInfo.lnbPosY, w = notesInfo.scWidth, h = 36})
        table.insert(parts.image, {id = "lnb-a", src = 6, x = notesInfo.acPosX, y = notesInfo.lnbPosY, w = notesInfo.scWidth, h = 36})
        -- hcn 入力中
        table.insert(parts.image, {id = "hcnb-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcnbPosY, w = notesInfo.whiteWidth, h = 18})
        table.insert(parts.image, {id = "hcnb-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcnbPosY, w = notesInfo.blueWidth, h = 18})
        table.insert(parts.image, {id = "hcnb-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcnbPosY, w = notesInfo.scWidth, h = 18})
        table.insert(parts.image, {id = "hcnb-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcnbPosY, w = notesInfo.scWidth, h = 18})
        -- hcnダメージエフェクト
        table.insert(parts.image, {id = "hcnr-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcnrPosY, w = notesInfo.whiteWidth, h = 18})
        table.insert(parts.image, {id = "hcnr-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcnrPosY, w = notesInfo.blueWidth, h = 18})
        table.insert(parts.image, {id = "hcnr-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcnrPosY, w = notesInfo.scWidth, h = 18})
        table.insert(parts.image, {id = "hcnr-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcnrPosY, w = notesInfo.scWidth, h = 18})
        -- hcn 途中から押したとき
        table.insert(parts.image, {id = "hcnd-w", src = 6, x = notesInfo.whitePosX, y = notesInfo.hcndPosY, w = notesInfo.whiteWidth, h = 18})
        table.insert(parts.image, {id = "hcnd-b", src = 6, x = notesInfo.bluePosX, y = notesInfo.hcndPosY, w = notesInfo.blueWidth, h = 18})
        table.insert(parts.image, {id = "hcnd-s", src = 6, x = notesInfo.scPosX, y = notesInfo.hcndPosY, w = notesInfo.scWidth, h = 18})
        table.insert(parts.image, {id = "hcnd-a", src = 6, x = notesInfo.acPosX, y = notesInfo.hcndPosY, w = notesInfo.scWidth, h = 18})
    end

    parts.note = {
        id = "notes",
        note = notesProperty.note,
        lnend = notesProperty.lnend,
        lnstart = notesProperty.lnstart,
        lnbody = notesProperty.lnbody,
        lnactive = notesProperty.lnactive,
        hcnend = notesProperty.hcnend,
        hcnstart = notesProperty.hcnstart,
        hcnbody = notesProperty.hcnbody,
        hcnactive = notesProperty.hcnactive,
        hcndamage = notesProperty.hcndamage,
        hcnreactive = notesProperty.hcnreactive,
        mine = notesProperty.mine,
        hidden = {},
        processed = {},
        size = {},	-- ノートの高さを調節（px数で指定）
        dst = notesProperty.dst,
			-- 小節線配置 offset3指定でliftの値を考慮した座標になる
			group = {
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneLeftPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 3, a = notesInfo.barlineBright}
				}},
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneRightPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 3, a = notesInfo.barlineBright}
				}}
			},
			time = {
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneLeftPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 15, r = 100, g = 100, b = 255}
				}},
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneRightPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 15, r = 100, g = 100, b = 255}
				}}
			},
			bpm = {
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneLeftPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 15, r = 100, g = 255, b = 100}
				}},
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneRightPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 15, r = 100, g = 255, b = 100}
				}}
			},
			stop = {
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneLeftPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 15, r = 255, g = 100, b = 100}
				}},
				{id = "section-line", offset = MAIN.OFFSET.LIFT, dst = {
					{x = BASE.laneRightPosX + 3, y = BASE.NOTES_JUDGE_Y, w = 513, h = 15, r = 255, g = 100, b = 100}
				}}
			}
    }

    parts.destination = {
        {id = "notes", offset = MAIN.OFFSET.NOTES_1P}
    }

    return parts
end

return {
	load = load
}