package = "Thor"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "*** please enter a project homepage ***",
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
         ["thor"] = "src/thor.lua"
      }
   },
   modules = {
      ["json"] = "src/json.lua",
      
      ["common"] = "src/common.lua",
      ["thunderstore"] = "src/thunderstore.lua",
      ["actions"] = "src/actions/init.lua",
      ["actions.update"] = "src/actions/update.lua",
      ["actions.info"] = "src/actions/info.lua",
      ["actions.list"] = "src/actions/list.lua",
   }
}
