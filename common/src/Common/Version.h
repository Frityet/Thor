#include <stdint.h>
#include "ObjFW.h"

typedef struct Version {
    uint32_t major;
    uint32_t minor;
    uint32_t patch;
} OF_BOXABLE Version;

static Version VersionFromString(OFString *_Nonnull str)
{
    OFArray<OFString *> *components = [str componentsSeparatedByString: @"."];

    return (Version) {
        .major = components[0].unsignedLongLongValue,
        .minor = components[1].unsignedLongLongValue,
        .patch = components[2].unsignedLongLongValue
    };
}

static OFString *_Nonnull VersionToString(Version version)
{
    return [OFString stringWithFormat: @"%u.%u.%u", version.major, version.minor, version.patch];
}
