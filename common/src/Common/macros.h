#include <iso646.h>

#if !defined(__cplusplus)
#define auto __auto_type
#endif

#define typeof __typeof__

#define $assert_nonnil(...) ((typeof(*(__VA_ARGS__)) *_Nonnull)({ \
    auto _x = (__VA_ARGS__); \
    if (_x == nil) \
        @throw [OFInvalidArgumentException exception]; \
    _x; \
}))

#define $SelectorFunction(ret, ...) typeof(ret(id, SEL, __VA_ARGS__))

#if defined(__cplusplus)
#   define $nomangle extern "C"
#else
#   define $nomangle
#endif

