#include "Optional.h"

@implementation Optional {
    @private id _value;
}

+ (instancetype)some: (id)value
{ return [[self alloc] initWithValue: value]; }

- (instancetype)initWithValue: (id)value
{
    self = [super init];
    self->_hasValue = true;
    self->_value = value;

    return self;
}

+ (instancetype)none
{ return [[self alloc] init]; }

- (id)unwrap
{
    if (!self.hasValue)
        @throw [OFInitializationFailedException exceptionWithClass: self.class];

    return self->_value;
}

- (id)unwrapOr: (id)def
{ return self->_value ?: def; }

- (id)unwrapOrElse: (id (^)(void))def
{ return self->_value ?: def(); }

- (id)matchSome: (id (^)(id))some none: (id (^)(void))none
{ return self.hasValue ? some(self->_value) : none(); }

@end
