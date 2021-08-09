local up = peripheral.wrap("top")

local width, height = up.getSize()


up.clear()
up.setCursorPos(1,1)

for i = 0, width do
    up.setBacgroundColor(i)
    up.wirte(" ")
end