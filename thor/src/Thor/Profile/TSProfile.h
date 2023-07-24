#import "Common/ObjFW.h"

#import "Thor/Models/Mod/TSMod.h"
#import "Thor/Models/Community/TSCommunity.h"

@interface TSProfile : OFObject {
    @private OFMutableArray<TSModVersion *> *_mods;
    @private OFFile *_manifestFile;
    @private TSCommunity *_community;
}

@property(readonly) OFString *name;
@property(readonly) OFString *path;
@property(readonly) OFString *game;
@property(readonly) OFArray<TSModVersion *> *mods;

+ (instancetype)createProfileNamed: (OFString *)name forGame: (OFString *)game atPath: (OFString *)path;
+ (instancetype)profileAtPath: (OFString *)path;

- (instancetype)initProfileWithName: (OFString *)name game: (OFString *)game path: (OFString *)path mods: (OFArray<TSModVersion *> *)mods;

- (void)addModNamed: (OFString *)name ownedBy: (OFString *)owner version: (Version)version;
- (void)removeModNamed: (OFString *)name;

- (void)save;

@end
