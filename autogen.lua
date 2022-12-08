#!/usr/bin/env luajit

--[[
    Automatically generate lua-language-server types
]]--

package.path = package.path..";./lua_modules/share/lua/5.1/?.lua;./lua_modules/share/lua/5.1/?/init.lua"

local thunderstore = require("thor.thunderstore")

local typef = assert(io.open("autogen/types.lua", "w+"))

--#region Community identifiers
typef:write("---@meta\n\n")
typef:write("---@alias CommunityIdentifier\n")

for k, _ in pairs(thunderstore.communities) do
    print("Writing alias def for id: "..k)
    typef:write(string.format("---|'%s'\n", k))
end
typef:write(string.format("---|'%s'\n", ""))

typef:write('\n')
typef:flush()
--#endregion

--#region Package manifest

--Used later down!
local ver = {}
typef:write("---@class Package\n")
for _, v in pairs(thunderstore.communities["h3vr"].packages.database) do
    print("Writing fields for package class")
    for field, val in pairs(v) do
        if field ~= "versions" then
            typef:write(string.format("---@field %s %s\n", field, field == "categories" and "string[]" or type(val)))
        else
            typef:write("---@field versions Package.Version[]\n")
            ver = val[1]
        end
    end

    typef:write('\n')
    typef:write("---@class Package.Version\n")
    for field, val in pairs(ver) do
        typef:write(string.format("---@field %s %s\n", field, field == "dependencies" and "string[]" or type(val)))
    end

    --Only need the first one
    break
end
typef:write('\n')
typef:flush()

--#endregion

typef:close()
