#include "TSCommunity.h"
#include "ObjFW/OFStdIOStream.h"
#import "Thor/Cache/TSCache.h"

#import "Common/Promise.h"
#import "Common/AsyncHTTP.h"

@implementation TSCommunityNotFoundException

+ (instancetype)exceptionWithCommunity:(OFString *)community
{ return [[self alloc] initWithCommunity: community]; }

- (instancetype)initWithCommunity:(OFString *)community
{
    self = [super init];


    self->_community = community;

    return self;
}

- (OFString *)description
{
    return [OFString stringWithFormat: @"Could not find community with identifier \"%@\".", self.community];
}

@end

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
    self = [super init];

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
{
    OFString *contents;
    @try {
        contents = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSCommunity urlWithParametres: @{ @"community": identifier }]]];
    } @catch(OFException *) {
        contents = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSCommunity urlWithParametres: @{ @"community": identifier, @"new": @"" }]]];
    }

    return [self initWithJSON: (OFDictionary *)ParseJSON(contents)];
}

+ (OFString *)url
{ return @"https://thunderstore.io/api/experimental/community/"; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *,OFString *> *)params
{
    auto newFmt = params[@"new"] != nil;

    if (newFmt)
        return [OFString stringWithFormat: @"https://thunderstore.io/c/%@/api/experimental/current-community/", params[@"community"]];
    else
        return [OFString stringWithFormat: @"https://%@.thunderstore.io/api/experimental/current-community/", params[@"community"]];
}

- (OFArray<TSCommunityCategory *> *)categories
{
    //CACHE EVERYTHING
    if (self->_categories == nil) {
        auto fname = [OFString stringWithFormat: @"%@.categories", self.identifier];
        auto file = TSCache.sharedCache[fname];
        if (file != nil) {
            auto json = (OFDictionary *)ParseJSON([OFString stringWithData: $assert_nonnil([file readDataUntilEndOfStream]) encoding: OFStringEncodingUTF8]);

            auto results = $assert_nonnil($json_field(json, @"results", OFArray<OFDictionary *>));

            self->_categories = [OFMutableArray arrayWithCapacity: results.count];
            for (OFDictionary *result in results)
                [self->_categories addObject: [TSCommunityCategory modelFromJSON: result]];
        } else {
            auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSCommunityCategory urlWithParametres: @{ @"community": self.identifier }]]];
            auto json = (OFDictionary *)ParseJSON(resp);
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
            [OFStdOut writeFormat: @"Fetching %@ from %@\n", fname, url.string];

            #if PROJECT_DEBUG
            [OFStdOut writeFormat: @"Reading %@ from cache...\n", fname];
            auto date = [OFDate date];
            #endif

            OFString *resp;
            OFArray<OFDictionary *> *json;
            @try {
                resp = [OFString stringWithContentsOfIRI: url];
                #if PROJECT_DEBUG
                [OFStdOut writeFormat: @"Downloaded %@ in %f seconds.\n", fname, date.timeIntervalSinceNow * -1];
                #endif
                json = $assert_type(resp.objectByParsingJSON, OFArray<OFDictionary *>);
            } @catch(OFException *) {
                url = [OFIRI IRIWithString: [TSMod urlWithParametres: @{ @"community": self.identifier, @"new": @"" }]];
                resp = [OFString stringWithContentsOfIRI: url];
                #if PROJECT_DEBUG
                [OFStdOut writeFormat: @"Downloaded %@ in %f seconds.\n", fname, date.timeIntervalSinceNow * -1];
                #endif
                json = $assert_type(resp.objectByParsingJSON, OFArray<OFDictionary *>);
            }

            file = [TSCache.sharedCache createFileNamed: fname];
            [file writeString: resp];

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

- (Promise<OFArray<TSMod *> *> *)fetchModsAsync
{
    return [Promise promiseWithBlock: ^{
        if (self->_mods == nil) {
            auto fname = [OFString stringWithFormat: @"%@.packages", self.identifier];

            auto file = TSCache.sharedCache[fname];
            if (file != nil) {
                #if PROJECT_DEBUG
                [OFStdOut writeFormat: @"Parsing %@ from cache as JSON...\n", fname];

                auto date = [OFDate date];
                #endif

                auto data = $assert_nonnil([file readDataUntilEndOfStream]);
                auto json = $assert_type(ParseJSON([OFString stringWithData: data encoding: OFStringEncodingUTF8]), OFArray<OFDictionary *>);

                #if PROJECT_DEBUG
                [OFStdOut writeFormat: @"\rParsed %@ (%d entries) from cache as JSON (size: %zu) in %f seconds.\n", fname, json.count, data.count * data.itemSize, date.timeIntervalSinceNow * -1];
                #endif

                self->_mods = [OFMutableArray<TSMod *> arrayWithCapacity: json.count];
                for (OFDictionary *result in json)
                    [self->_mods addObject: [TSMod modelFromJSON: result]];
            } else {
                auto url = [OFIRI IRIWithString: [TSMod urlWithParametres: @{ @"community": self.identifier }]];
                [OFStdOut writeFormat: @"\033[2KFetching %@ from %@\n", [@"cache" stringByAppendingPathComponent: fname], url.string];

                #if PROJECT_DEBUG
                auto date = [OFDate date];
                #endif

                OFString *resp;
                OFArray<OFDictionary *> *json;
                @try {
                    resp = [OFString stringWithContentsOfIRI: url];
                    #if PROJECT_DEBUG
                    [OFStdOut writeFormat: @"Downloaded %@ in %f seconds.\n", fname, date.timeIntervalSinceNow * -1];
                    #endif

                    json = $assert_type(ParseJSON(resp), OFArray<OFDictionary *>);

                    #if PROJECT_DEBUG
                    [OFStdOut writeFormat: @"Parsed %@ (%d entries) from cache as JSON (size: %zu) in %f seconds.\n", fname, json.count, resp.UTF8StringLength, date.timeIntervalSinceNow * -1];
                    #endif

                } @catch(OFException *) {
                    url = [OFIRI IRIWithString: [TSMod urlWithParametres: @{ @"community": self.identifier, @"new": @"" }]];
                    resp = [OFString stringWithContentsOfIRI: url];
                    #if PROJECT_DEBUG
                    [OFStdOut writeFormat: @"Downloaded %@ in %f seconds.\n", fname, date.timeIntervalSinceNow * -1];
                    #endif
                    json = $assert_type(ParseJSON(resp), OFArray<OFDictionary *>);

                    #if PROJECT_DEBUG
                    [OFStdOut writeFormat: @"Parsed %@ (%d entries) from cache as JSON (size: %zu) in %f seconds.\n", fname, json.count, resp.UTF8StringLength, date.timeIntervalSinceNow * -1];
                    #endif
                }

                file = [TSCache.sharedCache createFileNamed: fname];
                [file writeString: resp];

                self->_mods = [OFMutableArray<TSMod *> arrayWithCapacity: json.count];
                for (OFDictionary *result in json)
                    [self->_mods addObject: [TSMod modelFromJSON: result]];

                #if PROJECT_DEBUG
                [OFStdOut writeFormat: @"Read %@ (%d entries) from cache in %f seconds.\n", fname, self->_mods.count, date.timeIntervalSinceNow * -1];
                #endif
            }
        }

        return self->_mods;
    }];
}

- (void)client:(OFHTTPClient *)client didPerformRequest:(nonnull OFHTTPRequest *)request response:(nullable OFHTTPResponse *)response exception:(nullable id)exception
{

}

- (TSMod *) modWithAuthor: (OFString *)ns name: (OFString *)name
{
    auto resp = [OFString stringWithContentsOfIRI: [OFIRI IRIWithString: [TSMod urlWithParametres: @{ @"community": self.identifier, @"author": ns, @"name": name }]]];
    auto json = (OFDictionary *)ParseJSON(resp);

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
