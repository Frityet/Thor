#import "ObjFW.h"

@interface Promise<T> : OFObject {
    @private OFThread *_thread;
    @private __block T _value;
}

@property (readonly, getter=await) T value;

@property (atomic, readonly) bool isResolved;
@property (readonly) bool isBlock;
@property (readonly) T (^block)(void);
@property (readonly) T (*function)(void);


+ (instancetype)promiseWithBlock: (T (^)(void))block;
- (instancetype)initWithBlock: (T (^)(void))block;
+ (instancetype)promiseWithFunction: (T (*)(void))function;
- (instancetype)initWithFunction: (T (*)(void))function;

+ (instancetype)resolve: (T)value;
- (T)await;

@end


