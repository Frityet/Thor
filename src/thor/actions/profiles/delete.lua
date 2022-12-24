local profiles = require("thor.actions.profiles.profile")
local file = require("pl.file")
local path = require("pl.path")

---@type ProfileAction
local export = {}

function export.configure_command(parser)

end

function export.on_run(args, profilename)
    if not profiles.database[profilename] then error("Could not find profile \""..profilename..profiles.FILE_EXTENSION.."\" in "..profiles.directory.."!") end

    file.delete(path.join(profiles.directory, profilename..profiles.FILE_EXTENSION))
end

return export
