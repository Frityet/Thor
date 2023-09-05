#import "ObjFW.h"

OF_ASSUME_NONNULL_BEGIN

@protocol Allocator

- (void *)allocWithSize: (size_t)size;// alignment: (size_t)alignment;

@end


@interface OFObject (AllocatorExtensions)

+ (instancetype)allocWithAllocator: (id<Allocator>)allocator;

@end


OF_ASSUME_NONNULL_END
