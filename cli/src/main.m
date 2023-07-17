#include "Common/common.h"

#include "Thor/Thor.h"

@interface ThorCLI : OFObject<OFApplicationDelegate> @end

@implementation ThorCLI

- (void)applicationDidFinishLaunching: (OFNotification*)notification
{
    auto h3vr = [TSCommunity communityFromIdentifier: @"h3vr"];
    auto h3vrUtilities = [h3vr packageWithNamespace: @"WFIOST" name: @"H3VRUtilities"];

    if (h3vrUtilities == nil) {
        [OFStdErr writeLine: @"H3VRUtilities not found"];
        return;
    }

    [OFStdOut writeFormat: @"%@ v%d.%d.%d\n", h3vrUtilities.name, h3vrUtilities.latest.versionNumber.major, h3vrUtilities.latest.versionNumber.minor, h3vrUtilities.latest.versionNumber.patch];
    [OFStdOut writeFormat: @"%@\n", h3vrUtilities.latest.packageDescription];

    [OFApplication terminate];
}

@end

OF_APPLICATION_DELEGATE(ThorCLI);
