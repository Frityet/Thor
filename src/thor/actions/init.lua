

---@class Action
---@field configure_command fun(parser: argparse.Command): table?
---@field on_run fun(args: argparse.Command.PropertiesTable)

---@type { [string] : Action }
local actions = {
    list    = require("thor.actions.list"),
    update  = require("thor.actions.update"),
    info    = require("thor.actions.info"),
    profile = require("thor.actions.profiles")
}

return actions
