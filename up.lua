local up = peripheral.wrap("right")

local width, height = up.getSize()

local FILE_NAME = "/computercraft/test.ntxt"

local COLOR_CODES = {}
COLOR_CODES["0"] = 1
COLOR_CODES["1"] = 2
COLOR_CODES["2"] = 4
COLOR_CODES["3"] = 8
COLOR_CODES["4"] = 16
COLOR_CODES["5"] = 32
COLOR_CODES["6"] = 64
COLOR_CODES["7"] = 128
COLOR_CODES["8"] = 256
COLOR_CODES["9"] = 512
COLOR_CODES["A"] = 1024
COLOR_CODES["B"] = 2048
COLOR_CODES["C"] = 4096
COLOR_CODES["D"] = 8192
COLOR_CODES["E"] = 16384
COLOR_CODES["F"] = 32768

local function wrapLine(monitor)
    local width, _ = monitor.getSize()
    local x, y = monitor.getCursorPos()
    if x > width then
        monitor.setCursorPos(1, y + 1)
    end
end

local function writeAtPos(monitor, x, y, text)
    monitor.setCursorPos(x, y)
    monitor.write(text)
end

local function readFile(file)
    local i = 1
    local lines = {}
    repeat
        local line = file.readLine()
        lines[i] = line
        i = i + 1
    until not line
    return lines
end

local function printLine(monitor, text)
    local _, y =  monitor.getCursorPos()
    monitor.write(text)
    monitor.setCursorPos(1, y + 1)
end

local function splitOnNumber(text, index)
    for i = 1, #text do
        local char = text:sub(i, i)
        print(char)
    end
end

up.clear()
up.setCursorPos(1,1)

local file = readFile(fs.open(FILE_NAME, "r"))

for i = 1, #file do
    printLine(up, file.i)
end

splitOnNumber("Hello World!", 2)