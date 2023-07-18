#import "Common/common.h"

OF_ASSUME_NONNULL_BEGIN

@protocol ITSModel

+ (instancetype) modelFromJSON:(OFDictionary *)json;
- (instancetype) initWithJSON:(OFDictionary *)json;

//For any URL params, this method will be called to generate the URL
+ (OFString *_Nullable)url;
+ (OFString *)urlWithParametres: (OFDictionary<OFString *, OFString *> *)parametres;


@end

OF_ASSUME_NONNULL_END
