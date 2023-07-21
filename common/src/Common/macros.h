#define auto __auto_type

#define $assert_nonnil(...) ((typeof(*(__VA_ARGS__)) *_Nonnull)({ \
    auto _x = (__VA_ARGS__); \
    if (_x == nil) \
        @throw [OFInvalidArgumentException exception]; \
    _x; \
}))

#define $assert_type(x, y) ((typeof(y) *_Nonnull)({ \
    id _x = (x); \
    if (!(_x && [_x isKindOfClass: [y class]])) \
        @throw [OFInvalidArgumentException exception]; \
    _x; \
}))

#define $SelectorFunction(ret, ...) typeof(ret(id, SEL, __VA_ARGS__))

#if defined(__cplusplus)
#   define $nomangle extern "C"
#else
#   define $nomangle
#endif
