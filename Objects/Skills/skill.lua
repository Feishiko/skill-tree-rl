local M = {}
local utility = require("Lua.utility")
function M:New()
    local o = utility.gameObject:New("Skill")

    o.name = ""
    o.description = ""
    o.cost = ""

    function o:Load()
    end

    function o:Update(dt)
    end

    function o:Draw()
    end
    ---comment
    ---@param table 1 -> str | 2 -> def | 3 -> tou | 4 -> mAtk | 5 -> mDef
    function o:Active(table)
       
    end

    return o
end
return M