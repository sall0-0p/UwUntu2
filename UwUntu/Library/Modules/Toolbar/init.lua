local basalt = UwU:GetService("Basalt")
local DatastoreService = UwU:GetService("DatastoreService")
local Cache = UwU:GetService("Cache")
local Hint = UwU:GetService("Hint")
local mainFrame = UwU.mainFrame

local RunningApps = Cache:GetStorage("RunningApps")
local PinnedApps = DatastoreService:GetDatastore("PinnedApps")

local Handler = {}

-- main layouts of toolbar
local Toolbar = mainFrame:addFrame()
    :setSize("parent.w", 2)
    :setPosition(1, "parent.h-1")

local LaunchButton = Toolbar:addFrame()
    :setSize(3, "parent.h")
    
    :setBackground(colors.lime)

local AppsContainer = Toolbar:addFlexbox()
    :setSize("parent.w*0.8-5", "parent.h")
    :setPosition(5, 1)

    :setBackground(false)

basalt.debug(AppsContainer:getSpacing())
basalt.debug(AppsContainer:getDirection())
basalt.debug(AppsContainer:getJustifyContent())
basalt.debug(AppsContainer:getWrap())

local MiscContainer = Toolbar:addFrame()
    :setSize("parent.w*0.2", "parent.h")
    :setPosition("parent.w*0.8+1", 1)

    :setBackground(colors.blue)

-- tables and api structure
Handler.Containers = {}

Handler.Containers.Launch = LaunchButton
Handler.Containers.Apps = AppsContainer
Handler.Containers.Misc = MiscContainer

Handler.AppManager = {}
Handler.MiscManager = {}

Handler.AppManager.Children = {}
Handler.AppManager.RunningApps = {}
Handler.AppManager.PinnedApps = {}

----
-- App manager is responsible for showing apps

function Handler.AppManager:Update()

    -- getting keys
    Handler.AppManager.PinnedApps = PinnedApps:GetKeys()
    Handler.AppManager.RunningApps = RunningApps:GetKeys()
    AppsContainer:removeChildren()

    -- adding pinned apps to list
    for index, app in pairs(Handler.AppManager.PinnedApps) do
        basalt.debug(index, app)
        local props = PinnedApps:GetAsync(app)
        local item = AppsContainer:addFrame()
            :setBackground(colors.black)
            :setSize(3, 2)

            :loadLayout("/UwUntu/Library/Modules/Toolbar/layouts/app.xml", props)
    end

    -- adding spacing to list
    local spacing = AppsContainer:addPane()
        :setBackground(false, "\127", colors.lightGray)
        :setSize(1, "parent.h")

    -- adding active apps for list
    for index, app in pairs(Handler.AppManager.RunningApps) do
        basalt.debug(index, app)
        local props = RunningApps:GetAsync(app)
        local item = AppsContainer:addFrame()
            :setBackground(colors.black)
            :setSize(3, 2)

            :loadLayout("/UwUntu/Library/Modules/Toolbar/layouts/app.xml", props)

        Hint:addHint(item, props.DisplayName)
    end

    AppsContainer:updateLayout()
end

----
-- 

basalt.onEvent(function(event) 
    if event == UwU:GetEvent("UpdateToolbar") then
        Handler.AppManager:Update()
    end
end)

return Handler