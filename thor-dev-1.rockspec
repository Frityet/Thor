---@diagnostic disable: lowercase-global
package = "Thor"
version = "dev-1"
source = {
    url = "git://github.com/Frityet/Thor.git"
}
description = {
    homepage = "https://github.com/Frityet/Thor",
    license = "GPLv3"
}
dependencies = {
    "lua >= 5.1",
    "luafilesystem",
    "luasec",
    "copas",
    "argparse",
    "penlight",
}
build = {
    type = "builtin",
    install = {
        bin = {
            ["thor"] = "src/thor/init.lua",
            ["mjolnir"] = "src/mjolnir/init.lua"
        }
    },
    modules = {
        ["json"]                            = "src/json.lua",
        ["common"]                          = "src/common.lua",

        --#region thor  
        ["thor.thunderstore"]               = "src/thor/thunderstore.lua",

        ["thor.actions"]                    = "src/thor/actions/init.lua",
        ["thor.actions.update"]             = "src/thor/actions/update.lua",
        ["thor.actions.info"]               = "src/thor/actions/info.lua",
        ["thor.actions.list"]               = "src/thor/actions/list.lua",

        ["thor.actions.profile"]            = "src/thor/actions/profile/init.lua",
        ["thor.actions.profile.add"]        = "src/thor/actions/profile/add.lua",
        ["thor.actions.profile.create"]     = "src/thor/actions/profile/create.lua",
        ["thor.actions.profile.delete"]     = "src/thor/actions/profile/delete.lua",
        ["thor.actions.profile.export"]     = "src/thor/actions/profile/export.lua",
        ["thor.actions.profile.list"]       = "src/thor/actions/profile/list.lua",
        --#endregion    

        --#region mjolnir   
        ["mjolnir.actions"]                 = "src/mjolnir/actions/init.lua",
        ["mjolnir.actions.create"]          = "src/mjolnir/actions/create.lua"
        --#endregion
    }
}
