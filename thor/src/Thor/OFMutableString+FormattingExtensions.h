#include "Common/common.h"

OF_ASSUME_NONNULL_BEGIN

@interface OFMutableString(FormattingExtensions)

- (void) appendWithIndentationLevel: (size_t)level format: (OFConstantString *)format, ...;
- (void) appendWithIndentationLevel: (size_t)level format: (OFConstantString *)format arguments: (va_list)arguments;

@end

OF_ASSUME_NONNULL_END
