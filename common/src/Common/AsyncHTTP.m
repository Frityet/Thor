#include "AsyncHTTP.h"
#include "common.h"

@implementation AsyncHTTP

- (void)client:(OFHTTPClient *)client didPerformRequest:(OFHTTPRequest *)request response:(OFHTTPResponse *)response exception:(id)exception
{
    if (exception != nil) @throw exception;
    // ...
}

- (bool)stream:(OFStream *)stream didReadIntoBuffer:(void *)buffer length:(size_t)length exception:(id)exception
{
    if (exception != nil) @throw exception;
    _reportProgress(length);

    return !stream.atEndOfStream;
}

+ (instancetype)get:(OFIRI *)url withHeaders: (OFDictionary<OFString *, OFString *> *_Nullable)headers reportProgress:(void (^_Nullable)(size_t))recb
{ return [[self alloc] initWithGETRequest: url withHeaders: headers reportProgress: recb]; }

- (instancetype)initWithGETRequest:(OFIRI *)url withHeaders: (OFDictionary<OFString *, OFString *> *_Nullable)headers reportProgress: (void (^_Nullable)(size_t))recb
{
    self->_reportProgress = recb ?: ^(size_t size) {};

    return [super initWithBlock: ^{
        auto client = [OFHTTPClient client];
        client.delegate = self;

        auto req = [OFHTTPRequest requestWithIRI: url];
        req.method = OFHTTPRequestMethodGet;
        req.headers = headers ?: @{};

        auto resp = [client performRequest: req];

        if (resp.statusCode != 200)
            @throw [OFHTTPRequestFailedException exceptionWithRequest: req response: resp];

        return [resp readDataUntilEndOfStream];
    }];
}

@end
