#include "Thor/Models/ITSModel.h"

#include "TSPackageVersion.h"

OF_ASSUME_NONNULL_BEGIN

@interface TSPackage : OFObject<ITSModel>

@property(atomic, readonly) OFString *namespace;
@property(atomic, readonly) OFString *name;
@property(atomic, readonly) OFString *fullName;
@property(atomic, readonly) OFString *owner;
@property(atomic, readonly) OFIRI *packageURL;

@property(atomic, readonly) OFDate *dateCreated;
@property(atomic, readonly) OFDate *dateUpdated;

@property(atomic, readonly) int ratingScore;
@property(atomic, readonly) bool isPinned;
@property(atomic, readonly) bool isDeprecated;
@property(atomic, readonly) int totalDownloads;

@property(atomic, readonly) TSPackageVersion *latest;

@end

OF_ASSUME_NONNULL_END
