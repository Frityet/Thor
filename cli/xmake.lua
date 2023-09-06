includes("../thor", "../common")

--Config:
local packages = {
    "lua",
}

local sanitizers = {
    -- "address", "leak", "undefined"
}

local mflags = {
    release = {},
    debug = {
        "-Wno-unused-function", "-Wno-unused-parameter", "-Wno-unused-variable"
    },
    regular = {
        "-Wall", "-Wextra", "-Werror",
        "-Wnull-dereference",
        "-Wnull-conversion",
        "-Wnullability-completeness",
        "-Wnullable-to-nonnull-conversion",
        "-Wanon-enum-enum-conversion",
        "-Wassign-enum",
        "-Wenum-conversion",
        "-Wenum-enum-conversion",
        "-Wno-missing-braces",
    }
}

local ldflags = {
    release = {},
    debug = {},
    regular = {
    }
}

set_languages {
    "gnulatest"
}

add_rules("mode.debug", "mode.release")

add_requires(packages, { debug = false, configs = { shared = false }, system = false })


target("ThorCLI")
do
    set_kind("binary")
    add_rules("utils.bin2c", { extensions = { ".luac" } })
    add_packages(packages)

    add_deps("Thor", "Common")

    add_files("src/**.m")
    add_files("src/cli.luac")
    add_headerfiles("src/**.h")

    add_includedirs("src/")

    add_mxflags(mflags.regular)
    add_ldflags(ldflags.regular)

    if is_mode("debug") then
        add_mxflags(mflags.debug)
        add_ldflags(ldflags.debug)

        for _, v in ipairs(sanitizers) do
            add_mxflags("-fsanitize=" .. v)
            add_ldflags("-fsanitize=" .. v)
        end

        add_defines("PROJECT_DEBUG")
    elseif is_mode("release") then
        add_mxflags(mflags.release)
        add_ldflags(ldflags.release)
    end

    before_build(function (target)
        import("lib.detect.find_tool")
        os.runv(find_tool("luac", { check = function(tool) os.run("%s -v", tool)  end }).program, { "-s", "-o", path.join(target:scriptdir(), "src", "cli.luac"), path.join(target:scriptdir(), "src", "cli.lua") })
    end)
end
target_end()
