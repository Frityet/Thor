#import "Common/ObjFW.h"
#import "Models/Community/TSCommunity.h"

OF_ASSUME_NONNULL_BEGIN

__attribute__((objc_root_class))
@interface Thor

@property (class, readonly) OFArray<TSCommunity *> *communities;

+ (TSCommunity *_Nullable)communityWithSlug: (OFString *)slug;
+ (void)updateDatabase;

@end

OF_ASSUME_NONNULL_END
