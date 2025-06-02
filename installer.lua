-- Simplified installer.lua
local updateId = "PELpGbU2" -- update.lua Pastebin ID

-- installer.lua
if not fs.exists("update.lua") then
    print("Downloading update.lua ...")
    shell.run("pastebin get PELpGbU2 update.lua")
end

print("Running update script ...")
shell.run("update.lua")