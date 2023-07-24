#import <ObjFW/ObjFW.h>


#define auto __auto_type

@interface AsyncDownloadRequest : OFObject<OFHTTPClientDelegate>

@property(readonly) OFFile *file;

+ (instancetype)requestWithFile: (OFFile *)file;
- (instancetype)initWithFile: (OFFile *)file;

@end

@implementation AsyncDownloadRequest

+ (instancetype)requestWithFile: (OFFile *)file
{ return [[self alloc] initWithFile: file]; }

- (instancetype)initWithFile: (OFFile *)file
{
    if ((self = [super init]) == nil)
        return nil;

    self->_file = file;

    return self;
}

- (void)client:(OFHTTPClient *)client didPerformRequest:(OFHTTPRequest *)request response:(OFHTTPResponse *)response exception:(id)exception
{
    if (exception != nil) {
        @throw exception;
        return;
    }

    [OFStdErr writeFormat: @"Response: %@\n", response];

    static const size_t SIZE = 4096;

    void *buffer = malloc(SIZE);
    [response asyncReadIntoBuffer: buffer length: SIZE block: ^(size_t size, id exception) {
        if (exception != nil) {
            @throw exception;
            return false;
        }

        [OFStdOut writeFormat: @"Writing %zu bytes\n", size];
        [self->_file asyncWriteData: [OFData dataWithItemsNoCopy: buffer count: size freeWhenDone: false]];
        return true;
    }];
}

@end

@interface AsyncTest : OFObject<OFApplicationDelegate> @end

@implementation AsyncTest

- (void)applicationDidFinishLaunching:_
{
    OFLog(@"This is a log msg");
    auto args = OFApplication.arguments;
    if (args.count < 1) {
        [OFStdErr writeLine: @"Usage: async-test <url> [file]"];
        [OFApplication terminateWithStatus: 1];
        return;
    }


    auto url = (OFString *)args[0];
    auto file = args.count > 1 ? args[1] : @"file.txt";

    auto http = [OFHTTPClient client];

    static AsyncDownloadRequest *delegate;
    if (delegate == nil)
        delegate = [AsyncDownloadRequest requestWithFile: [OFFile fileWithPath: file mode: @"w"]];

    http.delegate = delegate;
    auto req = [OFHTTPRequest requestWithIRI: [OFIRI IRIWithString: url]];
    req.method = OFHTTPRequestMethodGet;
    [http asyncPerformRequest: req];
}

@end

OF_APPLICATION_DELEGATE(AsyncTest);
