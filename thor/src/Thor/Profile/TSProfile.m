#include "TSProfile.h"

#import "Thor/Thor.h"

@interface AsyncDownloadDelegate : OFObject<OFHTTPClientDelegate>

@property(readonly) OFFile *file;

+ (instancetype)delegateWithFile: (OFFile *)file;
- (instancetype)initWithFile: (OFFile *)file;

@end

@implementation AsyncDownloadDelegate

+ (instancetype)delegateWithFile: (OFFile *)file
{ return [[self alloc] initWithFile: file]; }

- (instancetype)initWithFile: (OFFile *)file
{
    self = [super init];


    self->_file = file;

    return self;
}

- (void)    client:(OFHTTPClient *)client
 didPerformRequest:(OFHTTPRequest *)request
          response:(OFHTTPResponse *)response
         exception:(id)exception
{
    if (exception != nil) {
        @throw exception;
        return;
    }

    // [response async]
}

@end

@implementation TSProfile

+ (instancetype)createProfileNamed:(OFString *)name forGame:(OFString *)game atPath:(OFString *)path
{
    auto iri = [OFIRI IRIWithString: path];
    if ([OFFileManager.defaultManager directoryExistsAtIRI: iri])
        return [self profileAtPath: path];

    if ([OFFileManager.defaultManager fileExistsAtIRI: iri])
        @throw [OFCreateDirectoryFailedException exceptionWithIRI: iri errNo: EEXIST];

    [OFFileManager.defaultManager createDirectoryAtIRI: iri createParents: true];

    return [[self alloc] initProfileWithName: name game: game path: path mods: @[]];
}

+ (instancetype) profileAtPath:(OFString *)path
{
    auto iri = [OFIRI IRIWithString: path];
    if (![OFFileManager.defaultManager directoryExistsAtIRI: iri])
        @throw [OFInvalidArgumentException exception];

    auto manifestFile = [iri IRIByAppendingPathComponent: @"manifest.json"];
    if (![OFFileManager.defaultManager fileExistsAtIRI: manifestFile])
        @throw [OFInvalidArgumentException exception];

    OFDictionary *manifest = ParseJSON([OFString stringWithContentsOfIRI: manifestFile]);

    return [[self alloc] initProfileWithName: $json_field(manifest, @"name", OFString)
                                        game: $json_field(manifest, @"game", OFString)
                                        path: path
                                        mods: $json_field(manifest, @"mods", OFArray<TSModVersion *>)];
}

- (instancetype)initProfileWithName:(OFString *)name game:(OFString *)game path:(OFString *)path mods:(OFArray<TSModVersion *> *)mods
{
    self = [super init];


    self->_name = name;
    self->_game = game;
    self->_path = path;
    self->_mods = [mods mutableCopy];

    self->_manifestFile = [OFFile fileWithPath: [path stringByAppendingPathComponent: @"manifest.json"] mode: @"w+"];
    for (TSCommunity *community in Thor.communities) {
        if ([community.identifier isEqual: game]) {
            self->_community = community;
            break;
        }
    }

    if (self->_community == nil)
        @throw [TSCommunityNotFoundException exceptionWithCommunity: game];

    return self;
}

- (void)addModNamed:(OFString *)name ownedBy:(OFString *)owner version: (Version)version
{
    TSMod *selectedMod = nil;
    for (TSMod *mod in self->_community.mods) {
        if ([mod.owner isEqual: owner] and [mod.name isEqual: name])
            selectedMod = mod;
    }
    if (selectedMod == nil) {
        @throw [TSModNotFoundException exceptionWithModName: name
                                                    ownedBy: owner
                                                inCommunity: self->_community.identifier];
    }

    TSModVersion *modVersion = nil;
    for (TSModVersion *ver in selectedMod.versions) {
        if (VersionEquals(ver.version, version))
            modVersion = ver;
    }

    if (modVersion == nil) {
        @throw [TSModVersionNotFoundException exceptionWithModName: name
                                                           ownedBy: owner
                                                           version: version
                                                       inCommunity: self->_community.identifier];
    }

    for (TSModVersion *mod in self->_mods) {
        bool nameEquals = [mod.name isEqual: name];
        bool versionEquals = VersionEquals(mod.version, version);
        if (nameEquals and versionEquals) return;
        else if (nameEquals and !versionEquals) {
            [self->_mods removeObject: mod];
            break;
        }
    }

    [self installMod: modVersion];
}

- (void)removeModNamed:(OFString *)name
{
    for (TSModVersion *mod in self->_mods) {
        if ([mod.name isEqual: name]) {
            [self removeMod: mod];
            break;
        }
    }
}

- (void)installMod: (TSModVersion *)mod
{
    auto modPath = [OFIRI IRIWithString: [self->_path stringByAppendingPathComponent: @"Mods"]];
    if (![OFFileManager.defaultManager directoryExistsAtIRI: modPath])
        [OFFileManager.defaultManager createDirectoryAtIRI: modPath createParents: true];

    auto archiveFile = [modPath IRIByAppendingPathComponent: [mod.name stringByAppendingPathExtension: @"zip"]];
    auto archive = [OFFile fileWithPath: archiveFile.path mode: @"w"];

    auto client = [OFHTTPClient client];
    auto request = [OFHTTPRequest requestWithIRI: mod.downloadURL];
    client.delegate = [AsyncDownloadDelegate delegateWithFile: archive];
    request.method = OFHTTPRequestMethodGet;
    [client asyncPerformRequest: request];

    [self->_mods addObject: mod];
}

- (void)removeMod: (TSModVersion *)mod
{

    [self->_mods removeObject: mod];
}

- (void)save
{
    [self->_manifestFile writeString: (@{
        @"name": self->_name,
        @"game": self->_game,
        @"mods": self->_mods
    }).JSONRepresentation];
    [self->_manifestFile seekToOffset: 0 whence: OFSeekSet];
}


@end
