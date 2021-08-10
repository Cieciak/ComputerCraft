local up = peripheral.wrap("right")

local width, height = up.getSize()

local FILE_NAME = "/computercraft/test.ntxt"

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
    local i = 0
    local lines = {}
    local line = file.readLine()
    while line do
        lines[i] = line
        line = file.readLine()
    end
    return lines
end

up.clear()
up.setCursorPos(1,1)

local file = fs.open(FILE_NAME, "r")


print(readFile(file))