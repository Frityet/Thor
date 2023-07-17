#import "Common/common.h"

#import "Thor/Models/ITSModel.h"

#import "TSCategory.h"

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

@property(atomic, readonly) OFString *identifier, *name, *_Nullable discordURL, *_Nullable wikiURL;
@property(atomic, readonly) bool requirePackageListingApproval;
@property(atomic, readonly) OFArray<TSCategory *> *categories;

@end

OF_ASSUME_NONNULL_END
