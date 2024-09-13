local M = {};
local gameObject = require("Lua.gameObject");

function M:CollisionObject(object, class)
    for key, value in pairs(gameObject.instanceList) do
        if (value.class == class) then
            return M:CollisionAABB(object.x, object.y, object.width, object.height, value.x, value.y, value.width, value.height), value;
        end
    end
end

function M:CollisionPoint(posX, posY, class)
    for key, value in pairs(gameObject.instanceList) do
        if (value.class == class) then
            return M:CollisionAABB(posX, posY, 0, 0, value.x, value.y, value.width, value.height), value;
        end
    end
end

function M:CollisionAABB(pos1X, pos1Y, size1X, size1Y, pos2X, pos2Y, size2X, size2Y)
    local collisionX = pos1X + size1X >= pos2X and pos2X + size2X >= pos1X;
    local collisionY = pos1Y + size1Y >= pos2Y and pos2Y + size2Y >= pos1Y;
    return collisionX and collisionY;
end

return M;