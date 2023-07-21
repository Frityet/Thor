#include "TSCommunity.h"
#include "Thor/Cache/TSCache.h"


@implementation TSCommunity {
    OFMutableArray<TSCommunityCategory *> *_categories;
    OFMutableArray<TSMod *> *_mods;
}

@synthesize categories = _categories;
@synthesize mods = _mods;

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
        auto fname = [OFString stringWithFormat: @"%@.categories", self.identifier];
        auto file = TSCache.sharedCache[fname];
        if (file != nil) {
            auto json = (OFDictionary *)[OFString stringWithData: $assert_nonnil([file readDataUntilEndOfStream]) encoding: OFStringEncodingUTF8].objectByParsingJSON;

            auto results = $assert_nonnil($json_field(json, @"results", OFArray<OFDictionary *>));

            self->_categories = [OFMutableArray arrayWithCapacity: results.count];
            for (OFDictionary *result in results)
                [self->_categories addObject: [TSCommunityCategory modelFromJSON: result]];
        } else {
            auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSCommunityCategory urlWithParametres: @{ @"community": self.identifier }]]];
            auto json = (OFDictionary *)[resp objectByParsingJSON];
            file = [TSCache.sharedCache createFileNamed: fname];
            [file writeString: resp];

            auto results = $assert_nonnil($json_field(json, @"results", OFArray<OFDictionary *>));

            self->_categories = [OFMutableArray arrayWithCapacity: results.count];
            for (OFDictionary *result in results)
                [self->_categories addObject: [TSCommunityCategory modelFromJSON: result]];
        }
    }

    return self->_categories;
}


- (OFArray<TSMod *> *) mods
{
    if (self->_mods == nil) {
        auto fname = [OFString stringWithFormat: @"%@.packages", self.identifier];

        auto file = TSCache.sharedCache[fname];
        if (file != nil) {
            #if PROJECT_DEBUG
            [OFStdOut writeFormat: @"Parsing %@ from cache as JSON...\n", fname];

            auto date = [OFDate date];
            #endif

            auto json = (OFArray *)[OFString stringWithData: $assert_nonnil([file readDataUntilEndOfStream]) encoding: OFStringEncodingUTF8].objectByParsingJSON;

            #if PROJECT_DEBUG
            [OFStdOut writeFormat: @"\rParsed %@ (%d entries) from cache as JSON in %f seconds.\n", fname, json.count, date.timeIntervalSinceNow * -1];
            #endif

            self->_mods = [OFMutableArray<TSMod *> arrayWithCapacity: json.count];
            for (OFDictionary *result in json)
                [self->_mods addObject: [TSMod modelFromJSON: result]];
        } else {
            auto url = [OFIRI IRIWithString: [TSMod urlWithParametres: @{ @"community": self.identifier }]];
            [OFStdOut writeFormat: @"Fetching %@ from %@...\n", fname, url.string];

            auto resp = [OFString stringWithContentsOfIRI: url];
            file = [TSCache.sharedCache createFileNamed: fname];
            [file writeString: resp];

            #if PROJECT_DEBUG
            [OFStdOut writeFormat: @"Reading %@ from cache...\n", fname];
            auto date = [OFDate date];
            #endif

            auto json = $assert_type(resp.objectByParsingJSON, OFArray<OFDictionary *>);
            self->_mods = [OFMutableArray<TSMod *> arrayWithCapacity: json.count];
            for (OFDictionary *result in json)
                [self->_mods addObject: [TSMod modelFromJSON: result]];

            #if PROJECT_DEBUG
            [OFStdOut writeFormat: @"Read %@ (%d entries) from cache in %f seconds.\n", fname, self->_mods.count, date.timeIntervalSinceNow * -1];
            #endif
        }
    }

    return self->_mods;
}

- (TSMod *) modWithAuthor: (OFString *)ns name: (OFString *)name
{
    auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSMod urlWithParametres: @{ @"community": self.identifier, @"author": ns, @"name": name }]]];
    auto json = (OFDictionary *)[resp objectByParsingJSON];

    return [TSMod modelFromJSON: json];
}

+ (instancetype)deserialize:(OFData *)data
{
    return nil;
}

- (OFData *)serialize
{
    return nil;
}

- (OFString *)description
{
    return [OFString stringWithFormat: @"<%@: %@>", self.className, self.identifier];
}

- (OFString *)formattedDescription
{ return [self formattedDescriptionWithIndentationLevel: 0]; }

- (OFString *)formattedDescriptionWithIndentationLevel:(size_t)level
{
    auto str = [OFMutableString string];

    [str appendWithIndentationLevel: level format: @"Identifier: %@\n", self.identifier];
    [str appendWithIndentationLevel: level format: @"Name: %@\n", self.name];
    [str appendWithIndentationLevel: level format: @"Discord URL: %@\n", self.discordURL];
    [str appendWithIndentationLevel: level format: @"Wiki URL: %@\n", self.wikiURL];
    [str appendWithIndentationLevel: level format: @"Require Package Listing Approval: %@\n", self.requirePackageListingApproval ? @"Yes" : @"No"];
    [str appendWithIndentationLevel: level format: @"Categories: %@\n", self.categories];

    return str;
}

@end
