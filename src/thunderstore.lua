local copas         = require("copas")
local async_https   = require("copas.http")
local https         = require("ssl.https")
local json          = require("json")
local file          = require("pl.file")
local pretty        = require("pl.pretty")
local app           = require("pl.app")
local dir           = require("pl.dir")
local path          = require("pl.path")

local common        = require("common")

local export = {
    ---@type { [CommunityIdentifier] : Community }
    communities = {
        ---@class Community
        [""] = {
            name = "",
            ---@type CommunityIdentifier
            identifier = "",

            ---@type string?
            discord_url = "",
            ---@type string?
            wiki_url = "",
            require_package_listing_approval = false,

            ---@type {[string] : { name: string, slug: string }}
            categories = {},

            ---@type {[string] : Package, ["database"]: { [string]: Package }}
            packages = {}
        }
    },

    package_directory = ""
}
--literally just so my LSP works better
export.communities[""] = nil

do
    local reason
    export.package_directory, reason = app.appfile("packages/")
    if not export.package_directory then error("Could not get directory for package lists! Reason: "..reason) end
    dir.makepath(export.package_directory)
end

local function getpackage(self, idx)
    ---@type string
    local repo_path = getmetatable(self)._file
    if not rawget(self, "database") then self.database = dofile(repo_path) end
    if not self.database then error("Could not read package database at "..repo_path) end

    if idx == "database" then return rawget(self, "database") end
    return self.database[idx]
end

function export.fetch_all()
    local body, c = https.request("https://h3vr.thunderstore.io/api/experimental/community/")
    if not body or c ~= 200 then error("Could not get community list! Error code: "..c) end

    export.communities = common.array_to_map(json.decode(body)["results"],"identifier")


    local l, i = #common.getkeys(export.communities), 0
    --Get all of the community lists and package lists async
    for _, v in pairs(export.communities) do
        ---@param community Community
        copas.addthread(function (community, index, keyc)
            local id = community.identifier
            local contents, code = async_https.request("https://h3vr.thunderstore.io/api/experimental/community/"..id.."/category/")
            if not contents or code ~= 200 then error("Could not get category for community \""..id.."\"! Error code: "..code) end

            --Map the key to the `slug`, with the value just being the decoded table value
            community.categories = common.array_to_map(json.decode(contents)["results"], "slug")

            contents, code = async_https.request("https://thunderstore.io/c/"..id.."/api/v1/package/")
             if not contents or code ~= 200 then error("Could not get package list for community \""..id.."\"! Error code: "..code) end

            --Same thing, but with `full_name` instead of `slug`
            local packages = common.array_to_map(json.decode(contents), "full_name")

            local pkg_path = path.join(export.package_directory, id..".lua")
            local f, reason = io.open(pkg_path, "w+b")
            if not f then error("Could not create file at "..path.."\nReason: "..reason) end

            --This is a bad IDEA!
            --TODO: Replace with actual binary serialization
            f:write("return ", pretty.write(packages, "", true))

            f:close()
            print(string.format("Got package list for community \"%s\" (%d/%d)", id, index, keyc))
        end, v, i, l)
        i = i + 1
    end

    --Run the async loop
    copas()
end

do
    local community_path = app.appfile("communities.lua")
    if not path.exists(community_path) then
        print("Community registry not found, creating...")
        export.fetch_all()
        
        file.write(community_path, "return "..pretty.write(export.communities, "", true))

        print("Wrote community registry to "..community_path)
    else
        export.communities = dofile(community_path)
    end

    for k, v in pairs(export.communities) do
        v.packages = setmetatable({}, {
            _file = path.join(export.package_directory, k..".lua"),
            __index = getpackage,
        })
    end
end

if #dir.getfiles(export.package_directory) < #common.getkeys(export.communities) then export.fetch_all() end

return export
