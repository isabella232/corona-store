//
//  NSArray+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/20/14.
//
//

#import "NSArray+Lua.h"
#import "NSDictionary+Lua.h"

@implementation NSArray (Lua)

- (void) toLuaArray:(lua_State *) L {
    lua_newtable(L);
    for(id object in self) {
        if([object isKindOfClass:[NSString class]]) lua_pushstring(L,[((NSString *)object) cStringUsingEncoding:NSUTF8StringEncoding]);
        else if ([object isKindOfClass:[NSNumber class]]) lua_pushnumber(L,[((NSNumber *)object) doubleValue]);
        else if ([object isKindOfClass:[NSDictionary class]]) [((NSDictionary *)object) toLuaTable:L];
        else if ([object isKindOfClass:[NSArray class]]) [((NSArray *)object) toLuaArray:L];
        lua_rawset(L,-2);
    }

}

@end
