#include "Common/common.h"

OF_ASSUME_NONNULL_BEGIN

@interface IRINotFoundException : OFException

@property(readonly) OFIRI *iri;

+ (instancetype)exceptionWithIRI: (OFIRI *)iri;
- (instancetype)initWithIRI: (OFIRI *)iri;

@end

@interface TSCache : OFObject {
    @private OFMutableDictionary<OFString *, OFFile *> *_cache;
}

@property(readonly) OFIRI *directory;
@property(readonly, strong) OFDictionary<OFString *, OFFile *> *cacheFiles;

+ (instancetype)sharedCache;
+ (instancetype)cacheWithDirectory: (OFIRI *)directory;
- (instancetype)initWithDirectory: (OFIRI *)directory;

- (OFFile __weak *)createFileNamed: (OFString *)name;
- (OFFile __weak *)createFileNamed: (OFString *)name withContents: (OFString *)contents;

- (OFFile *_Nullable)objectForKeyedSubscript: (OFString *)key;
- (void)setObject: (OFString *)str forKeyedSubscript: (OFString *)key;

@end

OF_ASSUME_NONNULL_END
