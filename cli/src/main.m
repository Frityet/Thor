#include "Common/common.h"

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#include "Thor/Thor.h"

#include "ArgumentParsing.h"

@interface ThorCLI : OFObject<OFApplicationDelegate> @end

@implementation ThorCLI

- (id)listWithArguments: (OFDictionary<OFString *, id> *)args
{
    auto community = [Thor communityWithSlug: $assert_type(args[@"community"], OFString)];
    if (community == nil) {
        [OFStdErr writeFormat: @"Community %@ not found.\n", args[@"community"]];
        return @(1);
    }

    if ([args[@"scope"] isEqual: @"categories"]) {
        for (TSCommunityCategory *category in community.categories)
            [OFStdOut writeFormat: @"%@\n", category.name];
    } else if ([args[@"scope"] isEqual: @"mods"]) {
        [community mods];
    }

    return @(0);
}

- (id)infoWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Getting info..."];
    [OFStdOut writeFormat: @"%@\n", args];

    return @(0);
}

- (id)updateWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Updating..."];
    [OFStdOut writeFormat: @"%@\n", args];

    return @(0);
}

- (id)profileWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Getting profile..."];
    [OFStdOut writeFormat: @"%@\n", args];
    return @(0);
}

- (void)applicationDidFinishLaunching: (OFNotification*)notification
{
    auto lua = luaL_newstate();
    luaL_openlibs(lua);
    auto arguments = parseArguments(lua, $assert_nonnil(OFApplication.arguments), $assert_nonnil(OFApplication.programName));

    #define $cmd(x) { .name = @#x, .selector = @selector(x##WithArguments:), .object = self }
    OFNumber *code = executeCommands(arguments, @"action", (struct CommandInformation []) {
        $cmd(list),
        $cmd(info),
        $cmd(update),
        $cmd(profile),
        {0}
    });
    #undef $cmd

    lua_close(lua);
    [OFApplication terminateWithStatus: code.unsignedIntValue];
}

@end

OF_APPLICATION_DELEGATE(ThorCLI);
