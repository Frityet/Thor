local thunderstore = require("thunderstore")
local common       = require("common")

---@type Action
local export = {}

function export.configure_command(cmd)
    cmd:argument {
        name = "community",
        choices = common.getkeys(thunderstore.communities)
    }

    cmd:argument {
        name = "package",
    }
end

function export.on_run(args)
    print(thunderstore.communities[args["community"]].packages[args["package"]])
end

return export
