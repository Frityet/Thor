local copas         = require("copas")
local async_https   = require("copas.http")
local https         = require("ssl.https")
local json          = require("json")
local file          = require("pl.file")
local pretty        = require("pl.pretty")
local app           = require("pl.app")
local dir           = require("pl.dir")
local path          = require("pl.path")

local common = require("common")

local export = {
    ---@type { [string] : Community }
    communities = {
        ---@class Community
        [""] = {
            name = "",
            identifier = "",

            ---@type string?
            discord_url = "",
            ---@type string?
            wiki_url = "",
            require_package_listing_approval = false,

            ---@type {[string] : { name: string, slug: string }}
            categories = {},

            packages = {}
        }
    },

    package_dir = ""
}
--literally just so my LSP works better
export.communities[""] = nil

do
    local reason
    export.package_dir, reason = app.appfile("packages/")
    if not export.package_dir then error("Could not get directory for package lists! Reason: "..reason) end
    dir.makepath(export.package_dir)
end

local function getpackage(self, idx)
    ---@type string
    local repo_path = getmetatable(self)._file
    if not rawget(self, "database") then self.database = dofile(repo_path) end
    if not self.database then error("Could not read package database at "..repo_path) end

    if idx == "database" then return rawget(self, "database") end
    return self.database[idx]
end

local function getallpackages(self)
    print("Paring")
    getpackage(self, "")
    return next, self.database, nil
end

function export.fetch_all()
    local body, c = https.request("https://h3vr.thunderstore.io/api/experimental/community/")
    if not body or c ~= 200 then error("Could not get community list! Error code: "..c) end

    export.communities = common.array_to_map(json.decode(body)["results"], function (x) return x["identifier"] end)

    local i = { 0, #common.getkeys(export.communities) }
    --Get all of the community lists and package lists async
    for _, v in pairs(export.communities) do
        ---@param community Community
        copas.addthread(function (community)
            local id = community.identifier
            local contents, code = async_https.request("https://h3vr.thunderstore.io/api/experimental/community/"..id.."/category/")
            if not contents or code ~= 200 then error("Could not get category for community \""..id.."\"! Error code: "..code) end
            community.categories = common.array_to_map(json.decode(contents)["results"], function (x) return x["slug"] end)


            contents, code = async_https.request("https://thunderstore.io/c/"..id.."/api/v1/package/")
            if not contents or code ~= 200 then error("Could not get package list for community \""..id.."\"! Error code: "..code) end
            local packages = common.array_to_map(json.decode(contents), function (x) return x["full_name"] end)
 
            local pkg_path = path.join(export.package_dir, id..".lua")
            local f, reason = io.open(pkg_path, "w+b")
            if not f then error("Could not create file at "..path.."\nReason: "..reason) end

            f:write("return ", pretty.write(packages))

            f:close()
            i[1] = i[1] + 1
            print(string.format("Got package list for community \"%s\" (%d/%d)", id, i[1], i[2]))
        end, v, i)
    end

    --Run the async loop
    copas()


end

do
    local community_path = app.appfile("communities.lua")
    if not path.exists(community_path) then
        print("Community registry not found, creating...")
        export.fetch_all()
        file.write(community_path, "return "..pretty.write(export.communities))
        print("Wrote community registry to "..community_path)
    else
        export.communities = dofile(community_path)
    end

    for k, v in pairs(export.communities) do
        v.packages = setmetatable({}, {
            _file = path.join(export.package_dir, k..".lua"),
            __index = getpackage,
            __pairs = getallpackages
        })
    end
end

if #dir.getfiles(export.package_dir) < #common.getkeys(export.communities) then export.fetch_all() end

return export
