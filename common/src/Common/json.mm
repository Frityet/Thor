//uses C++ `auto` so include it first
#include "simdjson.hpp"

#import "json.h"
#import "macros.h"

@implementation JSONInvalidTypeException

+ (instancetype)exceptionWithKey: (OFString *)key expectedType: (Class)expectedType realType: (Class)realType
{
    return [[self alloc] initWithKey: key expectedType: expectedType realType: realType];
}

- (instancetype)initWithKey: (OFString *)key expectedType: (Class)expectedType realType: (Class)realType
{
    self = [super initWithExpectedType: expectedType actualType: realType];

    _key = key;

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"Expected type %@ for key %@, got %@", self.expectedType, self.key, self.actualType]; }

@end


@implementation JSONParseException {
    simdjson::error_code _errorCode;
}

+ (instancetype)exceptionWithErrorCode: (int)errorCode
{ return [[self alloc] initWithErrorCode: errorCode]; }

- (instancetype)initWithErrorCode: (int)errorCode
{
    self = [super init];

    _errorCode = static_cast<simdjson::error_code>(errorCode);

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"JSON parse error: %s", simdjson::error_message(_errorCode)]; }

@end

$nomangle id _Nullable GetJSONField(OFDictionary *json, OFString *key, Class type)
{
    id value = json[key];
    if (value == nil or value == OFNull.null)
        return nil;

    if (![value isKindOfClass:type])
        @throw [JSONInvalidTypeException exceptionWithKey: key expectedType: type realType: [value class]];

    return value;
}

static id jsonToObject(const simdjson::dom::element &document);

//OFString *, OFNumber *, etc
static id jsonToValue(const simdjson::dom::element &document)
{
    switch (document.type()) {
        case simdjson::dom::element_type::INT64:
            return [OFNumber numberWithLongLong: document.get_int64()];
        case simdjson::dom::element_type::UINT64:
            return [OFNumber numberWithUnsignedLongLong: document.get_uint64()];
        case simdjson::dom::element_type::DOUBLE:
            return [OFNumber numberWithDouble: document.get_double()];
        case simdjson::dom::element_type::STRING: {
            std::string_view s = document.get_string().take_value();
            return [OFString stringWithUTF8String: s.data() length: s.length()];
        }
        case simdjson::dom::element_type::BOOL:
            return [OFNumber numberWithBool: document.get_bool()];
        case simdjson::dom::element_type::NULL_VALUE:
            return OFNull.null;
        default:
            @throw [OFInvalidArgumentException exception];
    }
}

static OFDictionary<OFString *, id> *jsonToDictionary(const simdjson::dom::element &document)
{
    auto dictionary = [OFMutableDictionary<OFString *, id> dictionary];

    for (const auto &[key, value] : document.get_object())
        dictionary[[OFString stringWithUTF8String: key.data() length: key.length()]] = jsonToObject(value);

    return dictionary;
}

static OFArray<id> *jsonToArray(const simdjson::dom::element &document)
{
    auto array = [OFMutableArray<id> array];

    for (simdjson::dom::element child : document)
        [array addObject: jsonToObject(child)];

    return array;
}

static id jsonToObject(const simdjson::dom::element &document)
{
    switch (document.type()) {
        case simdjson::dom::element_type::OBJECT:
            return jsonToDictionary(document);
        case simdjson::dom::element_type::ARRAY:
            return jsonToArray(document);
        default:
            return jsonToValue(document);
    }
}

$nomangle OFDictionary<OFString *, id> *ParseJSON(OFString *str)
{
    simdjson::dom::parser parser;
    simdjson::dom::element doc;
    simdjson::error_code err = parser.parse(str.UTF8String, str.UTF8StringLength).get(doc);
    if (err)
        @throw [JSONParseException exceptionWithErrorCode: err];

    return jsonToObject(doc);
}
