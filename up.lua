local up = peripheral.wrap("top")

local width, height = up.getSize()

local function wrapLine(monitor)
    local width, _ = monitor.getSize()
    local x, y = monitor.getCursorPos()
    if x >= width then
        monitor.setCursorPos(1, y + 1)
    end
end

up.clear()
up.setCursorPos(1,1)

local j = 1
for i = 1, 16 do
    up.setBackgroundColor(j)
    up.write(" ")
    j = j * 2
    wrapLine(up)
end