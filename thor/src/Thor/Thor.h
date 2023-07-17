#import "Common/ObjFW.h"
#import "Models/Community/TSCommunity.h"
#import "Models/Community/TSCategory.h"

OF_ASSUME_NONNULL_BEGIN

__attribute__((objc_root_class))
@interface Thor
@property (class, readonly) OFArray<TSCommunity *> *communities;
@end

OF_ASSUME_NONNULL_END
