#import "ObjFW.h"

@interface Optional<T> : OFObject

@property(readonly) bool hasValue;
@property(readonly, getter=unwrap, nonnull) T value;

+ (instancetype)some: (T)value;
- (instancetype)initWithValue: (T)value;

+ (instancetype)none;

- (T)unwrap;
- (T)unwrapOr: (T)def;
- (T)unwrapOrElse: (T (^)(void))def;
- (T)matchSome: (T (^)(T))some none: (T (^)(void))none;

@end
