local basalt = UwU:GetService("Basalt")
local Toolbar = UwU:GetModule("Toolbar")
local DesktopBG = UwU:GetModule("DesktopBG")

local Window = UwU:GetService("WindowService")

Window.new({
    Name = "Shell",
    DisplayName = "Shell",
    Path = "/UwUntu/Apps/Terminal/Terminal.app",
    Icon = "/UwUntu/Apps/Terminal/icon.bimg",
    Size = {
        X = 51,
        Y = 19,
    }
})
os.sleep(0.05)

Window.new({
    Name = "ASCII",
    DisplayName = "ASCII",
    Path = "/UwUntu/Apps/ASCII/ASCII.app",
    Icon = "/UwUntu/Apps/ASCII/icon.bimg",
    Size = {
        X = 51,
        Y = 19,
    }
})

basalt.autoUpdate()