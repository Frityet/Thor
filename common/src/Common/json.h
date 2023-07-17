#include "ObjFW.h"

OF_ASSUME_NONNULL_BEGIN

@interface JSONKeyNotFoundException : OFException

@property (readonly, nonatomic) OFString *key;

+ (instancetype)exceptionWithKey: (OFString *)key;

@end

@interface JSONTypeMismatchException : OFException

@property (readonly, nonatomic) OFString *key;
@property (readonly, nonatomic) Class expectedType;

+ (instancetype)exceptionWithKey: (OFString *)key expectedType: (Class)expectedType;

@end

id _Nullable get_json_field(OFDictionary *json, OFString *key, Class type);

#define $json_field(json, key, type) ((type *_Nullable)get_json_field(json, key, [type class]))

OF_ASSUME_NONNULL_END
