#include "TSCache.h"
#include "ObjFW/OFSeekableStream.h"

@implementation IRINotFoundException

+ (instancetype)exceptionWithIRI: (OFIRI *)iri
{ return [[self alloc] initWithIRI: iri]; }

- (instancetype)initWithIRI: (OFIRI *)iri
{
    if ((self = [super init]) == nil)
        return nil;

    self->_iri = iri;

    return self;
}

- (OFString *)description
{ return [OFString stringWithFormat: @"IRI not found: %@", self->_iri]; }

@end

@implementation TSCache

+ (instancetype)sharedCache
{
    static TSCache *cache = nil;
    if (cache == nil)
        cache = [self cacheWithDirectory: [OFFileManager.defaultManager.currentDirectoryIRI IRIByAppendingPathComponent: @"cache"]];
    return cache;
}

+ (instancetype)cacheWithDirectory: (OFIRI *)directory
{ return [[self alloc] initWithDirectory: directory]; }

- (instancetype)initWithDirectory: (OFIRI *)directory
{
    if ((self = [super init]) == nil)
        return nil;

    self->_directory = directory;
    self->_cache = [[OFMutableDictionary alloc] init];

    if (![OFFileManager.defaultManager directoryExistsAtPath: directory.path])
        [OFFileManager.defaultManager createDirectoryAtPath: directory.path createParents: true];

    //Add all files in the cache directory to the cache
    for (OFString *file in [OFFileManager.defaultManager contentsOfDirectoryAtPath: directory.path]) {
        auto path = [directory IRIByAppendingPathComponent: file];
        if ([OFFileManager.defaultManager directoryExistsAtPath: path.path])
            continue;
        self->_cache[file] = [OFFile fileWithPath: path.path mode: @"r+"];
    }

    return self;
}

- (OFDictionary<OFString *, OFFile *> *)cacheFiles
{ return self->_cache; }

- (OFFile *)createFileNamed: (OFString *)name
{
    if (self->_cache[name] != nil)
        return $assert_nonnil(self->_cache[name]);

    auto file = [OFFile fileWithPath: [_directory IRIByAppendingPathComponent: name].path mode: @"w+"];
    self->_cache[name] = file;
    return file;
}

- (OFFile *)createFileNamed: (OFString *)name withContents: (OFString *)contents
{
    auto file = [self createFileNamed: name];
    [file writeString: contents];
    [file seekToOffset: 0 whence: OFSeekEnd];
    return file;
}

- (void)removeFileNamed: (OFString *)name
{
    if (self->_cache[name] == nil)
        @throw [IRINotFoundException exceptionWithIRI: [_directory IRIByAppendingPathComponent: name]];

    [OFFileManager.defaultManager removeItemAtPath: [_directory IRIByAppendingPathComponent: name].path];
    [self->_cache removeObjectForKey: name];
    self->_cache[name] = nil;
}

- (void)clear
{
    for (OFString *file in self->_cache)
        [OFFileManager.defaultManager removeItemAtPath: [_directory IRIByAppendingPathComponent: file].path];

    [self->_cache removeAllObjects];
}

- (OFFile *)objectForKeyedSubscript: (OFString *)key
{
    auto f = self->_cache[key];
    [f seekToOffset: 0 whence: OFSeekEnd];
    return f;
}

- (void)setObject: (OFString *)str forKeyedSubscript: (OFString *)key
{
    if (str == nil) {
        [self removeFileNamed: key];
        return;
    }

    auto file = [self createFileNamed: key];
    [file writeString: str];
}

@end
