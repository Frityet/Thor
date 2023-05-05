---@class Common
local export = {}

---@generic T
---@param array T[]
---@param k string | fun(arg: T): string
---@return { [string] : T }
function export.array_to_map(array, k)
    local d = {}
    for _, v in ipairs(array) do
        if type(k) == "string" then d[v[k]] = v
        else d[k(v)] = v end
    end
    return d
end

return export
