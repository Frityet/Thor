local argparse = require("argparse")

---@param args string[]
---@param program_name string
---@return { [string]: any }
function ParseArguments(args, program_name)
    args[0] = program_name
    local parser = argparse(program_name, "Mod manager for thunderstore", "https://github.com/Frityet/Thor")
    parser:command_target("action")
    do
        --#region List
        do
            local cmd = parser:command("list", "List mods")
            cmd:argument "community"

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:argument {
                name = "scope",
                choices = {
                    "categories",
                    "mods"
                },
                default = "categories",
                args = "?"
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-v --versions",
                description = "Show versions of mods",
                args = 0
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-c --category",
                args = "+"
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-x --exclude-category",
                args = "+"
            }


            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-n --name",
                args = "+",
                description = "Filter by mod name"
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-a --author",
                args = "+"
            }
            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-z --exclude-author",
                args = "+"
            }
        end
        --#endregion

        --#region Info
        do
            local cmd = parser:command("info", "Get info about a mod")
            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:argument "community"
            cmd:argument "mod"
        end
        --#endregion

        --#region Update
        do
            local cmd = parser:command("update", "Update the cache or mods")
            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:argument {
                name = "scope",
                choices = {
                    "database",
                    "mods"
                },
                default = "database"
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-f --fetch-mods",
                description = "Fetch mods from thunderstore",
                args = 0
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-c --community",
                args = "+",
            }
        end
        --#endregion

        --#region Profiles
        do
            local cmd = parser:command("profile", "Manage profiles")

            cmd:command_target "profile-action"
            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:argument {
                name = "profile",
                description = "The profile to use",
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            cmd:option {
                name = "-d --directory",
                description = "Directory the profile resides in",
                args = 1,
            }

            cmd:command("delete", "Delete a profile")
            cmd:command("list", "List profiles")

            --#region Create
            do
                local cmd = cmd:command("create", "Create a new profile")
                ---@diagnostic disable-next-line: param-type-mismatch
                cmd:argument {
                    name = "community",
                    description = "community the profile is for",
                    args = 1,
                }
            end
            --#endregion

            --#region Add
            do
                local cmd = cmd:command("add", "Add a mod to a profile")
                ---@diagnostic disable-next-line: param-type-mismatch
                cmd:argument {
                    name = "author",
                    description = "The mod's author",
                    args = 1,
                }

                ---@diagnostic disable-next-line: param-type-mismatch
                cmd:argument {
                    name = "mod",
                    description = "The mod to add",
                    args = 1,
                }

                ---@diagnostic disable-next-line: param-type-mismatch
                cmd:option {
                    name = "-v --version",
                    description = "The version to add",
                    args = 1,
                }
            end
            --#endregion
        end
        --#endregion
    end
    parser:add_complete()
    return parser:parse(args)
end
