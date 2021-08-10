local up = peripheral.wrap("right")

local width, height = up.getSize()

local FILE_NAME = "/computercraft/test.ntxt"

local COLOR_CODES = {
    "0" = 1,
    "1" = 2,
    "2" = 4,
    "3" = 8,
    "4" = 16,
    "5" = 32,
    "6" = 64,
    "7" = 128,
    "8" = 256,
    "9" = 512,
    "A" = 1024,
    "B" = 2048,
    "C" = 4096,
    "D" = 8192,
    "E" = 16384,
    "F" = 32768,
}

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
        print(text.i)
    end
end

up.clear()
up.setCursorPos(1,1)

local file = readFile(fs.open(FILE_NAME, "r"))

for i = 1, #file do
    printLine(up, file.i)
end

splitOnNumber("Hello World!", 2)