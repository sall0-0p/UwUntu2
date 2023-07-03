----
--
local basalt = UwU:GetService("Basalt")

local DatastoreService = {}

local DatastoreFolder = "/UwUntu/System/Datastore"

local function getData(datastoreName)
    local path = DatastoreFolder .. "/" .. datastoreName .. ".data"
    if not fs.exists(path) then
        return {}
    end

    local file = fs.open(path, "r")
    local dataInString = file.readAll()
    file.close()

    if dataInString == "" then
        return {}
    end

    local data
    local success, errorMSG = pcall(function() 
        data = textutils.unserialise(dataInString)
    end)

    if success then
        return data
    else
        basalt.debug(errorMSG)
        print(errorMSG)
    end
end

local function setData(datastoreName, data)
    local path = DatastoreFolder .. "/" .. datastoreName .. ".data"
    local dataToSave
    local success, errorMSG = pcall(function() 
        dataToSave = textutils.serialise(data)
    end)

    if not success then
        basalt.debug(errorMSG)
        print(errorMSG)
    end

    local file = fs.open(path, "w")
    file.write(dataToSave)
    file.close()
end

function DatastoreService:GetDatastores()
    local result = {}

    local Datastores = fs.list(DatastoreFolder)

    for _, ds in pairs(Datastores) do
        result[#result+1] = string.gsub(ds, ".data", "")
    end

    return result
end

function DatastoreService:GetDatastore(name)
    assert(name, "Name has to be defined!")
    -----
    local Datastore = {}
    Datastore.Name = name

    if fs.find(DatastoreFolder .. "/" .. name .. ".data") then
        Datastore.Keys = getData(name)
    else
        Datastore.Keys = {}
    end

    function Datastore:IfExists(key)
        for id, _ in pairs(self.Keys) do
            if key == id then
                return true
            end
        end

        return false
    end

    function Datastore:GetKeys()
        self.Keys = getData(self.Name)
        local result = {}

        for id, value in pairs(self.Keys) do
            result[#result+1] = id
        end

        return result
    end

    function Datastore:GetAsync(key)
        assert(key, "Key has to be defined!")
        -----
        self.Keys = getData(self.Name)

        return self.Keys[key]
    end

    function Datastore:SetAsync(key, data)
        assert(key, "Key has to be defined!")
        assert(data, "Data to save has to be defined!")
        -----
        self.Keys = getData(self.Name)

        self.Keys[key] = data

        setData(self.Name, self.Keys)
    end

    function Datastore:RemoveAsync(key)
        assert(key, "Key has to be defined!")
        -----
        self.Keys = getData(self.Name)

        self.Keys[key] = nil

        setData(self.Name, self.Keys)
    end

    function Datastore:UpdateAsync(key, func)
        assert(key, "Key has to be defined!")
        assert(func, "Updating function has to be defined!")
        -----
        Datastore.Keys = getData(self.Name)

        Datastore.Keys[key] = func(Datastore.Keys[key])

        setData(self.Name, Datastore.Keys)
    end
    
    return Datastore
end

return DatastoreService