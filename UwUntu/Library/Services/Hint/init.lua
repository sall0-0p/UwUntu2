local DesktopUtils = {}
----
local basalt = UwU:GetService("Basalt")
local mainFrame = UwU.mainFrame

local function CalculateHintPosition(object, text)
    local rw, rh = term.getSize()
    local ox, oy = object:getAbsolutePosition()
    local ow, oh = object:getSize()
    local len = string.len(text)

    if rw - ox < len then
        return ox - len, oy + oh
    end

    if oy + oh > rh then
        return ox, oy-1
    end

    if oy + oh > rh and rw - ox < len then
        return ox - len, oy + oh
    end

    return ox, oy + oh
end

function DesktopUtils:addHint(object, text)
    assert(object, "Object has to be specified")
    assert(text, "Text has to be specified")

    if not UwU.IsEmulator then
        return
    end

    basalt.setMouseMoveThrottle(50)

    local rw, rh = term.getSize()
    local ow, oh = object:getSize()
    local ox, oy = object:getAbsolutePosition()
    local len = string.len(text)
    
    local hint = mainFrame:addLabel()
        :setPosition("parent.w+1", "parent.w+1")
        :setSize(len, 1)
        :setVisible(false)

        :setBackground(colors.black)
        :setForeground(colors.white)
        :setZIndex(20)

        :setText(text)

    --bad thing
    local badFrame = mainFrame:addFrame()
        :setSize(ow + 30, oh + 30)
        :setPosition("parent.w+1", "parent.h+1")

        :setBackground(false)
        :setZIndex(object:getZIndex() - 1)

    object:onHover(function()
        hint:setPosition(CalculateHintPosition(object, text))
        hint:setVisible(true)

        badFrame:setPosition(ox - 15, oy - 15)

        badFrame:onHover(function() 
            hint:setPosition("parent.w+1", "parent.h+1")
            hint:setVisible(false)

            badFrame:setPosition("parent.w+1", "parent.h+1")
        end)
    end)
end

----
return DesktopUtils