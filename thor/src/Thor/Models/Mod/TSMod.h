#include "Thor/Models/ITSModel.h"

#include "TSModVersion.h"

OF_ASSUME_NONNULL_BEGIN

@interface TSModNotFoundException : OFException {
    @protected OFString *_name;
    @protected OFString *_owner;
    @protected OFString *_community;
}

@property(readonly) OFString *name;
@property(readonly) OFString *owner;
@property(readonly) OFString *community;

+ (instancetype)exceptionWithModName:(OFString *)modName ownedBy: (OFString *)owner inCommunity: (OFString *)community;

@end

@interface TSModVersionNotFoundException : TSModNotFoundException

@property(readonly) Version version;

+ (instancetype)exceptionWithModName:(OFString *)modName ownedBy: (OFString *)owner version: (Version)version inCommunity: (OFString *)community;

@end

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
