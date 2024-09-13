local M = {}

M.fontMain = love.graphics.newFont("Fonts/iosevka-n-term-bold.ttf", 22)
M.fontMain:setFilter("linear", "linear")
M.background1 = love.graphics.newImage("Sprites/back1.png")
M.mainMus = love.audio.newSource("Audio/mainMus.ogg", "stream")
M.mainMus:setLooping(true)

return M