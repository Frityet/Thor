#import "ObjFW.h"
#import "macros.h"

#import "InvalidTypeException.h"

OF_ASSUME_NONNULL_BEGIN

@interface JSONInvalidTypeException : InvalidTypeException

@property (readonly, nonatomic) OFString *key;

+ (instancetype)exceptionWithKey: (OFString *)key expectedType: (Class)expectedType realType: (Class)realType;

@end

@interface JSONParseException : OFException

+ (instancetype)exceptionWithErrorCode: (int)errorCode;
- (instancetype)initWithErrorCode: (int)errorCode;

@end


$nomangle id _Nullable GetJSONField(OFDictionary *json, OFString *key, Class type);

$nomangle id ParseJSON(OFString *json);

#define $json_field(json, key, type) ((type *_Nullable)GetJSONField(json, key, [type class]))

OF_ASSUME_NONNULL_END
