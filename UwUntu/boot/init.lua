local Desktop = "/UwUntu/System/Desktop.lua"

shell.run("/UwUntu/boot/uwu.lua")
local crash = require(".UwUntu.boot.crash")

---- Running everything!

---- Clearing Cache!
local cache = "/UwUntu/System/.temp/.cache"
local cachedFiles = fs.list(cache)

for _, file in pairs(cachedFiles) do
    fs.delete(cache .. "/" .. file)
end

local success, errorMSG = pcall(function()
    shell.run(Desktop)
end)

---- Error Handling!
if not success then
    crash(errorMSG)
end

---- Mouse Move
