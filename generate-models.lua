local lfs = require("lfs")
local json = require("cjson.util")

local exec = os.execute

exec "openapi-generator generate -v -grust -o ./ -i thunderstore.openai.json"

---@type string[]
local nms = {}

for file in lfs.dir("src/models/") --[[@as fun(): string]] do
    local path = lfs.currentdir().."/src/models/"..file
    print(path)

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

    nms[#nms+1] = file:sub(1, -4) -- remove the .rs
end

local f = assert(io.open("src/models/mod.rs", "r+"))

for _, name in ipairs(nms) do
    f:write("pub mod "..name..";\n")
end

f:write("pub use crate::models::{\n")
for _, name in ipairs(nms) do
    f:write("    "..name.."::*,\n")
end
f:write("};\n\n")

f:close()
