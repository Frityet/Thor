#include "Common/common.h"
#include "Thor/Thor.h"

@interface ThorCLI : OFObject<OFApplicationDelegate> @end

@implementation ThorCLI

- (void)applicationDidFinishLaunching: (OFNotification*)notification
{
    auto args = $assert_nonnil(OFApplication.arguments);
    auto community = args[0];

    TSCommunity *h3vr;
    @try {
        h3vr = [TSCommunity communityFromIdentifier: community];
    } @catch (OFResolveHostFailedException *ex) {
        [OFStdErr writeFormat: @"Community %@ not found\n", community];
        [OFApplication terminateWithStatus: 1];
    }

    auto namespace = args[1];
    auto name = args[2];

    TSPackage *h3vrUtilities;
    @try {
        h3vrUtilities = [h3vr packageWithNamespace: namespace name: name];
    } @catch(OFHTTPRequestFailedException *ex) {
        [OFStdErr writeFormat: @"Package %@/%@ in %@ not found\n", namespace, name, community];
        [OFApplication terminateWithStatus: 1];
    }
    // TSPackage *h3vrUtilities = [h3vr packageWithNamespace: namespace name: name];

    [OFStdOut writeFormat: @"%@ v%d.%d.%d\n", h3vrUtilities.name, h3vrUtilities.latest.versionNumber.major, h3vrUtilities.latest.versionNumber.minor, h3vrUtilities.latest.versionNumber.patch];
    [OFStdOut writeFormat: @"- Description: %@\n", h3vrUtilities.latest.packageDescription];
    [OFStdOut writeFormat: @"- Download: %@\n", h3vrUtilities.latest.downloadURL];
    [OFStdOut writeFormat: @"- Website: %@\n", h3vrUtilities.latest.websiteURL];

    [OFApplication terminate];
}

@end

OF_APPLICATION_DELEGATE(ThorCLI);
