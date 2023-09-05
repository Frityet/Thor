#import "Common/common.h"
#include "ObjFW/OFApplication.h"

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#import "Thor/Thor.h"

#import "ArgumentParsing.h"

static void LoadingAnimation(OFString *text)
{
    static const char *const SPINNERS[][64] = {
        { "←", "↖", "↑", "↗", "→", "↘", "↓", "↙" },
        { "▁", "▃", "▄", "▅", "▆", "▇", "█", "▇", "▆", "▅", "▄", "▃" },
        { "▉", "▊", "▋", "▌", "▍", "▎", "▏", "▎", "▍", "▌", "▋", "▊", "▉" },
        { "▖", "▘", "▝", "▗"},
        { "▌", "▀", "▐", "▄" },
        { "┤", "┘", "┴", "└", "├", "┌", "┬", "┐" },
        { "◢", "◣", "◤", "◥" },
        { "◰", "◳", "◲", "◱" },
        { "◴", "◷", "◶", "◵" },
        { "◐", "◓", "◑", "◒" },
        { "|", "/", "-", "\\" },
        { "◡◡", "◡⊙", "⊙⊙", "⊙◠", "◠◠" },
        { "◜ ", " ◝", " ◞", "◟ " },
        { "◇", "◈", "◆" },
        { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        { ">))'>    ", " >))'>   ", "  >))'>  ", "   >))'> ", "    >))'>", "   <'((<", "  <'((< ", " <'((<  ", "<'((<    " },
        {
            "▰▱▱▱▱▱▱▱▱▱", "▱▰▱▱▱▱▱▱▱▱", "▱▱▰▱▱▱▱▱▱▱", "▱▱▱▰▱▱▱▱▱▱", "▱▱▱▱▰▱▱▱▱▱", "▱▱▱▱▱▰▱▱▱▱", "▱▱▱▱▱▱▰▱▱▱", "▱▱▱▱▱▱▱▰▱▱", "▱▱▱▱▱▱▱▱▰▱", "▱▱▱▱▱▱▱▱▱▰",
            "▱▱▱▱▱▱▱▱▰▱", "▱▱▱▱▱▱▱▰▱▱", "▱▱▱▱▱▱▰▱▱▱", "▱▱▱▱▱▰▱▱▱▱", "▱▱▱▱▰▱▱▱▱▱", "▱▱▱▰▱▱▱▱▱▱", "▱▱▰▱▱▱▱▱▱▱", "▱▰▱▱▱▱▱▱▱▱", "▰▱▱▱▱▱▱▱▱▱",
        },
        { "▉▊▋▌▍▎▏▎▍▌▋▊▉", "▌▍▎▏▎▍▌▋▊▉▊▋▌▍", "▎▏▎▍▌▋▊▉▊▋▌▍▎▏", "▍▌▋▊▉▊▋▌▍▎▏▎▍▌", "▋▊▉▊▋▌▍▎▏▎▍▌▋▊", "▊▉▊▋▌▍▎▏▎▍▌▋▊▉", "▉▊▋▌▍▎▏▎▍▌▋▊▉▊" },
        {
            "█▁▁▁▁▁▁▁▁▁", "▁█▁▁▁▁▁▁▁▁", "▁▁█▁▁▁▁▁▁▁", "▁▁▁█▁▁▁▁▁▁", "▁▁▁▁█▁▁▁▁▁", "▁▁▁▁▁█▁▁▁▁", "▁▁▁▁▁▁█▁▁▁", "▁▁▁▁▁▁▁█▁▁", "▁▁▁▁▁▁▁▁█▁", "▁▁▁▁▁▁▁▁▁█",
            "▁▁▁▁▁▁▁▁█▁", "▁▁▁▁▁▁▁█▁▁", "▁▁▁▁▁▁█▁▁▁", "▁▁▁▁▁█▁▁▁▁", "▁▁▁▁█▁▁▁▁▁", "▁▁▁█▁▁▁▁▁▁", "▁▁█▁▁▁▁▁▁▁", "▁█▁▁▁▁▁▁▁▁", "█▁▁▁▁▁▁▁▁▁",
        },
        {
            "100000000", "010000000", "001000000", "000100000", "000010000", "000001000", "000000100", "000000010", "000000001",
            "000000010", "000000100", "000001000", "000010000", "000100000", "001000000", "010000000", "100000000",
        },
        {
            "▓░░░░░░░░", "░▓░░░░░░░", "░░▓░░░░░░", "░░░▓░░░░░", "░░░░▓░░░░", "░░░░░▓░░░", "░░░░░░▓░░", "░░░░░░░▓░", "░░░░░░░░▓",
            "░░░░░░░▓░", "░░░░░░▓░░", "░░░░░▓░░░", "░░░░▓░░░░", "░░░▓░░░░░", "░░▓░░░░░░", "░▓░░░░░░░", "▓░░░░░░░░",
        },
        {
            "*         ", " *        ", "  *       ", "   *      ", "    *     ", "     *    ", "      *   ", "       *  ", "        * ", "         *", "          ",
            "         *", "        * ", "       *  ", "      *   ", "     *    ", "    *     ", "   *      ", "  *       ", " *        ", "*         "
        },
        { "o         ", " 0        ", "  o       ", "   0      ", "    o     ", "     0    ", "      o   ", "       0  ", "        o ", "         0", "        o ", "       0  ", "      o   ", "     0    ", "    o     ", "   0      ", "  o       ", " 0        ", "o         ", },
        { "|         ", " /        ", "  -       ", "   \\      ", "    |     ", "     /    ", "      -   ", "       \\  ", "        | ", "         /", "        - ", "       \\  ", "      |   ", "     /    ", "    -     ", "   \\      ", "  |       ", " /        ", "|         ", },
        { "▁         ", " ▂        ", "  ▃       ", "   ▄      ", "    ▅     ", "     ▆    ", "      ▇   ", "       █  ", "        ▇ ", "         ▆", "        ▅ ", "       ▄  ", "      ▃   ", "     ▂    ", "    ▁     ", "   ▂      ", "  ▃       ", " ▄        ", "▅         ", },
        { "|         ", " ||       ", "  |||     ", "   ||||   ", "    ||||| ", "     ||||", "     |||| ", "      ||| ", "       || ", "        | ", "       || ", "      ||| ", "     |||| ", "    ||||| ", "   ||||   ", "  |||     ", " |||      ", "|||       ", "||        ", "|         ", },
        {
            "         ",
            "=        ",
            "==       ",
            "===      ",
            "====     ",
            "=====    ",
            "======   ",
            "=======  ",
            "======== ",
            "=========",
            " ========",
            "  =======",
            "   ======",
            "    =====",
            "     ====",
            "      ===",
            "       ==",
            "        =",
            "         ",
            "        =",
            "       ==",
            "      ===",
            "     ====",
            "    =====",
            "   ======",
            "  =======",
            " ========",
            "=========",
            "======== ",
            "=======  ",
            "======   ",
            "=====    ",
            "====     ",
            "===      ",
            "==       ",
            "=        ",
            "         "
        },

        {0}
    };

    static int spinner_index = 0, spinner_frame = 0;

    const char *current_frame = SPINNERS[spinner_index][spinner_frame];

    //if null, skip this spinner
    if (current_frame == nullptr) {
        spinner_frame = 0;
        spinner_index = (spinner_index + 1) % (sizeof(SPINNERS) / sizeof(SPINNERS[0]) - 1);
        current_frame = SPINNERS[spinner_index][spinner_frame];
    }

    [OFStdOut writeFormat: @"\033[2K%@ [%s]\r", text, current_frame];

    spinner_frame = (spinner_frame + 1) % (sizeof(SPINNERS[0]) / sizeof(SPINNERS[0][0]) - 1);

    if (spinner_frame == 0)
        spinner_index = (spinner_index + 1) % (sizeof(SPINNERS) / sizeof(SPINNERS[0]) - 1);
}

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
    auto search = $assert_type(args[@"mod"], OFString).lowercaseString;
    auto community = [Thor communityWithSlug: $assert_type(args[@"community"], OFString)];

    bool showVersions = args[@"versions"] != nil;

    if (community == nil) {
        [OFStdErr writeFormat: @"Community %@ not found.\n", args[@"community"]];
        return @(1);
    }

    auto choices = [OFMutableArray<TSMod *> array];
    for (TSMod *mod in community.mods) {
        auto pkgid = mod.fullName.lowercaseString;
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
    bool multiThread = args[@"multi_threaded"] != nil;

    if ([scope isEqual: @"database"]) {
        [OFStdOut writeLine: @"Updating database..."];
        [Thor updateDatabase];

        if (fetchMods) {
            [OFStdOut writeLine: @"Updating mod database..."];
            [OFStdOut writeFormat: @"\033[?25l"];
            if (multiThread) {
                auto promises = [OFMutableArray<Promise<OFArray<TSMod *> *> *> array];

                for (TSCommunity *community in Thor.communities)
                    [promises addObject: [community fetchModsAsync]];

                while (true) {
                    size_t waitingFor = 0;
                    for (Promise<OFArray<TSMod *> *> *promise in promises) {
                        if (!promise.isResolved)
                            waitingFor++;
                    }
                    LoadingAnimation([OFString stringWithFormat: @"Waiting for mods to be fetched (%zu/%zu (%.2f%%) fetched)...", promises.count - waitingFor, promises.count, ((float)(promises.count - waitingFor) / (float)promises.count) * 100.0f]);

                    if (waitingFor == 0)
                        break;

                    [OFThread sleepForTimeInterval: 0.1];
                }
            } else {

                __block auto timer = [OFDate date];
                __block size_t nCompleted = 0;
                __block OFString *currentlyFetching;

                auto thr = [Promise<OFArray<OFArray<TSMod *> *> *> promiseWithBlock: ^{
                    auto arr = [OFMutableArray<OFArray<TSMod *> *> array];

                    for (TSCommunity *community in Thor.communities) {
                        currentlyFetching = community.name;
                        [arr addObject: [community mods]];
                        timer = [OFDate date];
                        nCompleted++;
                    }

                    return arr;
                }];

                while (!thr.isResolved) {
                    LoadingAnimation([OFString stringWithFormat: @"Waiting for %@ to be fetched (%zu/%zu (%.2f%%) taken %.2f seconds)...", currentlyFetching, nCompleted, Thor.communities.count, ((float)nCompleted / (float)Thor.communities.count) * 100.0f, [timer timeIntervalSinceNow] * -1]);
                    [OFThread sleepForTimeInterval: 0.1];
                }
            }

            //turn on cursor
            [OFStdOut writeFormat: @"\033[?25h\n"];
        }
    } else if ([scope isEqual: @"mods"]) {
        [OFStdOut writeLine: @"Updating mods..."];
    } else {
        [OFStdErr writeFormat: @"Unknown scope: %@\n", scope];
        return @(1);
    }


    [OFStdOut writeLine: @"\x1b[32mDone!\x1b[0m"];
    return @(0);
}

- (OFNumber *)profileWithArguments: (OFDictionary<OFString *, id> *)args
{
    [OFStdOut writeLine: @"Getting profile..."];
    [OFStdOut writeFormat: @"%@\n", args];

    OFNumber *code = executeCommands(args, @"profile-action", (struct CommandInformation []) {
        { .name = @"delete", .selector = @selector(deleteProfileWithArguments:), .object = self },
        { .name = @"list", .selector = @selector(listProfilesWithArguments:), .object = self },
        { .name = @"create", .selector = @selector(createProfileWithArguments:), .object = self },
        {0}
    });

    return code;
}

- (void)applicationDidFinishLaunching: (OFNotification*)notification
{
    auto alloc = [FastPoolAllocator allocator];

    auto arr = [[OFMutableArray<OFString *> allocWithAllocator: alloc] init];

    for (size_t i = 0; i < 100000; i++) {
        [arr addObject: [[OFString allocWithAllocator: alloc] initWithFormat: @"%zu", i]];
    }

    [OFApplication terminate];
    auto lua = luaL_newstate();
    luaL_openlibs(lua);
    auto arguments = parseArguments(lua, $assert_nonnil(OFApplication.arguments), $assert_nonnil(OFApplication.programName));
    lua_close(lua);

    OFNumber *code;
    @try {
        code = executeCommands(arguments, @"action", (struct CommandInformation []) {
            { .name = @"list", .selector = @selector(listWithArguments:), .object = self },
            { .name = @"info", .selector = @selector(infoWithArguments:), .object = self },
            { .name = @"update", .selector = @selector(updateWithArguments:), .object = self },
            { .name = @"profile", .selector = @selector(profileWithArguments:), .object = self },
            {0}
        });
    } @catch(OFException *ex) {
        [OFStdErr writeLine: @"\x1b[31mAn error occured!\x1b[0m"];
        [OFStdErr writeFormat: @"\x1b[31m%@: %@\x1b[0m\n", ex.className, ex.description];
        [OFStdErr writeFormat: @"Stack trace: \n%@\n", ex.stackTraceSymbols];
    }
    [OFApplication terminateWithStatus: code.unsignedIntValue];
}

@end

OF_APPLICATION_DELEGATE(ThorCLI);
