#include "OFObject+AllocatorExtensions.h"

extern size_t class_getInstanceSize(Class _Nullable cls);

@implementation OFObject(AllocatorExtensions)

+ (instancetype)allocWithAllocator: (id<Allocator>)allocator
{
    size_t size = class_getInstanceSize(self);
    return [allocator allocWithSize: size];
}

@end
