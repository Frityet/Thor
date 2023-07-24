#import "Common/common.h"

#import "Thor/Models/ITSModel.h"
#import "Thor/Models/Mod/TSMod.h"

#import "TSCommunityCategory.h"

OF_ASSUME_NONNULL_BEGIN

@interface TSCommunityNotFoundException : OFException

@property(readonly) OFString *community;

+ (instancetype)exceptionWithCommunity: (OFString *)community;
- (instancetype)initWithCommunity: (OFString *)community;

@end

@interface TSCommunity : OFObject<ITSModel>

@property(atomic, readonly) OFString *identifier;
@property(atomic, readonly) OFString *name;
@property(atomic, readonly) OFString *_Nullable discordURL;
@property(atomic, readonly) OFString *_Nullable wikiURL;
@property(atomic, readonly) bool requirePackageListingApproval;

@property(atomic, readonly) OFArray<TSCommunityCategory *> *categories;
@property(atomic, readonly) OFArray<TSMod *> *mods;

+ (instancetype)communityFromIdentifier: (OFString *)identifier;
- (instancetype)initFromIdentifier: (OFString *)identifier;

- (TSMod *)modWithAuthor: (OFString *)ns name: (OFString *)name;

@end

OF_ASSUME_NONNULL_END
