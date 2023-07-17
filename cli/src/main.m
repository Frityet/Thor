#include "Common/common.h"

#include "Thor/Thor.h"

@interface ThorCLI : OFObject<OFApplicationDelegate> @end

@implementation ThorCLI

- (void)applicationDidFinishLaunching: (OFNotification*)notification
{
    auto communities = Thor.communities;

    for (TSCommunity *community in communities) {
        [OFStdOut writeFormat: @"Found community: %@\n", community.name];
        [OFStdOut writeFormat: @"  ID: %@\n", community.identifier];
        [OFStdOut writeFormat: @"  Discord URL: %@\n", community.discordURL];
        [OFStdOut writeFormat: @"  Wiki URL: %@\n", community.wikiURL];

        auto categories = community.categories;
        [OFStdOut writeFormat: @"  Categories:\n"];
        for (TSCategory *category in categories)
            [OFStdOut writeFormat: @"    %@\n", category.name];

    }

    [OFApplication terminate];
}

@end

OF_APPLICATION_DELEGATE(ThorCLI);
