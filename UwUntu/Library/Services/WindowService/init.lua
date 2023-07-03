local basalt = UwU:GetService("Basalt")
local Cache = UwU:GetService("Cache")
local mainFrame = UwU.mainFrame
local desktop = UwU.Frames.Desktop

local rw, rh = mainFrame:getSize()
----
local RunningApps = Cache:GetStorage("RunningApps")
----
local Window = {}
Window.__index = Window

function Window.new(props)
    local window = {}
    setmetatable(window, Window)
    window.ID = props.Name .. math.random(1, 10000000)

    --- creating window itself

    local WindowFrame = desktop:addMovableFrame()
        :setSize(props.Size.X + 2, props.Size.Y + 2)
        :setPosition(math.random(1, rw-50), math.random(1, rh-18))
        :setBackground(colors.gray)

        local BarLabel = WindowFrame:addLabel("bar")
            :setText(props.DisplayName)

            :setPosition("parent.w/2 - self.w/2", 1)
            :setSize("self.w", 1)

            :setBackground(false)
            :setForeground(colors.lightGray)

        local Buttons = WindowFrame:addFrame("buttons")
            :setSize(6, 1)
            :setPosition("parent.w -5", 1)

            :setBackground(false)
            
            local CloseButton = Buttons:addButton("close")
                :setSize(1, 1)
                :setPosition(5, 1)
                :setText("\136")

                :setForeground(colors.lightGray)
                :onClick(function() window:Close() end)

            local FullscreenButton = Buttons:addButton("full")
                :setSize(1, 1)
                :setPosition(3, 1)
                :setText("\136")

                :setForeground(colors.lightGray)
                :onClick(function() window:ToggleFullscreen() end)

            local HideButton = Buttons:addButton("flip")
                :setSize(1, 1)
                :setPosition(1, 1)
                :setText("\136")

                :setForeground(colors.lightGray)
                :onClick(function() window:ToggleVisibility() end)

        --- events
        WindowFrame:onGetFocus(function() 
            BarLabel:setForeground(colors.white)
            
            CloseButton:setForeground(colors.red)
            FullscreenButton:setForeground(colors.orange)
            HideButton:setForeground(colors.lime)
        end)

        WindowFrame:onLoseFocus(function() 
            BarLabel:setForeground(colors.lightGray)
            
            CloseButton:setForeground(colors.lightGray)
            FullscreenButton:setForeground(colors.lightGray)
            HideButton:setForeground(colors.lightGray)
        end)

        --- program execution & enviroment
        local Enviroment = require(".UwUntu.System.Enviroment")
        Enviroment["UwU"]["WindowID"] = window.ID

        local Program = WindowFrame:addProgram("program")
            :setSize("parent.w-2", "parent.h-2")
            :setPosition(2, 2)
            :setEnviroment(Enviroment)
            :execute(props.Path)

    --- saving and returning data about window
    window.Frame = WindowFrame
    window.Hidden = false

    RunningApps:SetAsync(window.ID, {
        Name = props.Name,
        DisplayName = props.DisplayName,
        Path = props.Path,
        Icon = props.Icon,
        Position = window.Frame:getPosition(),
        Hidden = false
    })

    os.queueEvent(UwU:GetEvent("UpdateToolbar"))

    return window
end

function Window:Close()
    local WindowFrame = self.Frame
    local aw, ah = WindowFrame:getAbsolutePosition()
    local ww, wh = WindowFrame:getSize()

    local rw = aw + ww / 2
    local rh = ah + wh / 2
    
    WindowFrame:remove()
    RunningApps:RemoveAsync(self.ID)
    os.queueEvent(UwU:GetEvent("UpdateToolbar"))
end

function Window:SetName()

end

function Window:ToggleVisibility()
   if self.Hidden then
        self:Show()
   else
        self:Hide()
   end
end

function Window:Hide()
    self.Frame:animatePosition(rw + 1, rh + 1, 0.5)
    self.Hidden = true

    os.queueEvent(UwU:GetEvent("UpdateToolbar"))
end

function Window:Show()
    self.Frame:animatePosition(self.Frame.Position, 0.5)
    self.Hidden = false

    os.queueEvent(UwU:GetEvent("UpdateToolbar"))
end

function Window:ToggleFullscreen()
    basalt.debug("HELLO WORLD FULLSCREEN!")
end

return Window