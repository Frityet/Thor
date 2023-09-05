#include "Promise.h"
#include "common.h"

@implementation Promise

+ (instancetype)promiseWithBlock: (id (^)(void))block
{ return [[self alloc] initWithBlock: block]; }

- (instancetype)initWithBlock: (id (^)(void))block
{
    self = [super init];
    _isBlock = true;

    //Run the promise on a new thread
    _thread = [OFThread threadWithBlock: ^{
        _value = block();
        _isResolved = true;
        return (id)nil;
    }];
    [_thread start];

    return self;
}

+ (instancetype)promiseWithFunction: (id (*)(void))function
{ return [[self alloc] initWithFunction: function]; }

- (instancetype)initWithFunction: (id (*)(void))function
{
    self = [super init];
    _isBlock = false;

    //Run the promise on a new thread
    _thread = [OFThread threadWithBlock: ^{
        _value = function();
        _isResolved = true;
        return (id)nil;
    }];
    [_thread start];

    return self;
}

+ (instancetype)resolve: (id)value
{
    auto promise = [[self alloc] init];
    promise->_value = value;
    promise->_isResolved = true;
    return promise;
}

- (id)await
{
    if (_isResolved)
        return _value;

    [_thread join];

    return _value;
}

@end
