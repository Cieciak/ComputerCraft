require("csocket")

CServer = {
    socket = nil,
    sender_coroutine = nil,
    reciver_coroutine = nil,
    name = "",
}

function CServer:new(port, recv)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o:bind(port, recv, true, true)
    return o
end

function CServer:start()
    self.sender_coroutine = coroutine.create(CServer:sender)
end

function CServer:sender()
    while true do
        event, msg = os.pullEvent("serversend"..self.name)
        self.socket.send(msg)
    end
end