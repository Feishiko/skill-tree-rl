local M = {}
local utility = require("Lua.utility")
function M:New()
    local o = utility.gameObject:New("GameCont")
    o.keep = true

    o.name = "1"
    o.gender = ""
    o.race = ""
    o.playerClass = ""

    function o:Load()
    end

    function o:Update(dt)
    end

    function o:Draw()
    end

    return o
end
return M