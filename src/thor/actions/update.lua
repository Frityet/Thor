local thunderstore  = require("thor.thunderstore")
local common        = require("thor.common")

---@type Action
local export = {}

function export.configure_command(cmd)
    cmd:argument {
        name = "scope",
        choices = {
            "database",
            "packages"
        },
        default = "database"
    }
    cmd:option {
        name = "-c --community",
        args = "+",
        choices = common.getkeys(thunderstore.communities)
    }
end

function export.on_run(arg)
    if arg["scope"] == "database" then
        print("\x1b[33mUpdating database...\x1b[0m")
        thunderstore.fetch_all()
        print("\x1b[32mDone\x1B[0m")
    else
        error("Not implemented!")
    end
end

return export