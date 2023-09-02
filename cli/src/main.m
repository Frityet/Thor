#include "Common/common.h"

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#include "Thor/Thor.h"

#include "ArgumentParsing.h"


@interface ThorCLI : OFObject<OFApplicationDelegate> @end

@implementation ThorCLI

- (OFNumber *)listWithArguments: (OFDictionary<OFString *, id> *)args
{
    OFArray<OFString *> *names      = args[@"name"] ?: @[];

    OFArray<OFString *> *cats       = args[@"category"] ?: @[],
                        *xcats      = args[@"exclude_category"] ?: @[];

    OFArray<OFString *> *authors    = args[@"author"] ?: @[],
                        *xauthors   = args[@"exclude_author"] ?: @[];

    auto community = [Thor communityWithSlug: $assert_type(args[@"community"], OFString)];
    if (community == nil) {
        [OFStdErr writeFormat: @"Community %@ not found.\n", args[@"community"]];
        return @(1);
    }

    if ([args[@"scope"] isEqual: @"categories"]) {
        for (TSCommunityCategory *category in community.categories)
            [OFStdOut writeFormat: @"- \"%@\" (%@)\n", category.name, category.slug];

    } else if ([args[@"scope"] isEqual: @"mods"]) {
        auto mods = community.mods;

        [OFStdOut writeLine: @"Mods:"];
        for (TSMod *mod in mods) {
            for (OFString *name in names) {
                if (![mod.name.lowercaseString containsString: name.lowercaseString])
                    goto next;
            }

            for (OFString *cat in cats) {
                for (OFString *v in mod.categories) {
                    if (![v.lowercaseString containsString: cat.lowercaseString])
                        goto next;
                }
            }

            for (OFString *cat in xcats) {
                for (OFString *v in mod.categories) {
                    if ([v.lowercaseString containsString: cat.lowercaseString])
                        goto next;
                }
            }

            for (OFString *author in authors) {
                if (![mod.owner.lowercaseString containsString: author.lowercaseString])
                    goto next;
            }

            for (OFString *author in xauthors) {
                if ([mod.owner.lowercaseString containsString: author.lowercaseString])
                    goto next;
            }

            [OFStdOut writeFormat: @"  - %@\n", mod.fullName];

        next:
            continue;
        }
    }

    return @(0);
}

- (OFNumber *)infoWithArguments: (OFDictionary<OFString *, id> *)args
{
    auto search = [$assert_type(args[@"mod"], OFString) lowercaseString];
    auto community = [Thor communityWithSlug: $assert_type(args[@"community"], OFString)];

    bool showVersions = args[@"versions"] != nil;

    if (community == nil) {
        [OFStdErr writeFormat: @"Community %@ not found.\n", args[@"community"]];
        return @(1);
    }

    auto choices = [OFMutableArray<TSMod *> array];
    for (TSMod *mod in community.mods) {
        auto pkgid = [mod.fullName lowercaseString];
        if ([pkgid containsString: search] or [pkgid isEqual: search])
            [choices addObject: mod];
    }

    if (choices.count > 1) {
        [OFStdOut writeLine: @"Multiple packages found: "];
        for (TSMod *mod in choices)
            [OFStdOut writeFormat: @"  - %@\n", mod.fullName];
    } else if (choices.count == 0) {
        [OFStdOut writeLine: @"No packages found with specified name"];
    } else {
        [OFStdOut writeLine: [choices[0] formattedDescriptionWithIndentationLevel: 2 showVersions: showVersions]];
    }

    return @(0);
}

- (OFNumber *)updateWithArguments: (OFDictionary<OFString *, id> *)args
{
    OFString *scope = args[@"scope"];
    bool fetchMods = args[@"fetch_mods"] != nil;

    if ([scope isEqual: @"database"]) {
        [OFStdOut writeLine: @"Updating database..."];
        [Thor updateDatabase];

        if (fetchMods) {
            [OFStdOut writeLine: @"Fetching mods..."];
            for (TSCommunity *community in Thor.communities) {
                [OFStdOut writeFormat: @"- Fetching mods for %@...\n", community.name];
                [community mods];
            }
        }
    } else if ([scope isEqual: @"mods"]) {
        [OFStdOut writeLine: @"Updating mods..."];
    } else {
        [OFStdErr writeFormat: @"Unknown scope: %@\n", scope];
        return @(1);
    }


    return @(0);
}

- (OFNumber *)profileWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Getting profile..."];
    [OFStdOut writeFormat: @"%@\n", args];

    OFNumber *code = executeCommands(args, @"profile-action", (struct CommandInformation []) {
        {0}
    });

    return @(0);
}

- (void)applicationDidFinishLaunching: (OFNotification*)notification
{
    auto lua = luaL_newstate();
    luaL_openlibs(lua);
    auto arguments = parseArguments(lua, $assert_nonnil(OFApplication.arguments), $assert_nonnil(OFApplication.programName));
    lua_close(lua);

    OFNumber *code = executeCommands(arguments, @"action", (struct CommandInformation []) {
        { .name = @"list", .selector = @selector(listWithArguments:), .object = self },
        { .name = @"info", .selector = @selector(infoWithArguments:), .object = self },
        { .name = @"update", .selector = @selector(updateWithArguments:), .object = self },
        { .name = @"profile", .selector = @selector(profileWithArguments:), .object = self },
        {0}
    });
    [OFApplication terminateWithStatus: code.unsignedIntValue];
}

@end

OF_APPLICATION_DELEGATE(ThorCLI);
