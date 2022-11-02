
Redstone_IO_Map = {
    mapping = {},
}

function Redstone_IO_Map:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.mapping = {}
    return o
end

function Redstone_IO_Map:bind(name, wire_color)
    self.mapping[name] = wire_color
end

Redstone_IO_Interface = {
    io_map = nil,
    state = 0,
    side = nil,
}

function Redstone_IO_Interface:new(io_map, side)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.io_map = io_map
    self.state = 0
    self.side = side
    return o
end

function Redstone_IO_Interface:set(name, flag)
    local color = self.io_map[name]
    local hex_color = colors[color]

    if flag then
        self.state = bit.bor(self.state, hex_color)
    else
        self.state = bit.bnor(self.state, hex_color)
    end
end

function Redstone_IO_Interface:refresh()
    redstone.setBundledOutput(self.side, self.state)
end