#include "TSPackage.h"

@implementation TSMod

+ (instancetype)modelFromJSON:(OFDictionary *)json
{ return [[self alloc] initWithJSON: json]; }

- (instancetype)initWithJSON:(OFDictionary *)json
{
    if ((self = [super init]) == nil)
        return nil;

    self->_name = $assert_nonnil($json_field(json, @"name", OFString));
    self->_fullName = $assert_nonnil($json_field(json, @"full_name", OFString));
    self->_owner = $assert_nonnil($json_field(json, @"owner", OFString));
    self->_packageURL = [OFIRI IRIWithString: $assert_nonnil($json_field(json, @"package_url", OFString))];

    //Remove all digits past the last `.` and Z
    auto created = $assert_nonnil($json_field(json, @"date_created", OFString));
    created = [created substringToIndex: [created rangeOfString: @"." options: OFStringSearchBackwards].location];

    auto updated = $assert_nonnil($json_field(json, @"date_updated", OFString));
    updated = [updated substringToIndex: [updated rangeOfString: @"." options: OFStringSearchBackwards].location];

    self->_dateCreated = [OFDate dateWithDateString: created format: @"%Y-%m-%dT%H:%M:%S"];
    self->_dateUpdated = [OFDate dateWithDateString: updated format: @"%Y-%m-%dT%H:%M:%S"];

    self->_ratingScore = $assert_nonnil($json_field(json, @"rating_score", OFNumber)).intValue;
    self->_isPinned = $assert_nonnil($json_field(json, @"is_pinned", OFNumber)).boolValue;
    self->_isDeprecated = $assert_nonnil($json_field(json, @"is_deprecated", OFNumber)).boolValue;
    self->_hasNSFWContent = $assert_nonnil($json_field(json, @"has_nsfw_content", OFNumber)).boolValue;
    self->_categories = $assert_nonnil($json_field(json, @"categories", OFArray<OFString *>));

    auto versions = [OFMutableArray array];
    for (OFDictionary *ver in $assert_nonnil($json_field(json, @"versions", OFArray<OFDictionary *>)))
        [versions addObject: [TSPackageVersion modelFromJSON: ver]];

    return self;
}

+ (OFString *)url
{ return nil; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *,OFString *> *)params
{
    auto community = params[@"community"];
    auto author = params[@"author"];
    auto name = params[@"name"];

    if (author == nil)
        //assume we want all packages, we need to use the v1 endpoint because the experiemntal one returns all packages from all communities
        return [OFString stringWithFormat: @"https://%@.thunderstore.io/api/v1/package/", community];


    return [OFString stringWithFormat: @"https://%@.thunderstore.io/api/experimental/package/%@/%@/", community, author, name];
}

- (OFString *)description
{ return [OFString stringWithFormat: @"<TSPackage: %@>", self.fullName]; }

@end
