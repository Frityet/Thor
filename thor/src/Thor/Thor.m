#include "Thor.h"

#include "Thor/Cache/TSCache.h"

@implementation Thor

+ (OFArray<TSCommunity *> *)communities
{
    // static OFMutableArray<TSCommunity *> *communities = nil;
    // if (communities != nil)
    //     return communities;
    // communities = [OFMutableArray array];

    // auto json = (OFDictionary *)[OFString stringWithContentsOfIRI: [OFIRI IRIWithString: $assert_nonnil(TSCommunity.url)]].objectByParsingJSON;

    // auto results = $json_field(json, @"results", OFArray<OFDictionary *>);
    // for (OFDictionary *result in results)
    //     [communities addObject: [TSCommunity modelFromJSON: result]];

    // return communities;

    OFDictionary<OFString *, id> *json;
    auto file = TSCache.sharedCache[@"communities"];
    if (file == nil) {
        [OFStdOut writeLine: @"Downloading communities..."];
        file = [TSCache.sharedCache createFileNamed: @"communities"];
        json = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: $assert_nonnil(TSCommunity.url)]].objectByParsingJSON;
        json = json[@"results"];
        [file asyncWriteString: json.JSONRepresentation];
    } else {
        [OFStdOut writeLine: @"Loading communities from cache..."];
        json = [OFString stringWithData: $assert_nonnil([file readDataUntilEndOfStream]) encoding: OFStringEncodingUTF8].objectByParsingJSON;
    }

    auto communities = [OFMutableArray<TSCommunity *> array];
    for (OFDictionary *result in json)
        [communities addObject: [TSCommunity modelFromJSON: result]];

    return communities;
}

@end
