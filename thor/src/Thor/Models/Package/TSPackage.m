#include "TSPackage.h"

@implementation TSPackage

+ (instancetype)modelFromJSON:(OFDictionary *)json
{ return [[self alloc] initWithJSON: json]; }

- (instancetype)initWithJSON:(OFDictionary *)json
{
    if ((self = [super init]) == nil)
        return nil;

    self->_namespace = $assert_nonnil($json_field(json, @"namespace", OFString));
    self->_name = $assert_nonnil($json_field(json, @"name", OFString));
    self->_fullName = $assert_nonnil($json_field(json, @"full_name", OFString));
    self->_owner = $assert_nonnil($json_field(json, @"owner", OFString));
    // self->_packageURL = $assert_nonnil($json_field(json, @"package_url", OFIRI));
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
    self->_totalDownloads = $assert_nonnil($json_field(json, @"total_downloads", OFNumber)).intValue;

    self->_latest = [TSPackageVersion modelFromJSON: $assert_nonnil($json_field(json, @"latest", OFDictionary))];

    return self;
}

+ (OFString *)url
{ return nil; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *,OFString *> *)params
{ return [OFString stringWithFormat: @"https://%@.thunderstore.io/api/experimental/package/%@/%@/", params[@"community"], params[@"namespace"], params[@"name"]]; }

@end
