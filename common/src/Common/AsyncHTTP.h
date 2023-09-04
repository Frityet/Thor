#import "Promise.h"

@interface AsyncHTTP : Promise<OFData *><OFHTTPClientDelegate, OFStreamDelegate>

@property(readonly) void (^reportProgress)(size_t size);

+ (instancetype)get: (OFIRI *)url withHeaders: (OFDictionary<OFString *, OFString *> *_Nullable)headers reportProgress: (void(^_Nullable)(size_t size))recb;
- (instancetype)initWithGETRequest: (OFIRI *)url withHeaders: (OFDictionary<OFString *, OFString *> *_Nullable)headers reportProgress: (void(^_Nullable)(size_t size))recb;

@end
