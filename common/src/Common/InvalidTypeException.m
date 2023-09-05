#include "InvalidTypeException.h"

@implementation InvalidTypeException

+ (instancetype)exceptionWithExpectedType: (Class)expectedType actualType: (Class)actualType
{ return [[self alloc] initWithExpectedType: expectedType actualType: actualType]; }

- (instancetype)initWithExpectedType: (Class)expectedType actualType: (Class)actualType
{
    self = [super init];

    self->_expectedType = expectedType;
    self->_actualType = actualType;

    return self;
}

- (OFString *)description
{
    return [OFString stringWithFormat: @"Expected type %@, got %@.", self.expectedType, self.actualType];
}

@end

id AssertType(id obj, Class c)
{
    if (!(obj && [obj isKindOfClass: c]))
        @throw [InvalidTypeException exceptionWithExpectedType: c actualType: [obj class]];
    return obj;
}
