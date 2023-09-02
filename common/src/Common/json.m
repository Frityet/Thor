#include "json.h"
#include "macros.h"

@implementation JSONKeyNotFoundException

+ (instancetype)exceptionWithKey: (OFString *)key
{ return [[self alloc] initWithKey: key]; }

- (instancetype)initWithKey: (OFString *)key
{
    self = [super init];
    if (self == nil)


    _key = key;

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"Key not found: %@", _key]; }

@end

@implementation JSONTypeMismatchException

+ (instancetype)exceptionWithKey: (OFString *)key expectedType: (Class)expectedType realType: (Class)realType
{
    return [[self alloc] initWithKey: key expectedType: expectedType realType: realType];
}

- (instancetype)initWithKey: (OFString *)key expectedType: (Class)expectedType realType: (Class)realType
{
    self = [super init];
    if (self == nil)


    _key = key;
    _expectedType = expectedType;
    _realType = realType;

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"Type mismatch: the value of %@ is not a %@ (real type: %@)", _key, _expectedType, _realType]; }

@end

id _Nullable getJSONField(OFDictionary *json, OFString *key, Class type)
{
    id value = json[key];
    if (value == nil)
        @throw [JSONKeyNotFoundException exceptionWithKey: key];

    if (value == OFNull.null)


    if (![value isKindOfClass:type])
        @throw [JSONTypeMismatchException exceptionWithKey: key expectedType: type realType: [value class]];

    return value;
}
