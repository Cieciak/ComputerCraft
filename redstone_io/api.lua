
COLOR_MAP = {}

COLOR_MAP["white"]     = 0x1
COLOR_MAP["orange"]    = 0x2
COLOR_MAP["magenta"]   = 0x4
COLOR_MAP["lightBlue"] = 0x8
COLOR_MAP["yellow"]    = 0x10
COLOR_MAP["lime"]      = 0x20
COLOR_MAP["pink"]      = 0x40
COLOR_MAP["gray"]      = 0x80
COLOR_MAP["lightGray"] = 0x100
COLOR_MAP["cyan"]      = 0x200
COLOR_MAP["purple"]    = 0x400
COLOR_MAP["blue"]      = 0x800
COLOR_MAP["brown"]     = 0x1000
COLOR_MAP["green"]     = 0x2000
COLOR_MAP["red"]       = 0x4000
COLOR_MAP["black"]     = 0x8000


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
    local hex_color = COLOR_MAP[color]

    if flag then
        self.state = bit.bor(self.state, hex_color)
    else
        self.state = bit.bnor(self.state, hex_color)
    end
end

function Redstone_IO_Interface:refresh()
    redstone.setBundledOutput(self.side, self.state)
end