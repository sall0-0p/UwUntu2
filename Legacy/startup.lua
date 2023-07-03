local Instance = require(".UwUntu.Library.Instance")
local Basalt = UwU:GetService("Basalt")
local UDim2 = require(".UwUntu.Library.UDim2")

local mainFrame = Basalt.createFrame()

-- local Frame1 = Instance.new("Frame", mainFrame)

-- Frame1.Size = UDim2.new(0, 40, 0, 20)
-- Frame1.Position = UDim2.new(0, 0, 0, 0)

local Frame2 = Instance.new("Frame", mainFrame)

Frame2.Size = UDim2.new(0, 30, 0, 20)
Frame2.Position = UDim2.new(0, 10, 0, 5)

-- Basalt.debug(Frame2.Position.X.Offset, Frame2.Position.Y.Offset)
-- Basalt.debug(Frame2.Size)

Frame2.Color = colors.black

Basalt.autoUpdate()
