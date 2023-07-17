#import "Thor/Models/ITSModel.h"

OF_ASSUME_NONNULL_BEGIN

@interface TSPackageVersion : OFObject<ITSModel>

@property(atomic, readonly) OFString *namespace;
@property(atomic, readonly) OFString *name;
@property(atomic, readonly) Version versionNumber;
@property(atomic, readonly) OFString *fullName;

//`description` is reserved for `OFObject`
@property(atomic, readonly) OFString *packageDescription;
@property(atomic, readonly) OFIRI *icon;
@property(atomic, readonly) OFArray<OFString *> *dependencies;
@property(atomic, readonly) OFIRI *downloadURL;
@property(atomic, readonly) unsigned int downloads;
@property(atomic, readonly) OFDate *dateCreated;
@property(atomic, readonly, nullable) OFIRI *websiteURL;
@property(atomic, readonly) bool isActive;

@end

OF_ASSUME_NONNULL_END
