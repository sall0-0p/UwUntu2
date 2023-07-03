----
-- Why this exists?
-- Cache is same Storage, with only difference. It will get deleted after next system reboot.
-- This is needed for some system apps and files, like handling processes.
-- If you want your data, to be saved for longer time, use CacheService!


local basalt = UwU:GetService("Basalt")

local CacheService = {}

local CacheFolder = "/UwUntu/System/.temp/.cache"

local function getData(storageName)
    local path = CacheFolder .. "/" .. storageName .. ".data"
    if not fs.exists(path) then
        fs.open(path, "w").close()
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

local function setData(storageName, data)
    local path = CacheFolder .. "/" .. storageName .. ".data"
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

function CacheService:GetStorages()
    local result = {}

    local Storages = fs.list(CacheFolder)

    for _, ds in pairs(Storages) do
        result[#result+1] = string.gsub(ds, ".data", "")
    end

    return result
end

function CacheService:GetStorage(name)
    assert(name, "Name has to be defined!")
    -----
    local Storage = {}
    Storage.Name = name

    if fs.find(CacheFolder .. "/" .. name .. ".data") then
        Storage.Keys = getData(name)
    else
        Storage.Keys = {}
    end

    function Storage:GetKeys()
        self.Keys = getData(self.Name)
        local result = {}

        for id, _ in pairs(self.Keys) do
            result[#result+1] = id
        end

        return result
    end

    function Storage:IfExists(key)
        for id, _ in pairs(self.Keys) do
            if key == id then
                return true
            end
        end

        return false
    end

    function Storage:GetAsync(key)
        assert(key, "Key has to be defined!")
        -----
        self.Keys = getData(self.Name)

        return self.Keys[key]
    end

    function Storage:SetAsync(key, data)
        assert(key, "Key has to be defined!")
        assert(data, "Data to save has to be defined!")
        -----
        self.Keys = getData(self.Name)

        self.Keys[key] = data

        setData(self.Name, self.Keys)
    end

    function Storage:RemoveAsync(key)
        assert(key, "Key has to be defined!")
        -----
        self.Keys = getData(self.Name)

        self.Keys[key] = nil

        setData(self.Name, self.Keys)
    end

    function Storage:UpdateAsync(key, func)
        assert(key, "Key has to be defined!")
        assert(func, "Updating function has to be defined!")
        -----
        Storage.Keys = getData(self.Name)

        Storage.Keys[key] = func(Storage.Keys[key])

        setData(self.Name, Storage.Keys)
    end
    
    return Storage
end

return CacheService