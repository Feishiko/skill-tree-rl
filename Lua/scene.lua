local resize = require("Lua.resize");
local gameObject = require("Lua.gameObject");
local M = {};

M.scenes = {};
M.keepScenes = {};
M.currentScene = nil;

---Make a scene
---@param name string
---@param path string
---@return table
function M:SceneCreate(name, path)
    self.scenes[name] = require(path);
    return self.scenes[name];
end

---Change a scene
---@param name string
function M:SceneChange(name)
    -- gameObject.currentID = 1;

    -- KeepObject
    local keepObjects = {};
    for key, value in pairs(gameObject.instanceList) do
        if (value.keep == true) then
            table.insert(keepObjects, value);
        end
    end

    -- KeepScene
    if (self.currentScene ~= nil) then
        if (self.scenes[self.currentScene].keep == true) then
            self.keepScenes[self.currentScene] = gameObject.instanceList;
        end
    end

    gameObject.instanceList = {};

    if (self.scenes[name].Init ~= nil and self.keepScenes[name] == nil) then
        self.scenes[name]:Init();
    end
    if (self.scenes[name].keep == true and self.keepScenes[name]) then
        gameObject.instanceList = self.keepScenes[name];
    end

    -- KeepObject
    for key, value in pairs(keepObjects) do
        table.insert(gameObject.instanceList, value);
    end

    self.currentScene = name;
end

---Init the game
---@param windowWidth integer
---@param windowHeight integer
---@param windowTitle string
---@param windowSize? integer
---@param gameFPS? integer 60
function M:SceneInit(windowWidth, windowHeight, windowTitle, windowSize, gameFPS)
    windowSize = windowSize or 1;
    gameFPS = gameFPS or 60
    function love.load()
        DrawEvent = resize.ResizeInit(windowWidth, windowHeight, windowTitle, windowSize);
        for index, value in pairs(self.scenes) do
            if value.Load ~= nil then value:Load() end;
        end
        gameObject:ObjectInitLoad();
    end

    local totalTime, elapsedTime = 0, 0
    function love.update(dt)
        totalTime = totalTime + dt
        DrawEvent:Update();
        while totalTime - elapsedTime > 1 / gameFPS do
            dt = 1 / gameFPS
            if self.scenes[self.currentScene].Update ~= nil then self.scenes[self.currentScene]:Update(dt) end;
            gameObject:ObjectInitUpdate(dt);
            love.keyboard.updateKeys();
            elapsedTime = elapsedTime + 1 / gameFPS
        end
    end

    function love.draw()
        DrawEvent:Start();
        love.graphics.push();
        love.graphics.scale(DrawEvent.scaleAmount);
        if self.scenes[self.currentScene].Draw ~= nil then self.scenes[self.currentScene]:Draw() end;
        gameObject:ObjectInitDraw();
        love.graphics.pop();
        love.graphics.setColor(1, 1, 1);
        DrawEvent:End();
    end
end

return M;
