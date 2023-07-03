----
-- Made by _lordBucket

local Instance = {}
local InstanceFolder = ".UwUntu.Library.Instance"
local classes = InstanceFolder .. ".classes"

function Instance.new(class, parent)
    assert(fs.find(classes .. "." .. class), "[ERROR] Class " .. class .." do not exist!")
    local object = require(classes .. "." .. class)

    return object.new(parent)
end

return Instance