local thunderstore = require("thunderstore")
local common       = require("common")

---@type Action[]
local actions = {
    create = require("actions.profile.create")
}

---@type Action
local export = {}

function export.configure_command(cmd)
    for k, v in pairs(actions) do
        cmd:argument({ name = k, table.unpack(v.configure_command(cmd) or {})})
    end
end

function export.on_run(args)
    
end

return export
