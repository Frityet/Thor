--TODO: Need better alternative! https://github.com/actboy168/lua-debug/issues/202
package.cpath = "/Users/frityet/Documents/Thor/lua_modules/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so"

local pretty = require("pl.pretty")
local argparse = require("argparse")
local thunderstore = require("thunderstore")
local actions = require("actions")

local lprint, lerror = print, error

-- ---Regular print can't print tables, and pprint has quotations around strings, so this is the best solution
-- ---@param ... any
function print(...)
    local a = {...}
    if #a < 1 then return
    elseif #a == 1 then
        if type(a[1]) ~= "table" then lprint(tostring(a[1])) else print(pretty.write(a[1])) end
    else print(pretty.write(a)) end
end

function error(msg, i)
    if type(msg) == "table" then msg = pretty.write(msg)
    elseif type(msg) ~= "string" then msg = tostring(msg) end
    return lerror("\n\x1b[31m"..msg.."\x1b[0m", i)
end


local parser = argparse() {
    name = "thor",
    description = "Mod manager for thunderstore",
}

parser:command_target("action")
for k, v in pairs(actions) do
    v.configure_command(parser:command(k))
end

parser:add_complete()
local args = parser:parse()
actions[args["action"]].on_run(args)
