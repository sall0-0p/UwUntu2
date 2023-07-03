local basalt = UwU:GetService("Basalt")
local mainFrame = UwU.mainFrame

local desktop = mainFrame:addFrame()
    :setSize("parent.w", "parent.h")
    :setZIndex(0)
    :setBackground(colors.black)

local desktopImage = desktop:addImage()
    :setSize("parent.w", "parent.h")

local function UpdateWallpaper(image)
    if type(image) == "number" then
        desktopImage:setVisible(false)
        desktop:setBackground(image)
    elseif type(image) == "string" then
        desktopImage:setVisible(true)
        desktopImage:loadImage(image)
    elseif type(image) == "table" then
        desktopImage:setVisible(true)
        desktopImage:setImage(image)
    end
end

basalt.onEvent(function(event, wallpaper) 
    if event == UwU:GetEvent("LoadWallpaper") then
        UpdateWallpaper(wallpaper)
    end
end)

UpdateWallpaper(colors.cyan)
UwU.Frames.Desktop = desktop