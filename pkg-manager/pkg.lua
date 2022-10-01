local tArgs = {...}

local option = tArgs[1]
local path_to_files = tArgs[2]
local VESRION = "v0.3"

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
        for index = 1, #copied_files do
            print("Copied ".. copied_files[index])
        end
    else error("There is no package")
    end

elseif option == "clean" then fs.delete(path_to_files)

elseif option == "uninstall" then fs.delete(fs.combine("/pkgs", path_to_files))

elseif option == "selfup" then
    -- Save the old manager version
    fs.delete("/pkg.lua.old")
    fs.move("/pkg.lua /pkg.lua.old")

    -- Update from local version
    if path_to_files == "local" then
        fs.move(tArgs[3], "/pkg.lua")
    -- Update from the internet
    else
        shell.run("git", "Cieciak", "ComputerCraft", ".", "pkg-manager")
        fs.move("/downloads/ComputerCraft/pkg_manager/pkg.lua .")
    end
end