local UDim2 = {}
UDim2.__index = UDim2

function UDim2.new(XScale, XOffset, YScale, YOffset)
    local dim = {}
    setmetatable(dim, UDim2)

    dim.X = {
        Scale = XScale or 0,
        Offset = XOffset or 0,
    }
    dim.Y = {
        Scale = YScale or 0,
        Offset = YOffset or 0,
    }



    return dim
end

function UDim2.fromScale(XScale, YScale)
    local dim = {}
    setmetatable(dim, UDim2)

    dim.X = {
        Scale = XScale or 0,
        Offset = 0,
    }
    dim.Y = {
        Scale = YScale or 0,
        Offset = 0,
    }
    
    return dim
end

function UDim2.fromOffset(XOffset, YOffset)
    local dim = {}
    setmetatable(dim, UDim2)

    dim.X = {
        Scale = 0,
        Offset = XOffset or 0,
    }
    dim.Y = {
        Scale = 0,
        Offset = YOffset or 0,
    }

    return dim
end

function UDim2:unpack()
    local AbsoluteX, AbsoluteY = term.getSize()

    return math.floor(AbsoluteX * self.X.Scale + self.X.Offset), math.floor(AbsoluteY * self.Y.Scale + self.Y.Offset)
end

return UDim2
