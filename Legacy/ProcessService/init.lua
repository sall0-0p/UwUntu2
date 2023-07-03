----
--
local basalt = UwU:GetService("Basalt")

local Cache = UwU:GetService("Cache")
local Processes = Cache:GetStorage("Processes")
local ProcessesHere = {}

local ProcessService = {}

----

function ProcessService:AddProcess(name, data, func)
    if Processes:IfExists(name) then
        return "Failed to add process, already running!"
    end

    local Id = math.random(10000000, 99999999)

    Processes:SetAsync(name, {
        Name = name,
        DiplayName = data.Name, 
        App = data.App,

        StartingTime = os.time(),
        Id = Id
    })

    local Process = {
        Name = name,
        DiplayName = data.Name,
        App = data.App,

        StartingTime = os.time(),
        Id = Id
    }

    local Thread = UwU.mainFrame:addThread()
    Thread:start(func)

    Process.Thread = Thread
    
    function Process:Terminate()
        self.Thread:stop()

        ProcessesHere[self.Name] = nil
        Processes:RemoveAsync(self.Name)
    end

    function Process:GetStatus()
        return self.Thread:getStatus()
    end

    ProcessesHere[name] = Process
    return Process
end

function ProcessService:List()
    return ProcessesHere
end

function ProcessService:Terminate(name)
    assert(ProcessesHere[name], "There is no such process running!")

    ProcessesHere[name].Thread:stop()
    ProcessesHere[name] = nil
end

return ProcessService