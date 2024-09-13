local M = {};

M.instanceList = {};
M.keepList = {};
M.currentID = 1;

---Make a GameObject
---@param class? string
function M:New(class)
    local obj = { x = 0, y = 0, zIndex = 0, sizeX = 0, sizeY = 0, class = class, keep = false, id = M.currentID };

    local keep = false;

    for key, value in pairs(M.keepList) do
        if (value.class == obj.class) then
            keep = true;
        end
    end

    if (not keep) then
        table.insert(M.instanceList, obj);

        M.currentID = M.currentID + 1;
    end

    --- Remove the instance from table
    function obj:Free()
        for key, value in pairs(M.instanceList) do
            if (obj.id == value.id) then
                table.remove(M.instanceList, key)
            end
        end
        -- table.remove(M.instanceList, obj.id);
    end

    --- Used to make simgle instance
    function obj:Keep()
        obj.keep = true;
        if (obj.keep) then
            table.insert(M.keepList, obj);
        end
    end

    return obj;
end

function M:ObjectInitLoad()
    for key, value in pairs(self.instanceList) do
        if value.Load ~= nil then value.Load() end;
    end
end

function M:ObjectInitUpdate(dt)
    for key, value in pairs(self.instanceList) do
        if value.Update ~= nil then value:Update(dt) end;
    end
end

function M:ObjectInitDraw()
    local drawSequence = self.instanceList;
    table.sort(drawSequence, function(a, b)
    if a.zIndex < b.zIndex then return true end
    if a.zIndex == b.zIndex then return(a.id < b.id) end return false
    end)
    for key, value in pairs(drawSequence) do
        if value.Draw ~= nil then value.Draw() end;
    end
end

---Find an instance by name
---@param name string
---@return table? instance
function M:Find(name)
    for key, value in pairs(M.instanceList) do
        if (value.class == name) then
            return value
        end
    end
    return nil
end

return M;
