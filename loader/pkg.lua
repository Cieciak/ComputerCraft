local tArgs = {...}

local option = tArgs[1]
local path_to_files = tArgs[2]

if option == "build" then
    -- Check for /pkgs
    if fs.isDir("/pkgs") then print("/pkgs already exist")
    else fs.makeDir("/pkgs")
    end
elseif option == "install" then
    local cfg_path = fs.combine(path_to_files, 'cfg')
    if cfg_path then
        local cfg_file = fs.open(cfg_path, "r")
        local pkg_name = cfg_file.readLine()
        local pkg_path = fs.combine("/pkgs", pkg_name)

        fs.copy(path_to_files, pkg_path)

        local copied_files = fs.list(pkg_path)
        for name in pairs(copied_files) do
            print("Copied ".. name)
        end
    else error("There is no package")
    end
end