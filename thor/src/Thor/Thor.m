#include "Thor.h"

#include "Thor/Cache/TSCache.h"

@implementation Thor

+ (OFArray<TSCommunity *> *)communities
{
    OFDictionary<OFString *, id> *json;
    auto file = TSCache.sharedCache[@"communities"];

    if (file == nil) {
        [OFStdOut writeLine: @"Downloading and caching communities..."];
        file = [TSCache.sharedCache createFileNamed: @"communities"];
        auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: $assert_nonnil(TSCommunity.url)]];
        [file asyncWriteString: resp];
        json = resp.objectByParsingJSON;
    } else {
        auto data = [OFString stringWithData: $assert_nonnil([file readDataUntilEndOfStream]) encoding: OFStringEncodingUTF8];
        json = data.objectByParsingJSON;
    }

    json = json[@"results"];
    auto communities = [OFMutableArray<TSCommunity *> array];
    for (OFDictionary *result in json)
        [communities addObject: [TSCommunity modelFromJSON: result]];

    return communities;
}

+ (TSCommunity *)communityWithSlug:(OFString *)slug
{
    auto communities = self.communities;

    for (TSCommunity *community in communities)
        if ([community.identifier isEqual: slug])
            return community;

    return nil;
}

+ (void)updateDatabase
{
    [TSCache.sharedCache clear];
    [self communities]; //Load communities
}

@end
