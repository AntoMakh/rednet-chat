local url = "https://raw.githubusercontent.com/AntoMakh/rednet-chat/refs/heads/main/main.lua"
local localFile = "main.lua"

local tmpFile = "__tmp_update.lua"
if fs.exists(tmpFile) then
    fs.delete(tmpFile)
end

shell.run("wget", url, tmpFile)

local function readFile(path)
    if not fs.exists(path) then
        return ""
    end
    
    local f = fs.open(path, "r")
    local content = f.readAll()
    f.close()
    return content
end

local current = readFile(localFile)
local latest = readFile(tmpFile)

if current ~= latest then
    print("Updating " .. localFile .. "...")
    fs.delete(localFile)
    fs.move(tmpFile, localFile)
    print("Update complete.")
else
    fs.delete(tmpFile)
    print(localFile .. " is already up to date.")
end