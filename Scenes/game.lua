local M = {}

local utility = require("Lua.utility")
local GameCont = require("Objects.GameCont")
local learner = require("Objects.Skills.Human.learner")

M.name = ""
M.gender = ""
M.race = ""
M.class = ""

M.strength = 5
M.defence = 5
M.toughness = 5
M.mAttack = 5
M.mDefence = 5

M.humanList = { learner:New() }

M.skillList = {}

function M:Load()
end

function M:Init()
end

function M:Update(dt)
    local gameCont = utility.gameObject:Find("GameCont") or GameCont:New()
    M.name = gameCont.name
    M.gender = gameCont.gender
    M.race = gameCont.race
    M.class = gameCont.playerClass
end

function M:Draw()
    -- Background
    love.graphics.draw(utility.resource.background1, 0, 0)
    love.graphics.print("Stats", 0, 0)
    love.graphics.print("Name: " .. M.name, 0, 30)
    love.graphics.print("Gender: " .. M.gender, 0, 60)
    love.graphics.print("Race: " .. M.race, 0, 90)
    love.graphics.print("Class: " .. M.class, 0, 120)
    love.graphics.print("Strength: " .. M.strength, 0, 150)
    love.graphics.print("Defence: " .. M.defence, 0, 180)
    love.graphics.print("Toughness: " .. M.toughness, 0, 210)
    love.graphics.print("M.Attack: " .. M.mAttack, 0, 240)
    love.graphics.print("M.Defence: " .. M.mDefence, 0, 270)
    for i = 0, DrawEvent.height, 10 do
        love.graphics.print(".", 230, i - 10)
    end
end

return M
