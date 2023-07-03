local basalt = UwU:GetService("Basalt")
local DatastoreService = UwU:GetService("DatastoreService")
local Cache = UwU:GetService("Cache")
local Hint = UwU:GetService("Hint")
local mainFrame = UwU.mainFrame

local RunningApps = Cache:GetStorage("RunningApps")
local PinnedApps = DatastoreService:GetDatastore("PinnedApps")

local lastUpdateTime = os.clock()
local cooldownDuration = 0.05

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

    -- small debounce, becouse AppsContainer:removeChildren() cant perform that fast :(
    if os.clock() - lastUpdateTime < cooldownDuration then
        return 
    end
    lastUpdateTime = os.clock()

    Handler.AppManager.PinnedApps = PinnedApps:GetKeys()
    Handler.AppManager.RunningApps = RunningApps:GetKeys()
    AppsContainer:removeChildren()

    for key, pinnedApp in ipairs(Handler.AppManager.PinnedApps) do
        for key, runningApp in pairs(Handler.AppManager.RunningApps) do
            if pinnedApp == runningApp then
                Handler.AppManager.PinnedApps[key] = nil
            end
        end
    end

    for index, app in pairs(Handler.AppManager.PinnedApps) do
        local props = PinnedApps:GetAsync(app)
        local item = AppsContainer:addFrame()
            :setBackground(colors.black)
            :setSize(3, 2)

            :loadLayout("/UwUntu/Library/Modules/Toolbar/layouts/app.xml", props)
    end

    local spacing = AppsContainer:addPane()
        :setBackground(false, "\127", colors.lightGray)
        :setSize(1, "parent.h")

    for index, app in pairs(Handler.AppManager.RunningApps) do
        local props = RunningApps:GetAsync(app)
        local item = AppsContainer:addFrame()
            :setBackground(colors.black)
            :setSize(3, 2)

            :loadLayout("/UwUntu/Library/Modules/Toolbar/layouts/app.xml", props)

        Hint:addHint(item, props.DisplayName)
    end
end

----
-- 

basalt.onEvent(function(event) 
    if event == UwU:GetEvent("UpdateToolbar") then
        Handler.AppManager:Update()
    end
end)

return Handler