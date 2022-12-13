local path          = require("pl.path")
local common        = require("common")
local thunderstore  = require("thunderstore")
local file          = require("pl.file")

---@type Action
local export = {}

---@type string
local cwd
function export.configure_command(cmd)
    cmd:argument {
        name = "community",
        choices = common.getkeys(thunderstore.communities)
    }

    cwd = path.currentdir()
    cmd:option {
        name = "--path",
        default = cwd
    }

    cmd:option {
        name = "--name",
        default = path.basename(cwd)
    }
end

function export.on_run(args)
    local mjolnir_dir = path.join(cwd, ".mjolnir")
    if path.exists(mjolnir_dir) then error("Cannot create new project at \""..cwd.."\", project already exists!") end
    path.mkdir(mjolnir_dir)

    
end

return export

