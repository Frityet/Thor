#import "Common/common.h"

#import "Thor/Models/ITSModel.h"

OF_ASSUME_NONNULL_BEGIN

@interface TSCommunityCategory : OFObject<ITSModel>

@property(atomic, readonly) OFString *name;
@property(atomic, readonly) OFString *slug;

@end

OF_ASSUME_NONNULL_END
