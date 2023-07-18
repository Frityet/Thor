#import "Common/common.h"

OF_ASSUME_NONNULL_BEGIN

@protocol ITSSerializable

// - (OFData *)serialize;

@end

@protocol ITSDeserializable

// + (instancetype)deserialize: (OFData *)data;

@end

@protocol ITSModel<ITSSerializable, ITSDeserializable>

+ (instancetype) modelFromJSON:(OFDictionary *)json;
- (instancetype) initWithJSON:(OFDictionary *)json;

//For any URL params, this method will be called to generate the URL
+ (OFString *_Nullable)url;
+ (OFString *)urlWithParametres: (OFDictionary<OFString *, OFString *> *)parametres;


@end

OF_ASSUME_NONNULL_END
