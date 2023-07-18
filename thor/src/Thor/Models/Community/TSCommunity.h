#import "Common/common.h"

#import "Thor/Models/ITSModel.h"
#import "Thor/Models/Package/TSPackage.h"

#import "TSCommunityCategory.h"

/*
  "results": [
    {
      "identifier": "shadows-of-doubt",
      "name": "Shadows of Doubt",
      "discord_url": "https://discord.gg/zGuvtBSeSp",
      "wiki_url": null,
      "require_package_listing_approval": false
    },
    ...
*/

OF_ASSUME_NONNULL_BEGIN

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

- (TSMod *) modWithAuthor: (OFString *)ns name: (OFString *)name;

@end

OF_ASSUME_NONNULL_END
