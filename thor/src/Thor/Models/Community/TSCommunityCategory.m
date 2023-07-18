#include "TSCommunityCategory.h"
#include "ObjFW/OFJSONRepresentation.h"

@implementation TSCommunityCategory

+ (instancetype)modelFromJSON:(OFDictionary *)json
{
    return [[self alloc] initWithJSON: json];
}

- (instancetype)initWithJSON:(OFDictionary *)json
{
    if ((self = [super init]) == nil)
        return nil;

    self->_name = $assert_nonnil($json_field(json, @"name", OFString));
    self->_slug = $assert_nonnil($json_field(json, @"slug", OFString));

    return self;
}

+ (OFString *)url
{ return nil; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *,OFString *> *)params
{ return [OFString stringWithFormat: @"https://thunderstore.io/api/experimental/community/%@/category/", params[@"community"]]; }

- (OFString *)JSONRepresentationWithOptions:(OFJSONRepresentationOptions)opts
{
    return [(@{
        @"name": self.name,
        @"slug": self.slug
    }) JSONRepresentationWithOptions: opts];
}

- (OFString *)JSONRepresentation
{ return [self JSONRepresentationWithOptions: OFJSONRepresentationOptionPretty]; }

- (OFString *)description
{
    return [OFString stringWithFormat: @"<%@: %@>", self.className, self.JSONRepresentation];
}

@end
