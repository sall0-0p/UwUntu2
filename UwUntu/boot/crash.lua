local basalt = UwU:GetService("Basalt")

-- local crashLabelText = [[
-- Oops! Seems that UwUntu crashed. What a bad thing!
-- Please, restart your PC, and if crash continues, contact developers.

-- You can use Discord to do so :>
--     [link will be here some day]
-- ]]

local function Crash(errorMsg)
    local mainFrame = basalt.createFrame()

    mainFrame:setBackground(colors.lightGray)

    mainFrame:addLabel()
        :setBackground(false)
        :setForeground(colors.black)
        :setText(":( UWUNTU CRASHED")
        :setFontSize(2)
        :setPosition(5, 5)

    -- local label = mainFrame:addLabel()
    --     :setBackground(colors.lightGray)
    --     :setForeground(colors.black)
    --     :setText(crashLabelText) 
    --     :setTextAlign("left")

    --     :setPosition(7, 9)
    --     :setSize("parent.w-14", 10)

    local background = mainFrame:addFrame()
        :setBackground(colors.gray)

        :setSize("parent.w-14", "parent.h-13")
        :setPosition(7, 9)
    
        background:addLabel()
            :setText(errorMsg)
            
            :setBackground(false)
            :setForeground(colors.white)

            :setSize("parent.w-2", "parent.h-2")
            :setPosition(2, 2)

        

    basalt.autoUpdate()
end

return Crash