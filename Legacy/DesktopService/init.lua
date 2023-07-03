local basalt = UwU:GetService("Basalt")
local Cache = UwU:GetService("Cache")
local DatastoreService = UwU:GetService("DatastoreService")
local mainFrame = UwU.mainFrame
----
local Desktops = DatastoreService:GetDatastore("Desktops")
local RunningApps = Cache:GetStorage("Cache")
----
local DesktopService = {}
UwU.CurrentDesktop = 1

local DesktopFrames = {}

---- Utilities

local function serialise()

end

local function unserialise()

end

---- Major functions
function DesktopService:addDesktop()
    
end

function DesktopService:removeDesktop()

end

function DesktopService:getDesktops()

end

function DesktopService:getDesktop()

end

return DesktopService