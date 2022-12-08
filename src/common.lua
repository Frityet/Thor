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

---@generic T
---@param t { [T] : any }
---@return T[]
function export.getkeys(t)
    local arr = {}

    for k, _ in pairs(t) do arr[#arr+1] = k end

    return arr
end

---Finds keys which sorta kinda match the key
---@param map { [string] : any }
---@param query string
---@return string[]?
function export.find(map, query)
    local res = {}
    for k, _ in pairs(map) do if k:find(query) then res[#res+1] = k end end
    return #res > 0 and res or nil
end

return export
