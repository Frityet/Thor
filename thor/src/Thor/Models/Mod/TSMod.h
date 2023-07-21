#include "Thor/Models/ITSModel.h"

#include "TSModVersion.h"

OF_ASSUME_NONNULL_BEGIN

@interface TSMod : OFObject<ITSModel>

@property(atomic, readonly) OFString *name;
@property(atomic, readonly) OFString *fullName;
@property(atomic, readonly) OFString *owner;
@property(atomic, readonly) OFIRI *packageURL;
@property(atomic, readonly) OFDate *dateCreated;
@property(atomic, readonly) OFDate *dateUpdated;
@property(atomic, readonly) OFUUID *uuid4;
@property(atomic, readonly) unsigned int ratingScore;
@property(atomic, readonly) bool isPinned;
@property(atomic, readonly) bool isDeprecated;
@property(atomic, readonly) bool hasNSFWContent;
@property(atomic, readonly) OFArray<OFString *> *categories;
@property(atomic, readonly) OFArray<TSModVersion *> *versions;

- (OFString *)formattedDescriptionWithIndentationLevel:(size_t)level showVersions: (bool)showVersions;

@end

OF_ASSUME_NONNULL_END
