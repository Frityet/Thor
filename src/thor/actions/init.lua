---@class Action
---@field configure_command fun(parser: table): table?
---@field on_run fun(args: { [string]: string | table })

---@type { [string] : Action }
local actions = {
    list    = require("thor.actions.list"),
    update  = require("thor.actions.update"),
    info    = require("thor.actions.info"),
    profile = require("thor.actions.profile")
}

return actions
