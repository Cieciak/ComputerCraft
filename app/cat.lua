local tArgs = {...}

local file = fs.open(tArgs[1], "r")
if file then
    local file_content = file.readAll()
    print(file_content)
else print("This file does not exist")
end