//
//  NSDictionary+CreateFromLua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.
//
//

#import "NSDictionary+Lua.h"
#import "NSArray+Lua.h"
#import "CoronaLibrary.h"
#import "CoronaRuntime.h"

@implementation NSDictionary (Lua)

+ (NSDictionary *) dictionaryFromLua:(lua_State *)L tableIndex:(int) tableIndex {
    
    const int kDictionary_Table = -2;
    const int kDictionary_Key = -1;
    const int kDictionary_Value = -2;
    
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    if(lua_istable(L,tableIndex)) {
        lua_pushvalue(L,tableIndex);                    //stack: -1 => table
        lua_pushnil(L);                                 //stack: -1 => nil; -2 => table
        while(lua_next(L,kDictionary_Table) != 0) {     //stack: -1 => value; -2 => key; -3 => table
            lua_pushvalue(L,-2);                        //stack: -1 => key; -2 => value; -3 => key; -4 => table
        
            NSString * key;
            if(lua_isstring(L,kDictionary_Key)) key = [NSString stringWithFormat:@"%s",lua_tostring(L,kDictionary_Key)];
            else key = [NSString stringWithFormat:@"%f",lua_tonumber(L,kDictionary_Key)];
            
            switch(lua_type(L,kDictionary_Value)) {
                case LUA_TSTRING: {
                    NSString * value = [NSString stringWithFormat:@"%s",lua_tostring(L,kDictionary_Value)];
                    [dictionary setValue:value forKey:key];
                    break;
                }
                case LUA_TNUMBER: {
                    NSNumber * value = [NSNumber numberWithDouble:lua_tonumber(L,kDictionary_Value)];
                    [dictionary setValue:value forKey:key];
                    break;
                }
                case LUA_TFUNCTION: {
                    //TODO: Create a function handler
                    NSLog(@"SOOMLA: DICTIONARY: For now, there's nothing to do");
                    break;
                }
                case LUA_TBOOLEAN: {
                    BOOL boolean = lua_toboolean(L,kDictionary_Value);
                    NSNumber * booleanNumber = (boolean) ? @YES : @NO;
                    [dictionary setValue:booleanNumber forKey:key];
                    break;
                }
                case LUA_TTABLE: {
                    NSDictionary * value = [NSDictionary dictionaryFromLua:L tableIndex:kDictionary_Value];
                    [dictionary setValue:value forKey:key];
                    break;
                }
                default: {
                    NSLog(@"SOOMLA: Skipping not supported values");
                    break;
                }
            }
            lua_pop(L,2);                               //stack: -1 => key; -2 => table
        }
        lua_pop(L,1);
    }
    else NSLog(@"SOOMLA: There's no table at the top of lua_State. Returning a empty Dictionary");
    return [NSDictionary dictionaryWithDictionary:dictionary];
}


- (void) toLuaTable:(lua_State *)L {
    NSArray * keys = [self allKeys];
    lua_newtable(L);
    for(NSString * key in keys) {
        id object = [self objectForKey:key];
        if([object isKindOfClass:[NSString class]]) lua_pushstring(L,[((NSString *)object) cStringUsingEncoding:NSUTF8StringEncoding]);
        else if ([object isKindOfClass:[NSNumber class]]) lua_pushnumber(L,[((NSNumber *)object) doubleValue]);
        else if ([object isKindOfClass:[NSDictionary class]]) [((NSDictionary *)object) toLuaTable:L];
        else if ([object isKindOfClass:[NSArray class]]) [((NSArray *)object) toLuaArray:L];
        else continue;
        lua_setfield(L,-2,[key cStringUsingEncoding:NSUTF8StringEncoding]);
    }
}

@end
