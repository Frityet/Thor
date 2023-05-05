local thunderstore  = require("thunderstore")
local tablex        = require("pl.tablex")

---@type Action
local export = {}

function export.configure_command(parser)
---@diagnostic disable-next-line: param-type-mismatch
    parser:argument {
        name = "community",
        choices = tablex.keys(thunderstore.communities)
    }

    ---@diagnostic disable-next-line: param-type-mismatch
    parser:argument {
        name = "package",
    }

    -- for k, v in pairs(thunderstore.communities) do
    --     local cmd = parser:command(k)
    --     ---@diagnostic disable-next-line: param-type-mismatch
    --     cmd:argument {
    --         name = "package",
    --         choices = tablex.keys(v.packages.database)
    --     }
    -- end
end

function export.on_run(args)
    local search = args["package"]:lower() --[[@as string]]
    local community = thunderstore.communities[args["community"]] --[[@as Community]]
    ---@type string[]
    local choices = {}
    for _, pkg in pairs(community.packages.database) do
        local pkgid = pkg.full_name:lower()
        if pkgid:match(search) or pkgid == search then table.insert(choices, pkg.full_name) end
    end

    if #choices > 1 then
        print("- \x1b[33mMultiple packages found\x1b[0m: ")
        for _, v in ipairs(choices) do
            print("  "..community.packages[v].full_name:lower():gsub(search, "\x1b[31m"..search.."\x1b[0m"))
        end
    elseif #choices == 0 then print("\x1b[31mNo packages found with specified name\x1b[0m")
    else print(community.packages[choices[1]]) end
end

return export
