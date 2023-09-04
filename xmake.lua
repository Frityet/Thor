includes("packages.lua")

option("use-system-objfw")
do
    set_default(false)
    set_showmenu(true)
    set_category("option")
    set_description("Use system ObjFW")
end
option_end()

option("use-debug-objfw")
do
    set_default(false)
    set_showmenu(true)
    set_category("option")
    set_description("Use debug objfw when building a debug build")
end
option_end()

option("ssl-library")
do
    set_default("openssl")
    set_values("openssl", "gnutls", "securetransport")
    set_showmenu(true)
    set_category("option")
    set_description("What SSL library ObjFW should use")
end
option_end()

add_requires(has_config("use-system-objfw") and "objfw" or "objfw-local", {
    debug = has_config("use-debug-objfw") and is_mode("debug"),
    system = has_config("system-objfw"),
    configs = {
        tls = get_config("ssl-library"),
        shared = is_kind("shared")
    },
    alias = "ofw"
})

add_packages("ofw")

includes("cli", "thor", "common")
