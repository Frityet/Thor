#include "TSCommunity.h"


@implementation TSCommunity

@synthesize categories = _categories;

+ (instancetype)modelFromJSON: (OFDictionary *)json
{ return [[self alloc] initWithJSON: json]; }

- (instancetype)initWithJSON:(OFDictionary *)json
{
    if ((self = [super init]) == nil)
        return nil;

    self->_identifier = $assert_nonnil($json_field(json, @"identifier", OFString));
    self->_name = $assert_nonnil($json_field(json, @"name", OFString));
    self->_discordURL = $json_field(json, @"discord_url", OFString);
    self->_wikiURL = $json_field(json, @"wiki_url", OFString);
    self->_requirePackageListingApproval = $json_field(json, @"require_package_listing_approval", OFNumber).boolValue;
    return self;
}

+ (OFString *)url
{ return @"https://thunderstore.io/api/experimental/community/"; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *,OFString *> *)_
{ return $assert_nonnil(self.url); }

- (OFArray<TSCategory *> *)categories
{
    if (self->_categories == nil)
    {
        auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [OFString stringWithFormat: @"https://thunderstore.io/api/experimental/community/%@/category/", self->_identifier]]];
        auto json = (OFDictionary *)[resp objectByParsingJSON];

        auto results = $assert_nonnil($json_field(json, @"results", OFArray<OFDictionary *>));

        auto cats = [OFMutableArray array];
        for (OFDictionary *result in results)
            [cats addObject: [TSCategory modelFromJSON: result]];

        self->_categories = cats;
    }
    return self->_categories;
}

@end
