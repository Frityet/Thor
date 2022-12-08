local thunderstore = require("thor.thunderstore")
local common       = require("thor.common")

---@type Action
local export = {}

function export.configure_command(cmd)
    cmd:argument {
        name = "community",
        choices = common.getkeys(thunderstore.communities)
    }

    cmd:argument {
        name = "package",
    }
end

function export.on_run(args)
    local search = args["package"] --[[@as string]]
    local community = thunderstore.communities[args["community"]] --[[@as Community]]
    local choices = {}
    for pkgid in pairs(community.packages.database) do
        if pkgid:lower():find(search:lower()) then choices[#choices+1] = pkgid end
    end

    if #choices > 1 then
        print("Multiple packages found: ")
        for _, v in ipairs(choices) do print("  "..community.packages[v]["name"]) end
    elseif #choices == 0 then print("\x1b[33mNo packages found with specified name")
    else print(community.packages[choices[1]]) end
end

return export
