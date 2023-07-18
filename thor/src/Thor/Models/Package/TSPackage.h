#include "Thor/Models/ITSModel.h"

#include "TSPackageVersion.h"

/*
  {
    "name": "RavenM",
    "full_name": "RavenM-RavenM",
    "owner": "RavenM",
    "package_url": "https://ravenfield.thunderstore.io/package/RavenM/RavenM/",
    "date_created": "2022-08-19T19:40:25.481269Z",
    "date_updated": "2022-08-19T19:40:25.978746Z",
    "uuid4": "f7099f79-5f20-408d-b7d3-ce31ca695bc2",
    "rating_score": 1,
    "is_pinned": false,
    "is_deprecated": false,
    "has_nsfw_content": false,
    "categories": [
      "Mods",
      "Misc"
    ],
    "versions": [
*/

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
@property(atomic, readonly) OFArray<TSPackageVersion *> *versions;

@end

OF_ASSUME_NONNULL_END
