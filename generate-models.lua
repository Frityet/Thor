local lfs = require("lfs")

local l_error = error
function error(msg, level) return l_error("\x1b[31m"..msg.."\x1b[0m", level) end

print("\x1b[33mGenerating structs...\x1b[0m")
os.execute("openapi-generator generate -grust -o ./ -i thunderstore.openai.json")
print("\x1b[32mDone!\x1b[0m")

---@type string[]
local nms = {}

for file in lfs.dir("src/models/") --[[@as fun(): string]] do
    if file == "." or file == ".." or file == "mod.rs" then goto next end

    local path = lfs.currentdir().."/src/models/"..file

    ---@type string
    local contents do
        local f = assert(io.open(path, "r"))
        contents = f:read("a")
        f:close()
    end

    local f = assert(io.open(path, "w+"))
    f:write("use serde::*;\n")
    f:write("use serde_derive::{Serialize, Deserialize};\n")
    f:write(contents)
    f:close()
    print("  \x1b[32mAdded header to \x1b[35m"..file.."\x1b[0m\x1b[0m")

    nms[#nms+1] = file:sub(1, -4) -- remove the .rs

    ::next::
end

print("\x1b[33mGenerating header to \x1b[35mmod.rs\x1b[0m...\x1b[0m")
local f = assert(io.open("src/models/mod.rs", "w+"))

f:write("#![allow(warnings)]\n")

print("\x1b[33mAdding mods...\x1b[0m")
for _, name in ipairs(nms) do
    f:write("pub mod "..name..";\n")
    print("  \x1b[32mAdded \x1b[35m"..name.."\x1b[0m")
end
print("\x1b[32mDone!\x1b[0m")

print("\x1b[33mAdding uses...\x1b[0m")
f:write("pub use crate::models::{\n")
for _, name in ipairs(nms) do
    f:write("    "..name.."::*,\n")
    print("  \x1b[32mAdded \x1b[35m"..name.."\x1b[0m")
end
f:write("};\n\n")
print("\x1b[32mDone!\x1b[0m")

f:close()
