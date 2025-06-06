local modem = peripheral.find("modem")
local modemName = peripheral.getName(modem)
rednet.open(modemName)

rednet.host("auth", "authServer")  
local users = {
    ["antonio"] = "methlabcorporation",
    ["chris"] = "shadowwizardmoneygang"
}


while true do
    local senderID, message, protocol = rednet.receive("auth") --recieve credentials
    
    local passFromDatabase = users[message.username]

    if passFromDatabase and passFromDatabase == message.password then
         rednet.send(senderID, "AUTH_OK", "auth")
    else 
         rednet.send(senderID, "AUTH_FAIL", "auth")
    end
end