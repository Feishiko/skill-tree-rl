if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local utility = require("Lua.utility")

utility.scene:SceneCreate("init", "Scenes.init")
utility.scene:SceneCreate("menu", "Scenes.menu")
utility.scene:SceneCreate("game", "Scenes.game")
utility.scene:SceneCreate("role", "Scenes.role")

utility.scene:SceneChange("init")
utility.scene:SceneInit(800, 608, "Skill Tree RL", 1)
