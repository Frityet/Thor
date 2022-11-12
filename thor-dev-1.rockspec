---@diagnostic disable: lowercase-global
package = "Thor"
version = "dev-1"
source = {
   url = "https://github.com/Frityet/Thor"
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
         ["thor"] = "src/thor.lua",
      }
   },
   modules = {
      ["json"]                      = "src/json.lua",

      ["common"]                    = "src/common.lua",
      ["thunderstore"]              = "src/thunderstore.lua",

      ["actions"]                   = "src/actions/init.lua",
      ["actions.update"]            = "src/actions/update.lua",
      ["actions.info"]              = "src/actions/info.lua",
      ["actions.list"]              = "src/actions/list.lua",

      ["actions.profile"]           = "src/actions/profile/init.lua",
      ["actions.profile.create"]    = "src/actions/profile/create.lua",
      ["actions.profile.database"]  = "src/actions/profile/database.lua",
   }
}
