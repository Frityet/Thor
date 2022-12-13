local thunderstore  = require("thunderstore")
local common        = require("common")
local app           = require("pl.app")
local dir           = require("pl.dir")
local path          = require("pl.path")
local file          = require("pl.file")
local pretty        = require("pl.pretty")

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
    profiles = {},
    
    profile_directory = ""
}


local function getprofile(self, name)
    local cfgfile = path.join(export.profile_dir, name)
    if not path.exists(cfgfile) or path.isdir(cfgfile) then
        error("No profile found under name \""..name.."\"! Did you forget to create it with `\x1b[31mthor\x1b[0m profile create`?")
    end

    return dofile(cfgfile)
end

local function setprofile(self, name, data)
    local cfgfile = path.join(export.profile_dir, name)

    local ok, err = file.write(cfgfile, "return "..pretty.write(data, "", true))
    if not ok then
        error("Could not write to file \""..cfgfile.."\" Reason:"..err)
    end
end


function export.configure_command(parser)
    local err
    export.profile_dir, err = app.appfile("profiles/")
    if not export.profile_dir then error("Could not get directory for profiles!\nReason: "..err) end
    dir.makepath(export.profile_dir)


    setmetatable(export.profiles, {
        __index = getprofile,
        __newindex = setprofile
    })
    

    parser:command_target("profile-action")
    for k, v in pairs(actions) do
        v.configure_command(parser:command(k))
    end
end

function export.on_run(args)
    actions[args["profile-action"]--[[@as string]] ].on_run(args)
end

return export
