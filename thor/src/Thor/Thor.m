#include "Thor.h"
#include "ObjFW/OFHTTPRequest.h"

@implementation Thor

+ (OFArray<TSCommunity *> *)communities
{
    static OFMutableArray<TSCommunity *> *communities = nil;
    if (communities != nil)
        return communities;
    communities = [OFMutableArray array];

    auto json = (OFDictionary *)[OFString stringWithContentsOfIRI: [OFIRI IRIWithString: $assert_nonnil(TSCommunity.url)]].objectByParsingJSON;

    auto results = $json_field(json, @"results", OFArray<OFDictionary *>);
    for (OFDictionary *result in results)
        [communities addObject: [TSCommunity modelFromJSON: result]];

    return communities;
}

@end
