local plugins = "/UwUntu/System/Desktop/plugins"
local basalt = UwU:GetService("Basalt")

local loadedPlugins = fs.list(plugins)

local mainFrame = UwU.mainFrame

for _, plugin in pairs(loadedPlugins) do
    local plgn = require(".UwUntu.System.Processes.plugins." .. plugin:gsub(".lua", ""))

    plgn(mainFrame)
end

basalt.autoUpdate()