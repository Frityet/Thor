local thunderstore  = require("thunderstore")
local tablex        = require("pl.tablex")

---@type Action
local export = {}

function export.configure_command(cmd)
---@diagnostic disable-next-line: param-type-mismatch
    cmd:argument {
        name = "scope",
        choices = {
            "database",
            "packages"
        },
        default = "database"
    }

---@diagnostic disable-next-line: param-type-mismatch
    cmd:option {
        name = "-c --community",
        args = "+",
        choices = tablex.keys(thunderstore.communities)
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
