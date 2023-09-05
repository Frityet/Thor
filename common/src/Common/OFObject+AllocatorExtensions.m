#include "OFObject+AllocatorExtensions.h"

#include <objc/objc.h>
#include <objc/objc-class.h>

@implementation OFObject(AllocatorExtensions)

+ (instancetype)allocWithAllocator: (id<Allocator>)allocator
{
    size_t size = class_getInstanceSize(self);
    return [allocator allocWithSize: size];
}

@end
