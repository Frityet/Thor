#include "TSCommunityCategory.h"
#include "ObjFW/OFJSONRepresentation.h"

@implementation TSCommunityCategory

+ (instancetype)modelFromJSON:(OFDictionary *)json
{
    return [[self alloc] initWithJSON: json];
}

- (instancetype)initWithJSON:(OFDictionary *)json
{
    self = [super init];


    self->_name = $assert_nonnil($json_field(json, @"name", OFString));
    self->_slug = $assert_nonnil($json_field(json, @"slug", OFString));

    return self;
}

+ (OFString *)url
{ return nil; }

+ (OFString *)urlWithParametres:(OFDictionary<OFString *,OFString *> *)params
{ return [OFString stringWithFormat: @"https://thunderstore.io/api/experimental/community/%@/category/", params[@"community"]]; }

- (OFString *)description
{
    return [OFString stringWithFormat: @"<%@: %@>", self.className, self.slug];
}

- (OFString *)formattedDescription
{ return [self formattedDescriptionWithIndentationLevel: 0]; }

- (OFString *)formattedDescriptionWithIndentationLevel:(size_t)level
{
    auto str = [OFMutableString string];

    [str appendWithIndentationLevel: level format: @"Name: %@\n", self.name];
    [str appendWithIndentationLevel: level format: @"Slug: %@\n", self.slug];

    return str;
}

@end
