#import "Promise.h"

@interface AsyncHTTP : Promise<OFData *><OFHTTPClientDelegate, OFStreamDelegate>

@property(readonly) void (^reportProgress)(size_t size);

+ (instancetype)get: (OFIRI *)url withHeaders: (OFDictionary<OFString *, OFString *> *)headers reportProgress: (void(^)(size_t size))recb;
- (instancetype)initWithGETRequest: (OFIRI *)url withHeaders: (OFDictionary<OFString *, OFString *> *)headers reportProgress: (void(^)(size_t size))recb;

@end
