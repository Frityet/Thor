local app = require("pl.app")
local dir = require("pl.dir")

---@class ProfileAction : Action
---@field on_run fun(args: argparse.Command.PropertiesTable, profilename: string)

---@type { [string] : ProfileAction }
local actions = {
    add     = require("thor.actions.profiles.add"),
    create  = require("thor.actions.profiles.create"),
    delete  = require("thor.actions.profiles.delete"),
    export  = require("thor.actions.profiles.export"),
    import  = require("thor.actions.profiles.import")
}

local profiles = require("thor.actions.profiles.profile")

local export = {}

---@param parser argparse.Command
function export.configure_command(parser)
    local pdir, err = app.appfile("profiles/")
    if not pdir then error("Could not get directory for profiles!\nReason: "..err) end
    profiles.directory = pdir
    dir.makepath(profiles.directory)

    parser:command_target("profile-action")

---@diagnostic disable-next-line: param-type-mismatch
    parser:argument {
        name = "profile",
        description = "Profile name",
    }

---@diagnostic disable-next-line: param-type-mismatch
    parser:option {
        name = "-d --directory",
        description = "Directory the profile resides in",
        args = 1,
        default = profiles.directory
    }

    for k, v in pairs(actions) do
        v.configure_command(parser:command(k))
    end
end

function export.on_run(args)
    profiles.directory = args["directory"]

    actions[args["profile-action"]--[[@as string]] ].on_run(args, args["profile"])
end

return export
