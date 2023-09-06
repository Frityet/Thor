#import "macros.h"

#if defined(__cplusplus)
#define class class_
#endif
#import "ObjFW.h"
#if defined(__cplusplus)
#undef class
#endif
#import "Version.h"
#import "InvalidTypeException.h"
#import "FastPoolAllocator.h"
#import "json.h"
