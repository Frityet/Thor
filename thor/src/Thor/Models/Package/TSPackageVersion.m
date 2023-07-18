#include "TSPackageVersion.h"

@implementation TSPackageVersion

+ (instancetype)modelFromJSON:(OFDictionary *)json
{ return [[self alloc] initWithJSON: json]; }

- (instancetype)initWithJSON:(OFDictionary *)json
{
    if ((self = [super init]) == nil)
        return nil;

    self->_name = $assert_nonnil($json_field(json, @"name", OFString));
    self->_versionNumber = VersionFromString($assert_nonnil($json_field(json, @"version_number", OFString)));
    self->_fullName = $assert_nonnil($json_field(json, @"full_name", OFString));

    self->_packageDescription = $assert_nonnil($json_field(json, @"description", OFString));
    self->_icon = [OFIRI IRIWithString: $assert_nonnil($json_field(json, @"icon", OFString))];
    self->_dependencies = $assert_nonnil($json_field(json, @"dependencies", OFArray<OFString *>));
    self->_downloadURL = [OFIRI IRIWithString: $assert_nonnil($json_field(json, @"download_url", OFString))];
    self->_downloads = $assert_nonnil($json_field(json, @"downloads", OFNumber)).unsignedIntValue;

    auto created = $assert_nonnil($json_field(json, @"date_created", OFString));
    created = [created substringToIndex: [created rangeOfString: @"." options: OFStringSearchBackwards].location];

    self->_dateCreated = [OFDate dateWithDateString: created format: @"%Y-%m-%dT%H:%M:%S"];

    auto weburl = $json_field(json, @"website_url", OFString);
    if (weburl != nil) {
        @try {
            self->_websiteURL = [OFIRI IRIWithString: $assert_nonnil(weburl)];
        } @catch(OFException *ex) {
            self->_websiteURL = nil;
        }
    }
    self->_isActive = $assert_nonnil($json_field(json, @"is_active", OFNumber)).boolValue;

    self->_uuid4 = [OFUUID UUIDWithUUIDString: $assert_nonnil($json_field(json, @"uuid4", OFString))];
    self->_fileSize = $assert_nonnil($json_field(json, @"file_size", OFNumber)).unsignedLongLongValue;

    return self;
}

+ (OFString *)url
{ return nil; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *, OFString *> *)params
{ return [OFString stringWithFormat: @"https://%@.thunderstore.io/api/experimental/package/%@/%@/%@/", params[@"community"], params[@"author"], params[@"name"], params[@"version"]]; }

- (OFString *)description
{ return [OFString stringWithFormat: @"<TSPackageVersion: %@>", self.fullName]; }

@end
