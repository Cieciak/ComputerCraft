local tArgs = {...}

local option = tArgs[1]
local path_to_files = tArgs[2]
local VESRION = "v0.6"

local function download(name, owner, repo)
    local pkg_name = name
    local repository = "ComputerCraft" or repo
    local owner = "Cieciak" or owner

    shell.run("/git", owner, repository, ".", name)
    local path = "/downloads/" .. repository .. "/" .. pkg_name
    print("Downloaded to: " .. path)
    return path
end

local function install(path)
    local cfg_path = fs.combine(path, "cfg")
    if cfg_path then
        local cfg_file = fs.open(cfg_path, "r")
        local pkg_name = cfg_file.readLine()
        local pkg_path = fs.combine("/pkgs", pkg_name)

        -- If all OK copy files
        fs.copy(path, pkg_path)

        -- Show copied files
        local copied_files = fs.list(pkg_path)
        for index = 1, #copied_files do
            print("Copied " .. copied_files[index])
        end
    end
end

local function get(name, owner, repo)
    local path = download(name, owner, repo)
    install(path)
end

local function bulid()
    if fs.isDir("/pkgs") then print("pkgs already exist")
    else fs.makeDir("/pkgs")
    end
end

local function parse_cfg_file(path)
    local cfg_file = fs.open(path, "r")
    local config = cfg_file.readAll()

    print(config)
end

local function list()
   local packages =  fs.list("/pkgs")
   for index = 1, #packages do
        print(packages[index])
   end 
end

if option == "build" then
    -- Check for /pkgs
    if fs.isDir("/pkgs") then print("/pkgs already exist")
    else fs.makeDir("/pkgs")
    end

elseif option == "install" then install(tArgs[2])

elseif option == "clean" then fs.delete(path_to_files)

elseif option == "uninstall" then fs.delete(fs.combine("/pkgs", path_to_files))
elseif option == "selfup" then
    -- Save the old manager version
    fs.delete("/pkg.lua.old")
    fs.move("/pkg.lua", "/pkg.lua.old")

    -- Update from local version
    if path_to_files == "local" then
        fs.move(tArgs[3], "/pkg.lua")
    -- Update from the internet
    else
        shell.run("git", "Cieciak", "ComputerCraft", ".", "pkg-manager")
        fs.move("/downloads/ComputerCraft/pkg-manager/pkg.lua", "/pkg.lua")
    end

elseif option == "help" then
    print("pkg build - Will make all the folders")
    print("pkg install - Will instal the package")
    print("pkg clean - WiLl delete all package files in a folder")
    print("pkg uninstall - Will uninstall the package")
    print("pkg selfup - Will update pkm")
    print("pkg download - Will download a package")
    print("pkg get - Will download and install package")

elseif option == "download" then download(tArgs[2], tArgs[3], tArgs[4])
elseif option == "get" then get(tArgs[2], tArgs[3], tArgs[4])
elseif option == "list" then list()
elseif option == "test" then parse_cfg_file("/pkgs/test/cfg")
else 
    print("Cieciak Package Manager\nVersion: " .. VESRION)
end