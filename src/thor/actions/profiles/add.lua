local profile = require("thor.actions.profiles.profile")
local thunderstore = require("thunderstore")
local pretty = require("pl.pretty")

---@diagnostic disable: param-type-mismatch
---@type ProfileAction
local export = {}

function export.configure_command(parser)
    parser:argument {
        name = "package ID",
        description = "ID of the mod to add",
        args = '+',
    }
end

function export.on_run(args, profilename)
    local prof = profile.database[profilename]
    local pkgs = args["package ID"] --[[@as string[] ]]

    if not prof then error("Could not find profile \""..profilename..profile.FILE_EXTENSION.."\" in "..profile.directory.."!") end

    for i, v in ipairs(pkgs) do
        local community = thunderstore.communities[prof.community]
        if not community then error("Could not get community \""..prof.community.."\"") end

        local mod = community.packages[v]
        if not mod then error("Could not find mod \""..v.."\" in community \""..prof.community.."\"!") end
        prof.installed_mods[mod.full_name] = mod.versions[#mod.versions].version_number
        print("Added mod \""..mod.name.."\"")
    end
end

return export
