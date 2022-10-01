local option, path_to_files = {...}

if option == "build" then
    -- Check for /pkgs
    if fs.isDir("/pkgs") then print("/pkgs already exist")
    else fs.makeDir("/pkgs")
    end
elseif option == "install" then
    local cfg_path = fs.combine(path_to_files, 'cfg')
    print(cfg_path)
    if cfg_path then
        local cfg_file = fs.open(cfg_path, "r")
        local pkg_name = cfg_file.readLine()
        print(pkg_name)
    else error("There is no package")
    end
end