#include "FastPoolAllocator.h"

#include <boost/pool/pool_alloc.hpp>

@implementation FastPoolAllocator {
    boost::fast_pool_allocator<uint8_t> _allocator;
}

+ (instancetype)allocator
{ return [[self alloc] init]; }

- (instancetype)init
{
    self = [super init];

    return self;
}

- (void *)allocWithSize:(size_t)size
{
    return _allocator.allocate(size);
}

@end
