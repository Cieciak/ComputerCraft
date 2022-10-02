require "/pkgs/netlib/csocket"

local tArgs = {...}

CEventSocket = {
    name = "",
    listen_co = nil,
    port = 0,
    resp = 0,
    tabID = nil, 
}

function CEventSocket:new(name, port, resp)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.name = name
    self.port = port
    self.resp = resp
    return o
end

function CEventSocket:start()
    local tabID = shell.openTab("/pkgs/netlib/event_socket", self.name, self.port, self.resp)
    self.tabID = tabID
end

local function serve(name, port, resp)
    local server_socket = CSocket:new()
    server_socket:bind(port, resp, true, true)
    while true do
        local msg, port, resp = server_socket:cleanRecv()
        os.queueEvent(name, msg, port, resp)
    end
end

if tArgs[1] == "enableServe" then
    serve(tArgs[2], tArgs[3], tArgs[4])
end