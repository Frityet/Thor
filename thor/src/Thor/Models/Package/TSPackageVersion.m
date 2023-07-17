#include "TSPackageVersion.h"

@implementation TSPackageVersion

+ (instancetype)modelFromJSON:(OFDictionary *)json
{ return [[self alloc] initWithJSON: json]; }

- (instancetype)initWithJSON:(OFDictionary *)json
{
    if ((self = [super init]) == nil)
        return nil;

    self->_namespace = $assert_nonnil($json_field(json, @"namespace", OFString));
    self->_name = $assert_nonnil($json_field(json, @"name", OFString));
    self->_versionNumber = version_from_string($assert_nonnil($json_field(json, @"version_number", OFString)));
    self->_fullName = $assert_nonnil($json_field(json, @"full_name", OFString));

    self->_packageDescription = $assert_nonnil($json_field(json, @"description", OFString));
    self->_icon = [OFIRI IRIWithString: $assert_nonnil($json_field(json, @"icon", OFString))];
    self->_dependencies = $assert_nonnil($json_field(json, @"dependencies", OFArray<OFString *>));
    self->_downloadURL = [OFIRI IRIWithString: $assert_nonnil($json_field(json, @"download_url", OFString))];
    self->_downloads = $assert_nonnil($json_field(json, @"downloads", OFNumber)).unsignedIntValue;

    auto created = $assert_nonnil($json_field(json, @"date_created", OFString));
    created = [created substringToIndex: [created rangeOfString: @"." options: OFStringSearchBackwards].location];

    self->_dateCreated = [OFDate dateWithDateString: created format: @"%Y-%m-%dT%H:%M:%S"];
    self->_websiteURL = [OFIRI IRIWithString: $assert_nonnil($json_field(json, @"website_url", OFString))];
    self->_isActive = $assert_nonnil($json_field(json, @"is_active", OFNumber)).boolValue;

    return self;
}

+ (OFString *)url
{ return nil; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *, OFString *> *)params
{ return [OFString stringWithFormat: @"https://%@.thunderstore.io/api/experimental/package/%@/%@/%@/", params[@"community"], params[@"namespace"], params[@"name"], params[@"version"]]; }

@end
