local thunderstore = require("thunderstore")

---@type Action
local export = {}

function export.configure_command(parser)
    
end

function export.on_run(arg)
    print("\x1b[33mUpdating repository...\x1b[0m")
    thunderstore.fetch_all()
    print("\x1b[32mDone\x1B[0m")
end

return export
