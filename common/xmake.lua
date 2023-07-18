includes("../packages.lua")

--Config:
local packages = {
    "objfw-local",
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

add_requires(packages, { configs = { shared = true }, system = false })

target("Common")
do
    set_kind("static")
    add_packages(packages)

    add_files("src/**.m")
    add_files("src/**.mm")
    add_headerfiles("src/**.h")
    set_pmheader("src/Common/common.h")

    add_includedirs("src/", { public = true })

    add_mxflags(mflags.regular)
    add_mxxflags("-fexceptions", "-fobjc-exceptions", "-funwind-tables", "-fconstant-string-class=OFConstantString", "-Xclang", "-fno-constant-cfstrings", "-fblocks", "-fobjc-arc", "-fobjc-arc-exceptions")
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
end
target_end()
