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
    -- "lanes"
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
        ["thunderstore"]                    = "src/thunderstore.lua",
        ["asyncdownload"]                   = "src/asyncdownload.lua",

        --#region thor
        ["thor.actions"]                    = "src/thor/actions/init.lua",
        ["thor.actions.update"]             = "src/thor/actions/update.lua",
        ["thor.actions.info"]               = "src/thor/actions/info.lua",
        ["thor.actions.list"]               = "src/thor/actions/list.lua",

        ["thor.actions.profiles"]            = "src/thor/actions/profiles/init.lua",
        ["thor.actions.profiles.profile"]    = "src/thor/actions/profiles/profile.lua",
        ["thor.actions.profiles.add"]        = "src/thor/actions/profiles/add.lua",
        ["thor.actions.profiles.create"]     = "src/thor/actions/profiles/create.lua",
        ["thor.actions.profiles.delete"]     = "src/thor/actions/profiles/delete.lua",
        ["thor.actions.profiles.export"]     = "src/thor/actions/profiles/export.lua",
        ["thor.actions.profiles.import"]     = "src/thor/actions/profiles/import.lua",
        --#endregion

        --#region mjolnir
        ["mjolnir.actions"]                 = "src/mjolnir/actions/init.lua",
        ["mjolnir.actions.create"]          = "src/mjolnir/actions/create.lua"
        --#endregion
    }
}
