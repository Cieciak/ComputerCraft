local up = peripheral.wrap("top")

local width, height = up.getSize()

up.write(width..height)