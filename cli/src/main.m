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
    [OFStdOut writeLine: @"Listing categories..."];
    [OFStdOut writeFormat: @"%@\n", args];

    auto communities = Thor.communities;
    for (TSCommunity *community in communities) {
        [OFStdOut writeFormat: @"%@:\n", community.name];
        [OFStdOut writeFormat: @"  Discord: %@\n", community.discordURL];
        [OFStdOut writeFormat: @"  Wiki: %@\n", community.wikiURL];
        [OFStdOut writeFormat: @"  Categories:\n"];
        for (TSCommunityCategory *category in community.categories)
            [OFStdOut writeFormat: @"  - %@\n", category.name];
    }

    return nil;
}

- (id)infoWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Getting info..."];
    [OFStdOut writeFormat: @"%@\n", args];

    return nil;
}

- (id)updateWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Updating..."];
    [OFStdOut writeFormat: @"%@\n", args];

    return nil;
}

- (id)profileWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Getting profile..."];
    [OFStdOut writeFormat: @"%@\n", args];
    return nil;
    // return execute_commands(args, @"profile-command", (struct CommandInformation []) {
    //     {0}
    // });
}

- (void)applicationDidFinishLaunching: (OFNotification*)notification
{
    auto lua = luaL_newstate();
    luaL_openlibs(lua);
    auto arguments = parse_arguments(lua, $assert_nonnil(OFApplication.arguments), $assert_nonnil(OFApplication.programName));

    #define $cmd(x) { .name = @#x, .selector = @selector(x##WithArguments:), .object = self }
    OFNumber *code = execute_commands(arguments, @"action", (struct CommandInformation []) {
        $cmd(list),
        $cmd(info),
        $cmd(update),
        $cmd(profile),
        {0}
    });
    #undef $cmd

    [OFApplication terminateWithStatus: code.unsignedIntValue];
}

@end

OF_APPLICATION_DELEGATE(ThorCLI);
