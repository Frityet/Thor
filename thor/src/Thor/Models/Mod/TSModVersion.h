#import "Thor/Models/ITSModel.h"

OF_ASSUME_NONNULL_BEGIN

@interface TSModVersion : OFObject<ITSModel>

@property(atomic, readonly) OFString *name;
@property(atomic, readonly) OFString *fullName;
@property(atomic, readonly) OFString *packageDescription;
@property(atomic, readonly) OFIRI *icon;
@property(atomic, readonly) Version version;
@property(atomic, readonly) OFArray<OFString *> *dependencies;
@property(atomic, readonly) OFIRI *downloadURL;
@property(atomic, readonly) unsigned int downloads;
@property(atomic, readonly) OFDate *dateCreated;
@property(atomic, readonly, nullable) OFIRI *websiteURL;
@property(atomic, readonly) bool isActive;
@property(atomic, readonly) OFUUID *uuid4;
@property(atomic, readonly) size_t fileSize;

@end

OF_ASSUME_NONNULL_END
