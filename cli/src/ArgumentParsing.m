#include "ArgumentParsing.h"

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

static const uint8_t LUA_CODE[] = {
#   include "cli.luac.h"
};



@implementation LuaExecutionException

- (instancetype)initWithStatus: (int)status message: (OFString *)message
{
    self = [super init];

    self->_status = status;
    self->_message = message;

    return self;
}

+ (instancetype)exceptionWithStatus: (int)status message: (OFString *)message
{
    return [[self alloc] initWithStatus: status message: message];
}

- (OFString *)description
{
    return [OFString stringWithFormat: @"Lua execution failed with status %d: %@", _status, _message];
}

@end

static id tableToObjC(lua_State *lua);

static OFArray *handleArray(lua_State *lua)
{
    OFMutableArray *array = [OFMutableArray array];
    lua_pushnil(lua);
    while (lua_next(lua, -2) != 0) {
        id value = nil;
        switch (lua_type(lua, -1)) {
            case LUA_TBOOLEAN:
                value = [OFNumber numberWithBool: lua_toboolean(lua, -1)];
                break;
            case LUA_TNUMBER:
                value = [OFNumber numberWithDouble: lua_tonumber(lua, -1)];
                break;
            case LUA_TSTRING:
                value = [OFString stringWithUTF8String: lua_tostring(lua, -1)];
                break;
            case LUA_TTABLE:
                value = tableToObjC(lua);
                break;
            default:
                @throw [OFInvalidArgumentException exception];
        }
        [array addObject: value];
        lua_pop(lua, 1);
    }
    return array;
}

static OFDictionary<OFString *, id> *handleDictionary(lua_State *lua)
{
    auto dictionary = [OFMutableDictionary<OFString *, id> dictionary];
    lua_pushnil(lua);
    while (lua_next(lua, -2) != 0) {
        id key = nil;
        switch (lua_type(lua, -2)) {
            case LUA_TBOOLEAN:
                key = [OFNumber numberWithBool: lua_toboolean(lua, -2)];
                break;
            case LUA_TNUMBER:
                key = [OFNumber numberWithDouble: lua_tonumber(lua, -2)];
                break;
            case LUA_TSTRING:
                key = [OFString stringWithUTF8String: lua_tostring(lua, -2)];
                break;
            default:
                @throw [OFInvalidArgumentException exception];
        }

        id value = nil;
        switch (lua_type(lua, -1)) {
            case LUA_TBOOLEAN:
                value = [OFNumber numberWithBool: lua_toboolean(lua, -1)];
                break;
            case LUA_TNUMBER:
                value = [OFNumber numberWithDouble: lua_tonumber(lua, -1)];
                break;
            case LUA_TSTRING:
                value = [OFString stringWithUTF8String: lua_tostring(lua, -1)];
                break;
            case LUA_TTABLE:
                value = tableToObjC(lua);
                break;
            default:
                @throw [OFInvalidArgumentException exception];
        }
        dictionary[key] = value;
        lua_pop(lua, 1);
    }
    return dictionary;
}

static id tableToObjC(lua_State *lua)
{
    if (lua_istable(lua, -1)) {
        if (lua_rawlen(lua, -1) > 0) return handleArray(lua);
        else return handleDictionary(lua);
    } else {
        @throw [OFInvalidArgumentException exception];
    }
}

OFDictionary<OFString *, id> *parseArguments(lua_State *lua, OFArray<OFString *> *arguments, OFString *progname)
{
    int i = luaL_loadbuffer(lua, (const char *)LUA_CODE, sizeof(LUA_CODE), "cli.lua");
    if (i != LUA_OK)
        @throw [LuaExecutionException exceptionWithStatus: i message: [OFString stringWithUTF8String: lua_tostring(lua, -1)]];

    i = lua_pcall(lua, 0, 0, 0);
    if (i != LUA_OK)
        @throw [LuaExecutionException exceptionWithStatus: i message: [OFString stringWithUTF8String: lua_tostring(lua, -1)]];

    //function ParseArgumants(arguments: string[], program_name: string): { [string]: any }
    lua_getglobal(lua, "ParseArguments");

    lua_newtable(lua);
    for (OFString *argument in arguments) {
        lua_pushlstring(lua, argument.UTF8String, argument.UTF8StringLength);
        lua_rawseti(lua, -2, lua_rawlen(lua, -2) + 1);
    }

    lua_pushlstring(lua, progname.UTF8String, progname.UTF8StringLength);

    i = lua_pcall(lua, 2, 1, 0);
    if (i != LUA_OK)
        @throw [LuaExecutionException exceptionWithStatus: i message: [OFString stringWithUTF8String: lua_tostring(lua, -1)]];

    if (!lua_istable(lua, -1))
        @throw [OFInvalidArgumentException exception];

    return tableToObjC(lua);
}

id _Nullable executeCommands(OFDictionary<OFString *, id> *args, OFConstantString *actionKey, struct CommandInformation commands[])
{
    struct CommandInformation info;
    while ((info = *commands++, info.name != NULL)) {
        if ([info.name isEqual: args[actionKey]]) {
            auto method = ($SelectorFunction(id, OFDictionary<OFString *, id> *) *)[info.object methodForSelector: info.selector];
            return method(info.object, info.selector, args);
        }
    }

    @throw [OFNotImplementedException exceptionWithSelector: @selector(:) object: nil];
}
