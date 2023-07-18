#import "Thor/Models/ITSModel.h"

/*
      {
        "name": "RavenM",
        "full_name": "RavenM-RavenM-0.3.0",
        "description": "A Ravenfield Multiplayer Mod",
        "icon": "https://gcdn.thunderstore.io/live/repository/icons/RavenM-RavenM-0.3.0.png",
        "version_number": "0.3.0",
        "dependencies": [
          "BepInEx-BepInExPack_Ravenfield-5.4.21"
        ],
        "download_url": "https://thunderstore.io/package/download/RavenM/RavenM/0.3.0/",
        "downloads": 2145,
        "date_created": "2022-08-19T19:40:25.696650Z",
        "website_url": "https://github.com/ABigPickle/RavenM",
        "is_active": true,
        "uuid4": "9a554ef0-9311-4254-8938-70f0f1f4fa13",
        "file_size": 230129
      }
*/

OF_ASSUME_NONNULL_BEGIN

@interface TSPackageVersion : OFObject<ITSModel>

@property(atomic, readonly) OFString *name;
@property(atomic, readonly) OFString *fullName;
@property(atomic, readonly) OFString *packageDescription;
@property(atomic, readonly) OFIRI *icon;
@property(atomic, readonly) Version versionNumber;
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
