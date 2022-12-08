local thunderstore  = require("thor.thunderstore")
local common        = require("thor.common")

---@type Action
local export = {}

function export.configure_command(cmd)
    local ch = common.getkeys(thunderstore.communities)
    ch[#ch+1] = "communities"

    cmd:argument {
        name = "community",
        choices = ch,
        default = "communities"
    }

    cmd:argument {
        name = "scope",
        choices = {
            "categories",
            "packages"
        },
        default = "categories",
        args = "?"
    }

    cmd:option {
        name = "-c --category",
        args = "+"
    }
    cmd:option {
        name = "-x --exclude-category",
        args = "+"
    }

    cmd:option {
        name = "-n --name",
        args = "+"
    }

    cmd:option {
        name = "-z --exclude-author",
        args = "+"
    }
end

function export.on_run(arg)
    local community_name = arg["community"] --[[@as string]]

    local scope = arg["scope"] --[[@as "categories" | "packages"]]
    local names = arg["name"] --[[@as string[] ]] or {}
    local cats, xcats = arg["categories"] --[[@as string[] ]] or {}, arg["exclude_category"] --[[@as string[] ]] or {}
    local xauthor = arg["exclude_author"] --[[@as string[] ]] or {}


    if community_name == "communities" then
        for k, v in pairs(thunderstore.communities) do
            print("- \""..v.name.."\":")
            print("  Identifier: "..k)
            print("  Discord URL: "..(v.discord_url or "none"))
            print("  Wiki URL: "..(v.wiki_url or "none"))
        end
    else
        local community = thunderstore.communities[community_name]
        
        if scope == "categories" then
            print("- Categories for "..community_name..":")
            for _, v in pairs(community.categories) do
                print("  "..v.name.." (slug: "..v.slug..")")
            end
        else
            print("- Packages for "..community_name..":")
            for pkgid, pkg in pairs(community.packages.database) do
                for _, name in ipairs(names) do if not pkgid:lower():find(name:lower()) then goto next end end

                for _, cat in ipairs(cats) do
                    local ok = false
                    for _, v in ipairs(pkg["categories"]) do if v:lower():find(cat:lower()) then ok = true; break end end

                    if not ok then goto next end
                end

                for _, cat in ipairs(xcats) do
                    for _, v in ipairs(pkg["categories"]) do if v:lower():find(cat:lower()) then goto next end end
                end

                for _, author in ipairs(xauthor) do if pkg["owner"]:lower():find(author:lower()) then goto next end end

                print(pkg["name"])

                ::next::
            end
        end
    end
end

return export
