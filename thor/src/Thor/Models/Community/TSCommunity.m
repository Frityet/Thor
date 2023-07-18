#include "TSCommunity.h"
#include "Thor/Cache/TSCache.h"


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

+ (instancetype)communityFromIdentifier:(OFString *)identifier
{ return [[self alloc] initFromIdentifier: identifier]; }

- (instancetype)initFromIdentifier:(OFString *)identifier
{ return [self initWithJSON: (OFDictionary *)[OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSCommunity urlWithParametres: @{ @"community": identifier }]]].objectByParsingJSON]; }

+ (OFString *)url
{ return @"https://thunderstore.io/api/experimental/community/"; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *,OFString *> *)params
{ return [OFString stringWithFormat: @"https://%@.thunderstore.io/api/experimental/current-community/", params[@"community"]]; }

- (OFArray<TSCommunityCategory *> *)categories
{
    //CACHE EVERYTHING
    if (self->_categories == nil) {
        const auto fname = [OFString stringWithFormat: @"%@.categories", self.identifier];
        auto file = TSCache.sharedCache[fname];
        if (file != nil)
        {
            auto json = (OFDictionary *)[OFString stringWithData: $assert_nonnil([file readDataUntilEndOfStream]) encoding: OFStringEncodingUTF8].objectByParsingJSON;

            auto results = $assert_nonnil($json_field(json, @"results", OFArray<OFDictionary *>));

            auto cats = [OFMutableArray array];
            for (OFDictionary *result in results)
                [cats addObject: [TSCommunityCategory modelFromJSON: result]];

            self->_categories = cats;
        } else {
            auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSCommunityCategory urlWithParametres: @{ @"community": self.identifier }]]];
            auto json = (OFDictionary *)[resp objectByParsingJSON];
            file = [TSCache.sharedCache createFileNamed: fname];
            [file writeString: resp];

            auto results = $assert_nonnil($json_field(json, @"results", OFArray<OFDictionary *>));

            auto cats = [OFMutableArray array];
            for (OFDictionary *result in results)
                [cats addObject: [TSCommunityCategory modelFromJSON: result]];


            self->_categories = cats;
        }
    }

    return self->_categories;
}

- (TSPackage *) packageWithNamespace: (OFString *)ns name: (OFString *)name
{
    auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSPackage urlWithParametres: @{ @"community": self.identifier, @"namespace": ns, @"name": name }]]];
    auto json = (OFDictionary *)[resp objectByParsingJSON];

    return [TSPackage modelFromJSON: json];
}

- (OFString *)description
{
    return [OFString stringWithFormat: @"<%@: %@>", self.className, self.identifier];
}

@end
