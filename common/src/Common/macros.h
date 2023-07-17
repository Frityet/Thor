#define auto __auto_type

#define $assert_nonnil(...) ((typeof(*(__VA_ARGS__)) *_Nonnull)({ \
    auto _ = (__VA_ARGS__); \
    if (_ == nil) \
        @throw [OFInvalidArgumentException exception]; \
    _; \
}))
