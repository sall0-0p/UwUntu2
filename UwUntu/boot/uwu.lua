_G.UwU = {}

local Services = {
    Basalt = ".UwUntu.Library.Basalt",
    basalt = ".UwUntu.Library.Basalt",
    DatastoreService = ".UwUntu.Library.Services.DatastoreService",
    EncryptionService = ".UWUntu.Library.Services.EncryptionService",
    WindowService = ".UWUntu.Library.Services.WindowService",
    Hint = ".UwUntu.Library.Services.Hint",
    Cache = ".UwUntu.Library.Services.Cache",
}

local Modules = {
    DesktopBG = ".UwUntu.Library.Modules.DesktopBG",
    Toolbar = ".UwUntu.Library.Modules.Toolbar",
}

local Events = {
    UpdateToolbar = "#acU}v]+pwxneT<",
    LoadWallpaper = "nud(!7=1&-+[-wX",
}

function UwU:GetService(name)
    local service = Services[name]
    assert(service, "There are no such service! ("..name..")")

    return require(service)
end

function UwU:GetModule(name)
    local module = Modules[name]
    assert(module, "There are no such module! ("..name..")")

    return require(module)
end

function UwU:GetEvent(name)
    local event = Events[name]

    return event
end

function UwU:RegisterEvent(name)
    
end
-----

if string.find(_HOST, "PC") then
    UwU.IsEmulator = true
else
    UwU.IsEmulator = false
end

-----
local basalt = UwU:GetService("Basalt")

UwU.mainFrame = basalt.createFrame()
-----

UwU.CurrentDesktop = 1
UwU.Frames = {}

UwU.Version = "0.0.1"
UwU.isBeta = true