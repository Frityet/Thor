#include "json.h"

@implementation JSONKeyNotFoundException

+ (instancetype)exceptionWithKey: (OFString *)key
{
    return [[self alloc] initWithKey: key];
}

- (instancetype)initWithKey: (OFString *)key
{
    self = [super init];
    if (self == nil)
        return nil;

    _key = [key copy];

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"Key not found: %@", _key]; }

@end

@implementation JSONTypeMismatchException

+ (instancetype)exceptionWithKey: (OFString *)key expectedType: (Class)expectedType
{
    return [[self alloc] initWithKey: key expectedType: expectedType];
}

- (instancetype)initWithKey: (OFString *)key expectedType: (Class)expectedType
{
    self = [super init];
    if (self == nil)
        return nil;

    _key = [key copy];
    _expectedType = expectedType;

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"Type mismatch: %@ is not a %@", _key, _expectedType]; }

@end

id _Nullable get_json_field(OFDictionary *json, OFString *key, Class type)
{
    id value = json[key];
    if (value == nil)
        @throw [JSONKeyNotFoundException exceptionWithKey: key];

    if (value == OFNull.null)
        return nil;

    if (![value isKindOfClass:type])
        @throw [JSONTypeMismatchException exceptionWithKey: key expectedType: type];

    return value;
}
