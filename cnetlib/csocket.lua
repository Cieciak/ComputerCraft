CSocket = {
    port = 0,
    response = 0,
    modem = nil,
    opened = false,
    tx = false,
    rx = false
}

function CSocket:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    local modem = peripheral.find("modem")
    if modem then
        o.modem = modem
    end
    return o
end

function CSocket:bind(port,resp, tx, rx)
    self.port = port
    self.response = resp
    self.tx = tx
    self.rx = rx
end

function CSocket:send(msg)
    if self.tx then
        self.modem.transmit(
            self.port,
            self.response,
            msg
        )
    else error("This socket can't send data")
    end
end

function CSocket:open()
    self.modem.open(self.port)
    self.opened = true
end

function CSocket:recieve()
    if not self.opened then
        error("Socket is not open")
    end

    while true do
        local event, side, port, resPort, msg, dist = os.pullEvent("modem_message")
        if port == self.port then
            return event, side, port, resPort, msg, dist
        else
            os.queueEvent(event, side, port, resPort, msg, dist)
        end
    end
end

function CSocket:cleanRecv()
    local _, _, port, resPort, msg = self:recieve()
    return msg, port, resPort
end