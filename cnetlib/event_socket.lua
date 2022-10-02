require "/pkgs/netlib/csocket"

CEventSocket = {
    socket = nil,
    name = "",
    listen_co = nil
}

local function listen_func(event_socket)
    while true do
        print("Waiting for input!")
        local msg, port, resp = event_socket.socket:cleanRecv()
        print("Next")
        os.queueEvent(event_socket.name, msg, port, resp)
    end
end

function CEventSocket:new(name)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.name = name
    self.socket = CSocket:new()
    self.socket:bind(100, 101, true, true)

    self.listen_co = coroutine.wrap(listen_func)
    self.listen_co(self)
    return o
end