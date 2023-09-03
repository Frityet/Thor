
#import "Common/common.h"

#if defined(OF_WINDOWS)
#   include <shlobj.h>
#endif

static OFIRI *GetHomeDirectory()
{
    #if defined(OF_WINDOWS)
    wchar_t path[MAX_PATH];
    if (SHGetFolderPathW(NULL, CSIDL_PROFILE, NULL, 0, path) != S_OK) {
        @throw [OFInitializationFailedException exceptionWithClass: [OFSystemInfo class]];
    }
    return [OFIRI fileIRIWithPath: [OFString stringWithUTF16String: path] isDirectory: true];
    #else
    return [OFIRI fileIRIWithPath: [OFString stringWithUTF8String: getenv("HOME")] isDirectory: true];
    #endif
}
