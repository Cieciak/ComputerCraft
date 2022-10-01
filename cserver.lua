require("csocket")

CServer = {
    socket = nil,
    sender_coroutine = nil,
    reciver_coroutine = nil,
    name = "",
}

local function sender()
    while true do
        print("Waiting for event")
    end
end

function CServer:new(port, recv, name)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    local s = CSocket.new(nil)
    o.socket = s
    o.name = name
    o.socket:bind(port, recv, true, true)
    return o
end

function CServer:start()
    self.sender_coroutine = coroutine.create(sender)
    coroutine.resume(self.sender_coroutine)
end