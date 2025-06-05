local modem = peripheral.find("modem")
local modemName = peripheral.getName(modem)

rednet.open(modemName)

if rednet.isOpen(modemName) then
    print("RedNet is working!")
end

local user = ""
local password = ""
while user == "" or password == "" do
    write("Enter username: ")
    user = read()
    write("Enter password: ")
    password = read()
end

local serverID = 9       --change this depending on the server id

local loginCredentials = {
    username = user,
    password = password
}
rednet.send(serverID, credentials, "auth")
--sending the username and pass to the server

local senderID, response, protocol = rednet.receive("auth")
if senderID == serverID and response == "AUTH_OK" then
    print("Login successful")
else
    print("Login failed")
    return --end the program. You can change this to repeat the login prompt instead if you want
end


local receiverId

if user == "antonio" then --this can be changed
    receiverId = 8 --antonio
else if user == "chris" then
    receiverId = 7 --chris
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
        local spacelessMessage = string.gsub(msg, "%s", "") -- this removes all the whitespace characters from the message
        if spacelessMessage ~= "" then -- this shouldnt allow empty messages from being sent
            local finalMsg = credentials .. msg
            rednet.send(receiverId, finalMsg, "MethLab")
        end
    end
end

local function receiveLoop()
    while true do
        local senderId, message, protocol = rednet.receive("MethLab")
        if senderId == receiverId then
            print()
            print(message)
            write(credentials)
        end
    end
end

parallel.waitForAny(sendLoop, receiveLoop)
