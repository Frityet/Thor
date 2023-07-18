#define auto __auto_type

#define $assert_nonnil(...) ((typeof(*(__VA_ARGS__)) *_Nonnull)({ \
    auto _ = (__VA_ARGS__); \
    if (_ == nil) \
        @throw [OFInvalidArgumentException exception]; \
    _; \
}))

#define $assert_type(x, y) ({ \
    auto _ = (x); \
    if (![_ isKindOfClass: [y class]]) \
        @throw [OFInvalidArgumentException exception]; \
    _; \
})
#define $SelectorFunction(ret, ...) typeof(ret(id, SEL, __VA_ARGS__))
