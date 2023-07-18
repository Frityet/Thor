#include "TSCache.h"

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
        cache = [self cacheWithDirectory: [[OFFileManager.defaultManager currentDirectoryIRI] IRIByAppendingPathComponent: @"cache"]];
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
    [file seekToOffset: 0 whence: OFSeekSet];
    [file writeString: contents];
    return file;
}

- (OFFile *)objectForKeyedSubscript: (OFString *)key
{ return self->_cache[key]; }

- (void)setObject: (OFString *)str forKeyedSubscript: (OFString *)key
{
    auto file = [self createFileNamed: key];
    [file seekToOffset: 0 whence: OFSeekSet];
    [file writeString: str];
}

@end
