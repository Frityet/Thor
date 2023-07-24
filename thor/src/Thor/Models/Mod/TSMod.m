#include "TSMod.h"

@implementation TSModNotFoundException

+ (instancetype)exceptionWithModName:(OFString *)modName ownedBy: (OFString *)owner inCommunity: (OFString *)community
{ return [[self alloc] initWithModName: modName ownedBy: owner inCommunity: community]; }

- (instancetype)initWithModName:(OFString *)modName ownedBy: (OFString *)owner inCommunity: (OFString *)community
{
    if ((self = [super init]) == nil)
        return nil;

    self->_name = modName;
    self->_owner = owner;
    self->_community = community;

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"Mod not found: %@-%@ in community: %@", self.name, self.owner, self.community]; }

@end

@implementation TSModVersionNotFoundException

+ (instancetype)exceptionWithModName:(OFString *)modName ownedBy: (OFString *)owner version: (Version)version inCommunity: (OFString *)community
{ return [[self alloc] initWithModName: modName ownedBy: owner version: version inCommunity: community]; }

- (instancetype)initWithModName:(OFString *)modName ownedBy: (OFString *)owner version: (Version)version inCommunity: (OFString *)community
{
    if ((self = [super init]) == nil)
        return nil;

    self->_name = modName;
    self->_owner = owner;
    self->_version = version;
    self->_community = community;

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"Mod not found: %@-%@ v%@ in community: %@", self.name, self.owner, VersionToString(self.version), self.community]; }

@end

@implementation TSMod {
    OFMutableArray<TSModVersion *> *_versions;
}

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

    self->_versions = [OFMutableArray array];
    for (OFDictionary *ver in $assert_nonnil($json_field(json, @"versions", OFArray<OFDictionary *>)))
        [self->_versions addObject: [TSModVersion modelFromJSON: ver]];

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

- (OFString *)formattedDescription
{ return [self formattedDescriptionWithIndentationLevel: 0]; }

- (OFString *)formattedDescriptionWithIndentationLevel:(size_t)level
{ return [self formattedDescriptionWithIndentationLevel: level showVersions: true]; }

- (OFString *)formattedDescriptionWithIndentationLevel:(size_t)level showVersions: (bool)showVersions
{
    auto str = [OFMutableString string];
    [str appendWithIndentationLevel: level format: @"Name: %@\n", self.name];
    [str appendWithIndentationLevel: level format: @"Full Name: %@\n", self.fullName];
    [str appendWithIndentationLevel: level format: @"Owner: %@\n", self.owner];
    [str appendWithIndentationLevel: level format: @"URL: %@\n", self.packageURL.string];
    [str appendWithIndentationLevel: level format: @"Date Created: %@\n", self.dateCreated];
    [str appendWithIndentationLevel: level format: @"Date Updated: %@\n", self.dateUpdated];
    [str appendWithIndentationLevel: level format: @"Rating Score: %u\n", self.ratingScore];
    [str appendWithIndentationLevel: level format: @"Is Pinned: %@\n", self.isPinned ? @"Yes" : @"No"];
    [str appendWithIndentationLevel: level format: @"Is Deprecated: %@\n", self.isDeprecated ? @"Yes" : @"No"];
    [str appendWithIndentationLevel: level format: @"Has NSFW Content: %@\n", self.hasNSFWContent ? @"Yes" : @"No"];
    [str appendWithIndentationLevel: level format: @"Categories:\n"];
    for (OFString *cat in self.categories)
        [str appendWithIndentationLevel: level + 2 format: @"- %@\n", cat];

    if (showVersions) {
        [str appendWithIndentationLevel: level format: @"Versions: \n"];
        for (TSModVersion *ver in self.versions)
            [str appendString: [ver formattedDescriptionWithIndentationLevel: level + 2]];
    }

    [str makeImmutable];
    return str;
}

@end
