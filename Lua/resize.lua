local M = {};

function M.ResizeInit(width, height, windowTitle, size)
    local drawEvent = {};
    drawEvent.width = width;
    drawEvent.height = height;
    drawEvent.currentWidth = width;
    drawEvent.currentHeight = height;
    drawEvent.originRatio = 1.1;
    drawEvent.windowRatio = 1.1;
    love.window.setTitle(windowTitle);
    love.graphics.setDefaultFilter("nearest");
    love.window.setMode(width * size, height * size, { resizable = true })

    -- Canvas
    drawEvent.canvas = love.graphics.newCanvas(width * size, height * size);

    function drawEvent:Update()
        -- local less = math.min(love.graphics.getWidth(), love.graphics.getHeight());
        drawEvent.originRatio = drawEvent.width / drawEvent.height;
        drawEvent.windowRatio = love.graphics.getWidth() / love.graphics.getHeight();
        local less = drawEvent.windowRatio < drawEvent.originRatio and love.graphics.getWidth() or
            love.graphics.getHeight();
        drawEvent.scaleAmount = less / (drawEvent.windowRatio < drawEvent.originRatio and width or height);

        -- Canvas Changes
        if drawEvent.currentWidth ~= love.graphics.getWidth() or drawEvent.currentHeight ~= love.graphics.getHeight() then
            drawEvent.canvas = love.graphics.newCanvas(width * drawEvent.scaleAmount, height * drawEvent.scaleAmount);
            drawEvent.currentWidth = love.graphics.getWidth();
            drawEvent.currentHeight = love.graphics.getHeight();
        end
    end

    function drawEvent:Start()
        love.graphics.setCanvas(self.canvas);
        love.graphics.clear();
    end

    function drawEvent:End()
        love.graphics.setCanvas();
        love.graphics.draw(self.canvas,
            drawEvent.windowRatio >= drawEvent.originRatio and
            (love.graphics.getWidth() - self.scaleAmount * width) / 2 or 0,
            drawEvent.windowRatio < drawEvent.originRatio and
            (love.graphics.getHeight() - self.scaleAmount * height) / 2 or 0, 0, 1, 1);
    end

    return drawEvent;
end

return M;
