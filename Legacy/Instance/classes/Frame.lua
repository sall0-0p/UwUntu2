local Frame = {}

local Basalt = UwU:GetService("Basalt")

local UDim2 = require(".UwUntu.Library.UDim2")

local function get(obj, property)
    local origin = obj.Origin
    
    if property == "Size" then
       return UDim2.fromOffset(origin:getSize())
    elseif property == "Position" then
        return UDim2.fromOffset(origin:getPosition())
    else
        error("[ERROR] Property " .. property .. "is not a valid member of " .. obj.Name)
    end
end

local function set(obj, property, value)
    local origin = obj.Origin
    
    if property == "Size" then
        origin:setSize(value:unpack())
    elseif property == "Position" then
        origin:setPosition(value:unpack())
    elseif property == "Color" then
        origin:setBackground(value)
    else
        error("[ERROR] Property " .. property .. "is not a valid member of " .. obj.Name)
    end
end

function Frame.new(parent)
    local frame = {}

    local origin
    if parent.Origin then
        origin = parent.Origin:addFrame()
    else
        origin = parent:addFrame()
    end

    frame.Name = "Frame"
    frame.ID = math.randomseed(os.time() * (math.random(1, 1000) / 10))
    frame.Size = UDim2.fromOffset(5, 5)
    frame.Position = UDim2.fromOffset(0, 0)
    frame.Origin = origin

    frame.Color = colors.white
    frame.Visible = true

    frame.isFocused = false

    origin:setSize(frame.Size:unpack())
    origin:setPosition(frame.Position:unpack())

    origin:setBackground(frame.Color)

    setmetatable(frame, Frame)

    return frame
end

get("Test")

Frame.__index = get
Frame.__newindex = set

return Frame