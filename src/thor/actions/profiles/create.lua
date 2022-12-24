local profile = require("thor.actions.profiles.profile")
local thunderstore = require("thunderstore")
local tablex = require("pl.tablex")
local path = require("pl.path")

---@diagnostic disable: param-type-mismatch
---@type ProfileAction
local export = {}

function export.configure_command(cmd)
    cmd:argument {
        name = "community",
        description = "community the profile is for",
        args = 1,
        choices = tablex.keys(thunderstore.communities)
    }
end

function export.on_run(args, profilename)
    if profile.database[profilename] then error("Profile \""..profilename.."\" already exists!") end

    profile.database[profilename] = {
        name = profilename,
        community = args["community"],
        installed_mods = {}
    }

    print("\x1b[32mSuccessfully created new profile at \""..path.join(profile.directory, profilename..profile.FILE_EXTENSION).."\"!\x1b[0m")
end

return export
