#include "Thor.h"

#include "Thor/Cache/TSCache.h"

@implementation Thor

+ (OFArray<TSCommunity *> *)communities
{
    OFDictionary<OFString *, id> *json;
    volatile auto cache = TSCache.sharedCache.cacheFiles;
    auto file = cache[@"communities"];

    if (file == nil) {
        [OFStdOut writeLine: @"Downloading communities..."];
        file = [TSCache.sharedCache createFileNamed: @"communities"];
        auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: $assert_nonnil(TSCommunity.url)]];
        [file asyncWriteString: resp];
        json = resp.objectByParsingJSON;
    } else {
        [OFStdOut writeLine: @"Loading communities from cache..."];
        json = [OFString stringWithData: $assert_nonnil([file readDataUntilEndOfStream]) encoding: OFStringEncodingUTF8].objectByParsingJSON;
    }

    json = json[@"results"];
    auto communities = [OFMutableArray<TSCommunity *> array];
    for (OFDictionary *result in json)
        [communities addObject: [TSCommunity modelFromJSON: result]];

    return communities;
}

@end
