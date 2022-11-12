---@class Action
---@field configure_command fun(parser: table)
---@field on_run fun(args: { [string]: string | table })

---@type { [string] : Action }
local actions = {
    list = require("actions.list"),
    update = require("actions.update"),
    info = require("actions.info")
}

return actions
