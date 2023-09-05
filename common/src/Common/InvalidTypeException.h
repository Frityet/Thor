#import "ObjFW.h"
#import "macros.h"

@interface InvalidTypeException : OFException

@property(readonly) Class expectedType, actualType;

+ (instancetype)exceptionWithExpectedType: (Class)expectedType actualType: (Class)actualType;
- (instancetype)initWithExpectedType: (Class)expectedType actualType: (Class)actualType;

@end

$nomangle
id AssertType(id obj1, Class c);

#define $assert_type(obj1, T) ((typeof(typeof(T) *_Nonnull))AssertType(obj1, [T class]))
