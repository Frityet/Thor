#include <stdint.h>
#include "ObjFW.h"

typedef struct Version {
    uint32_t major;
    uint32_t minor;
    uint32_t patch;
} OF_BOXABLE Version;

static Version version_from_string(OFString *_Nonnull str)
{
    OFArray<OFString *> *components = [str componentsSeparatedByString: @"."];

    return (Version) {
        .major = components[0].unsignedLongLongValue,
        .minor = components[1].unsignedLongLongValue,
        .patch = components[2].unsignedLongLongValue
    };
}
