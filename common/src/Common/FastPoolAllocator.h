#import "OFObject+AllocatorExtensions.h"

OF_ASSUME_NONNULL_BEGIN

@interface FastPoolAllocator : OFObject<Allocator>

+ (instancetype)allocator;
- (instancetype)init;

@end


OF_ASSUME_NONNULL_END
