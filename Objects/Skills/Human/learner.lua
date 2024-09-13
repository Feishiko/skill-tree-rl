local M = {}
local utility = require("Lua.utility")
local skill = require("Objects.Skills.skill")
function M:New()
    local o = skill:New()

    o.name = "Learner"
    o.description = "Strength + 1, Defence + 1, Toughness + 1, M.Attack + 1, M.Defence + 1"
    o.cost = 1

    function o:Active(table)
        table[1] = table[1] + 1
        table[2] = table[2] + 1
        table[3] = table[3] + 1
        table[4] = table[4] + 1
        table[5] = table[5] + 1
        return table
    end

    return o
end
return M