#include "Common/common.h"

#include <lua.h>

OF_ASSUME_NONNULL_BEGIN

@interface LuaExecutionException : OFException

@property (readonly) int status;
@property (readonly) OFString *message;

- (instancetype)initWithStatus: (int)status message: (OFString *)message;
+ (instancetype)exceptionWithStatus: (int)status message: (OFString *)message;

@end

struct CommandInformation {
    OFString *name;
    SEL selector;
    id object;
};

///
/// Using the lua argparse library, parse the arguments passed to the program.
///
OFDictionary<OFString *, id> *parseArguments(lua_State *lua, OFArray<OFString *> *arguments, OFString *progname);

id _Nullable executeCommands(OFDictionary<OFString *, id> *args, OFConstantString *actionKey, struct CommandInformation commands[_Nonnull]);

OF_ASSUME_NONNULL_END
