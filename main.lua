local modem = peripheral.find("modem")
local modemName = peripheral.getName(modem)

rednet.open(modemName)

if rednet.isOpen(modemName) then
    print("RedNet is working!")
end

write("Hello. Are you Harvek (1) or Chris_A_75 (2)?")
local user = tonumber(read())

while user ~= 1 and user ~= 2 do
    write("Hello. Are you Harvek (1) or Chris_A_75 (2)?")
    local user = tonumber(read())
end

local receiverId

if user == 1 then
    receiverId = 8
else
    receiverId = 7
end


local credentials = (receiverId == 7 and "<Chris_A_75> " or "<Harvek_> ")

local function sendLoop()
    while true do
        write(credentials)
        local msg = read()
        
        if msg == "exit" then
            rednet.close(modemName)
            break
        end
        
        local finalMsg = credentials .. msg
        rednet.send(receiverId, finalMsg, "MethLab")
        
    end
end

local function receiveLoop()
    while true do
        local senderId, message, protocol = rednet.receive("MethLab")
        if senderId == receiverId then
            print(message)
            print()
        end
    end
end

parallel.waitForAny(sendLoop, receiveLoop)
