#include "OFMutableString+FormattingExtensions.h"

@implementation OFMutableString(FormattingExtensions)

- (void) appendWithIndentationLevel: (size_t)level format: (OFConstantString *)format, ...
{
    va_list arguments;
    va_start(arguments, format);
    [self appendWithIndentationLevel: level format: format arguments: arguments];
    va_end(arguments);
}

- (void) appendWithIndentationLevel: (size_t)level format: (OFConstantString *)format arguments: (va_list)arguments
{
    for (size_t i = 0; i < level; i++)
        [self appendString: @" "];
    [self appendFormat: format arguments: arguments];
}

@end
