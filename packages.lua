---@diagnostic disable: missing-fields, redundant-parameter
package("gnutls")
    set_homepage("https://www.gnutls.org/")
    set_description("GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols")

    add_urls("https://www.gnupg.org/ftp/gcrypt/gnutls/v$(version).tar.xz")
    add_versions("3.7.10", "b6e4e8bac3a950a3a1b7bdb0904979d4ab420a81e74de8636dd50b467d36f5a9")

    add_deps("autoconf", "automake", "libtool", "pkg-config")

    add_configs("threads", { description = "Enable threads.", default = true, type = "boolean" })
    add_configs("tools", { description = "Enable tools.", default = true, type = "boolean" })
    add_configs("cxx", { description = "Enable C++ support.", default = false, type = "boolean" })
    add_configs("dynamic-ncrypt", { description = "Enable dynamic nettle crypt.", default = false, type = "boolean" })
    add_configs("hardware-acceleration", { description = "Enable hardware acceleration.", default = false, type = "boolean" })
    add_configs("tls13-interop", { description = "Enable TLS1.3 interoperability testing with openssl.", default = false, type = "boolean" })
    add_configs("padlock", { description = "Enable padlock acceleration.", default = true, type = "boolean" })
    add_configs("strict-der-time", { description = "Allow non compliant DER time values.", default = true, type = "boolean" })
    add_configs("sha1-support", { description = "Allow SHA1 as an acceptable hash for cert digital signatures.", default = false, type = "boolean" })
    add_configs("ssl3-support", { description = "Enable support for the SSL 3.0 protocol.", default = false, type = "boolean" })
    add_configs("ssl2-support", { description = "Enable support for the SSL 2.0 client hello.", default = true, type = "boolean" })
    add_configs("dtls-srtp-support", { description = "Enable support for the DTLS-SRTP extension.", default = true, type = "boolean" })
    add_configs("alpn-support", { description = "Enable support for the Application Layer Protocol Negotiation (ALPN) extension.", default = true, type = "boolean" })
    add_configs("heartbeat-support", { description = "Enable support for the heartbeat extension.", default = true, type = "boolean" })
    add_configs("srp-authentication", { description = "Enable the SRP authentication support.", default = true, type = "boolean" })
    add_configs("psk-authentication", { description = "Enable the PSK authentication support.", default = true, type = "boolean" })
    add_configs("anon-authentication", { description = "Enable the anonymous authentication support.", default = true, type = "boolean" })
    add_configs("dhe", { description = "Enable the DHE support.", default = true, type = "boolean" })
    add_configs("ecdhe", { description = "Enable the ECDHE support.", default = true, type = "boolean" })
    add_configs("gost", { description = "Enable the GOST support.", default = true, type = "boolean" })
    add_configs("cryptodev", { description = "Enable cryptodev support.", default = false, type = "boolean" })
    add_configs("afalg", { description = "Enable AF_ALG support.", default = false, type = "boolean" })
    add_configs("ktls", { description = "Enable KTLS support.", default = false, type = "boolean" })
    add_configs("ocsp", { description = "Enable OCSP support.", default = true, type = "boolean" })
    add_configs("openssl-compatibility", { description = "Enable the OpenSSL compatibility library.", default = true, type = "boolean" })
    add_configs("fuzzer-target", { description = "Make a library intended for testing - not production.", default = false, type = "boolean" })
    add_configs("nls", { description = "Use Native Language Support.", default = true, type = "boolean" })
    add_configs("rpath", { description = "Hardcode runtime library paths.", default = true, type = "boolean" })
    add_configs("fips140-mode", { description = "Enable FIPS140-2 mode.", default = false, type = "boolean" })
    add_configs("strict-x509", { description = "Enable stricter sanity checks for x509 certificates.", default = false, type = "boolean" })
    add_configs("non-suiteb-curves", { description = "Enable curves not in SuiteB.", default = true, type = "boolean" })
    add_configs("libdane", { description = "Build libdane.", default = true, type = "boolean" })

    on_install(function (package)
        local configs = {}

        table.insert(configs, "--disable-valgrind-tests")
        table.insert(configs, "--enable-tests")
        table.insert(configs, "--enable-shared=" .. (package:config("shared") and "yes" or "no"))
        table.insert(configs, "--enable-static=" .. (package:config("shared") and "no" or "yes"))

        for name, enabled in pairs(package:configs()) do
            if not package:extraconf("configs", name, "builtin") then
                name = name:gsub("_", "-")
                if enabled then
                    table.insert(configs, "--enable-" .. name)
                else
                    table.insert(configs, "--disable-" .. name)
                end
            end
        end

        import("package.tools.autoconf").install(package, configs)
    end)

package_end()

package("objfw-local")
    set_homepage("https://objfw.nil.im")
    set_description("Portable framework for the Objective-C language.")

    add_urls("https://github.com/ObjFW/ObjFW.git")
    add_versions("1.0.0", "8d19ba9c8f1955673569e10919025624975e896f")

    if is_host("linux", "macosx") then
        add_deps("autoconf", "automake", "libtool")
    end

    if is_plat("macosx") then
        add_syslinks("objc")
        add_frameworks("CoreFoundation")
    end

    add_configs("tls", { description = "Enable TLS support.", default = (is_plat("macosx") and "securetransport" or "openssl"), values = { true, false, "openssl", "gnutls", "securetransport" } })
    add_configs("rpath", { description = "Enable rpath.", default = true, type = "boolean" })
    add_configs("runtime", { description = "Use the included runtime, not recommended for macOS!", default = not is_plat("macosx"), type = "boolean" })
    add_configs("seluid24", { description = "Use 24 bit instead of 16 bit for selector UIDs.", default = false, type = "boolean" })
    add_configs("unicode_tables", { description = "Enable Unicode tables.", default = true, type = "boolean" })

    add_configs("codepage_437", { description = "Enable codepage 437 support.", default = true, type = "boolean" })
    add_configs("codepage_850", { description = "Enable codepage 850 support.", default = true, type = "boolean" })
    add_configs("codepage-858", { description = "Enable codepage 858 support.", default = true, type = "boolean" })
    add_configs("iso_8859_2", { description = "Enable ISO-8859-2 support.", default = true, type = "boolean" })
    add_configs("iso_8859_3", { description = "Enable ISO-8859-3 support.", default = true, type = "boolean" })
    add_configs("iso_8859_15", { description = "Enable ISO-8859-15 support.", default = true, type = "boolean" })
    add_configs("koi8_r", { description = "Enable KOI8-R support.", default = true, type = "boolean" })
    add_configs("koi8_u", { description = "Enable KOI8-U support.", default = true, type = "boolean" })
    add_configs("mac_roman", { description = "Enable Mac Roman encoding support.", default = true, type = "boolean" })
    add_configs("windows_1251", { description = "Enable windows 1251 support.", default = true, type = "boolean" })
    add_configs("windows_1252", { description = "Enable windows 1252 support.", default = true, type = "boolean" })

    add_configs("threads", { description = "Enable threads.", default = true, type = "boolean" })
    add_configs("compiler_tls", { description = "Enable compiler thread local storage (TLS).", default = true, type = "boolean" })
    add_configs("files", { description = "Enable files.", default = true, type = "boolean" })
    add_configs("sockets", { description = "Enable sockets.", default = true, type = "boolean" })

    add_configs("arc", { description = "Enable Automatic Reference Counting (ARC) support.", default = true, type = "boolean" })

    on_load(function (package)
        local tls = package:config("tls")
        if type(tls) == "boolean" then
            if tls then
                package:add("deps", "openssl")
            end
        elseif tls then
            if tls == "openssl" then
                package:add("deps", "openssl")
            elseif tls == "securetransport" then
                package:add("frameworks", "Security")
            elseif tls == "gnutls" then
                --gnutls is not on xrepo so just add links
                -- package:add("links", "gnutls")
                package:add("deps", "gnutls")
            end
        end
    end)

    on_install("linux", "macosx", function (package)
        local configs = {}
        local tls = package:config("tls")
        if type(tls) == "boolean" then
            tls = tls and "yes" or "no"
        end
        table.insert(configs, "--with-tls=" .. tls)
        table.insert(configs, "--enable-shared=" .. (package:config("shared") and "yes" or "no"))
        table.insert(configs, "--enable-static=" .. (package:config("shared") and "no" or "yes"))
        for name, enabled in pairs(package:configs()) do
            if not package:extraconf("configs", name, "builtin") and name ~= "arc" then
                name = name:gsub("_", "-")
                if enabled then
                    table.insert(configs, "--enable-" .. name)
                else
                    table.insert(configs, "--disable-" .. name)
                end
            end
        end

        -- SecureTransport must be handled by system so we don't worry about providing CFLAGS and LDFLAGS
        local ssl = package:dep("openssl") or package:dep("gnutls")
        if ssl then
            table.insert(configs, "CPPFLAGS=-I"..ssl:installdir("include"))
            table.insert(configs, "LDFLAGS=-L"..ssl:installdir("lib"))
        end

        import("package.tools.autoconf").install(package, configs)

        local mflags = {}
        local mxxflags = {}
        local ldflags = {}
        local objfwcfg = path.join(package:installdir("bin"), "objfw-config")
        local mflags_str = os.iorunv(objfwcfg, {"--cflags", "--cppflags", "--objcflags", (package:config("arc") and "--arc" or "")})
        local mxxflags_str = os.iorunv(objfwcfg, {"--cxxflags", "--cppflags", "--objcflags", (package:config("arc") and "--arc" or "")})
        local ldflags_str = os.iorunv(objfwcfg, {"--ldflags", "--libs"})
        table.join2(mflags, mflags_str:split("%s+"))
        table.join2(mxxflags, mxxflags_str:split("%s+"))
        table.join2(ldflags, ldflags_str:split("%s+"))

        print("MFlags: ", mflags)
        print("MXXFlags: ", mxxflags)
        print("LDFlags: ", ldflags)
        package:add("mflags", mflags)
        package:add("mxxflags", mxxflags)
        package:add("ldflags", ldflags)

        if package:config("runtime") then
            package:add("links", {"objfw", "objfwrt", (package:config("tls") and "objfwtls" or nil)})
        else
            package:add("links", {"objfw", (package:config("tls") and "objfwtls" or nil)})
        end
    end)

    on_test(function (package)
        assert(package:check_msnippets({test = [[
            void test() {
                OFString* string = @"hello";
                [OFStdOut writeLine: string];
            }
        ]]}, {includes = {"ObjFW/ObjFW.h"}}))
    end)
package_end()
