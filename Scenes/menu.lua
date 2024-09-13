local M = {}

local utility = require("Lua.utility")

M.menuList = { "New Game", "Continue", "Toggle Shader", "Exit" }
M.menuIndex = 1
M.isShader = true

function M:Load()
end

function M:Init()
    utility.resource.mainMus:play()
end

function M:Update(dt)
    M.menuIndex = M.menuIndex + (love.keyboard.wasPressed("down") and 1 or 0) -
    (love.keyboard.wasPressed("up") and 1 or 0)
    M.menuIndex = math.max(math.min(M.menuIndex, table.maxn(M.menuList)), 1)

    if love.keyboard.wasPressed("return") then
        if M.menuIndex == 1 then
            utility.scene:SceneChange("role")
        end
        if M.menuIndex == 3 then
            M.isShader = not M.isShader
        end
        if M.menuIndex == 4 then
            love.window.close()
        end
    end
end

function M:Draw()
    local pixelcode = [[
        uniform float window_size;

        vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
        {
            vec4 texcolor = Texel(tex, texture_coords);
            texcolor.rgb *= mod(texture_coords.y*window_size, 2.);
            return texcolor/1.1;
        }
        ]]

    local vertexcode = [[
        vec4 position( mat4 transform_projection, vec4 vertex_position )
        {
            return transform_projection * vertex_position;
        }
        ]]

    local shader = love.graphics.newShader(pixelcode, vertexcode)
    shader:send("window_size", math.floor(DrawEvent.currentHeight))
    love.graphics.setShader(shader)
    if not M.isShader then
        love.graphics.setShader()
    end
    -- Background
    love.graphics.draw(utility.resource.background1, 0, 0)
    love.graphics.setFont(utility.resource.fontMain)
    love.graphics.print("Skill Tree RL", 0, 5)
    love.graphics.print(
    "-------------------------------------------------------------------------------------------------------", 0, 30)
    for index, value in ipairs(M.menuList) do
        love.graphics.print((M.menuIndex == index and ">" or "") .. value, 0, 30 + index * 30)
    end
    love.graphics.print("A game by Feishiko", 0, DrawEvent.height - 30)
    love.graphics.setColor(1, 1, 1)
end

return M
