local thunderstore = require("thor.thunderstore")
local common       = require("thor.common")
local app          = require("pl.app")
local dir          = require("pl.dir")
local path         = require("pl.path")

---@type { [string] : Action }
local actions = {
    add     = require("thor.actions.profile.add"),
    create  = require("thor.actions.profile.create"),
    delete  = require("thor.actions.profile.delete"),
    export  = require("thor.actions.profile.export"),
    list    = require("thor.actions.profile.list")
}

---@class Profile : Action
local export = {
    profiles = {
        
    },

    profile_directory = ""
}




function export.configure_command(parser)
    local err
    export.profile_dir, err = app.appfile("profiles/")
    if not export.profile_dir then error("Could not get directory for profiles!\nReason: "..err) end
    dir.makepath(export.profile_dir)

    local profile_database_path = app.appfile(path.join(export.profile_dir, "profiles.lua"))
    if not path.exists(profile_database_path) then
        print("No profiles found!")
        print("Creating profile database file...")
    end

    parser:command_target("profile-action")
    for k, v in pairs(actions) do
        v.configure_command(parser:command(k))
    end
end

function export.on_run(args)
    actions[args["profile-action"]--[[@as string]] ].on_run(args)
end

return export
