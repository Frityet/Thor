---@class Action
---@field configure_command fun(parser: table): table?
---@field on_run fun(args: { [string]: string | table })

---@type { [string] : Action }
local actions = {
    list = require("actions.list"),
    update = require("actions.update"),
    info = require("actions.info"),
    profile = require("actions.profile")
}

return actions
