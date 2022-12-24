local app           = require("pl.app")
local dir           = require("pl.dir")
local path          = require("pl.path")
local file          = require("pl.file")
local pretty        = require("pl.pretty")

local export = {
    ---@type { [string]: Profile } | { ["$all-profile-names$"]: fun(): string }
    database = {
        ---@class Profile
        [""] = {
            community       = "",
            ---@type CommunityIdentifier
            game            = "",
            ---@type { [string]: string }
            installed_mods  = {},

        }
    },

    directory = "",

    FILE_EXTENSION = ".tsprofile"
}
export.database[""] = nil


local function getprofile(self, name)
    if name == "$all-profile-names$" then
        return coroutine.wrap(function ()
            for i, v in ipairs(dir.getfiles(export.directory, "*"..export.FILE_EXTENSION)) do
                coroutine.yield(path.basename(v))
            end
        end)
    end

    local cache = rawget(self, name)
    if cache then return cache end

    local cfgfile = path.join(export.directory, name..export.FILE_EXTENSION)
    if not path.exists(cfgfile) or path.isdir(cfgfile) then
        return nil
    end

    rawset(self, name, pretty.read(file.read(cfgfile)))
    return rawget(self, name)
end

local function setprofile(self, name, data)
    local cfgfile = path.join(export.directory, name..export.FILE_EXTENSION)

    local ok, err = file.write(cfgfile, pretty.write(data, "", true))
    if not ok then error("Could not write to file \""..cfgfile.."\" Reason:"..err) end

    rawset(self, name, data)
end


setmetatable(export.database, {
    __index = getprofile,
    __newindex = setprofile
})

return export
