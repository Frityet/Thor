#include "ObjFW.h"
#include "macros.h"

OF_ASSUME_NONNULL_BEGIN

@interface JSONKeyNotFoundException : OFException

@property (readonly, nonatomic) OFString *key;

+ (instancetype)exceptionWithKey: (OFString *)key;

@end

@interface JSONTypeMismatchException : OFException

@property (readonly, nonatomic) OFString *key;
@property (readonly, nonatomic) Class expectedType;
@property (readonly, nonatomic) Class realType;

+ (instancetype)exceptionWithKey: (OFString *)key expectedType: (Class)expectedType realType: (Class)realType;

@end

@interface JSONParseException : OFException

+ (instancetype)exceptionWithErrorCode: (int)errorCode;
- (instancetype)initWithErrorCode: (int)errorCode;

@end


$nomangle id _Nullable GetJSONField(OFDictionary *json, OFString *key, Class type);

$nomangle OFDictionary<OFString *, id> *ParseJSON(OFString *json);

#define $json_field(json, key, type) ((type *_Nullable)GetJSONField(json, key, [type class]))

OF_ASSUME_NONNULL_END
