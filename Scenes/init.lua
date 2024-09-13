local M = {}

local utility = require("Lua.utility")
local gameCont = require("Objects.GameCont")

function M:Load()
end

function M:Init()
    gameCont:New()
end

function M:Update(dt)
    utility.scene:SceneChange("menu")
end

function M:Draw()
end

return M