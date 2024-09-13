local M = {}

local utility = require("Lua.utility")
local GameCont = require("Objects.GameCont")

M.name = ""
M.gender = ""
M.race = ""
M.class = ""

M.itemIndex = 1

M.raceList = { "Human", "Dwarf", "Elf", "Orc", "Kobold" }

M.classList = { "Warrior", "Berserker", "Ranger", "Rogue", "Wizard", "Katana", "Monk" }

M.questions = { "name", "gender", "race", "class" }

M.sequence = 1

M.input = ""

function M:Load()
end

function M:Init()
    M.input = ""
end

function love.textinput(text)
    if string.len(M.input) < 12 then
        M.input = M.input .. text
    end
end

function M:Update(dt)
    -- local gameCont = utility.gameObject:Find("GameCont") or {}
    -- print(gameCont.name)
    if love.keyboard.wasPressed("backspace") then
        M.input = string.sub(M.input, 1, string.len(M.input) - 1)
    end

    if love.keyboard.wasPressed("return") then
        if M.sequence == 1 then
            M.name = M.input
        end
        if M.sequence == 2 then
            M.gender = M.input
        end
        if M.sequence == 3 then
            M.race = M.raceList[M.itemIndex]
        end
        if M.sequence == 4 then
            M.class = M.classList[M.itemIndex]
            local gameCont = utility.gameObject:Find("GameCont") or GameCont:New()
            gameCont.name = M.name
            gameCont.gender = M.gender
            gameCont.race = M.race
            gameCont.playerClass = M.class
            utility.scene:SceneChange("game")
        end
        M.sequence = M.sequence + 1
        M.itemIndex = 1
        M.input = ""
    end

    if love.keyboard.wasPressed("escape") then
        M.sequence = M.sequence - 1
        M.itemIndex = 1
        M.input = ""
    end

    M.itemIndex = M.itemIndex + (love.keyboard.wasPressed("down") and 1 or 0) - (love.keyboard.wasPressed("up") and 1 or 0)
    M.itemIndex = math.max(math.min(M.itemIndex, table.maxn(M.sequence == 3 and M.raceList or M.classList)), 1)
end

function M:Draw()
    -- Background
    love.graphics.draw(utility.resource.background1, 0, 0)
    love.graphics.print("What's your " .. M.questions[M.sequence] .. " today?", 0, 0)
    if M.sequence <= 2 then
        love.graphics.print(M.input, 0, 30)
    end
    if M.sequence == 3 then
        for index, value in ipairs(M.raceList) do
            love.graphics.print((M.itemIndex == index and ">" or "") .. value, 0, index*30)
        end
    end

    if M.sequence == 4 then
        for index, value in ipairs(M.classList) do
            love.graphics.print((M.itemIndex == index and ">" or "") .. value, 0, index*30)
        end
    end
end

return M
