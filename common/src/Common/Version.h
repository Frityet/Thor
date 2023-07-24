#include <stdint.h>
#include "ObjFW.h"

typedef struct Version {
    uint32_t major;
    uint32_t minor;
    uint32_t patch;
} OF_BOXABLE Version;


__attribute__((used))
static inline Version VersionFromString(OFString *_Nonnull str)
{
    OFArray<OFString *> *components = [str componentsSeparatedByString: @"."];

    return (Version) {
        .major = components[0].unsignedLongLongValue,
        .minor = components[1].unsignedLongLongValue,
        .patch = components[2].unsignedLongLongValue
    };
}

__attribute__((used))
static inline OFString *_Nonnull VersionToString(Version version)
{
    return [OFString stringWithFormat: @"%u.%u.%u", version.major, version.minor, version.patch];
}

__attribute__((used))
static inline bool VersionEquals(Version a, Version b)
{ return a.major == b.major && a.minor == b.minor && a.patch == b.patch; }
