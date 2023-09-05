includes("../common")

--Config:
local packages = {
}

local sanitizers = { }

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
        "-fPIC"
    }
}

local ldflags = {
    release = {},
    debug = {},
    regular = {
        "-fPIC"
    }
}

set_languages {
    "gnulatest"
}

add_rules("mode.debug", "mode.release")

add_requires(packages, { configs = { shared = true }, system = false })

target("Thor")
do
    set_kind(is_kind("static") and "static" or "shared")
    add_packages(packages)

    add_files("src/**.m")
    add_headerfiles("src/**.h")
    add_deps("Common")

    add_includedirs("src/", { public = true })

    add_mxflags(mflags.regular)
    add_ldflags(ldflags.regular)

    if is_mode("debug") then
        add_defines("PROJECT_DEBUG")
        add_mxflags(mflags.debug)
        add_ldflags(ldflags.debug)

        for _, v in ipairs(sanitizers) do
            add_mxflags("-fsanitize=" .. v)
            add_ldflags("-fsanitize=" .. v)
        end

    elseif is_mode("release") then
        add_mxflags(mflags.release)
        add_ldflags(ldflags.release)
    end
end
target_end()
