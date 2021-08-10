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
    local i = 1
    local lines = {}
    repeat
        local line = file.readLine()
        lines[i] = line
        i = i + 1
    until line
    return lines
end

up.clear()
up.setCursorPos(1,1)

local file = readFile(fs.open(FILE_NAME, "r"))

for i = 1, #file do
    print(file[i])
end