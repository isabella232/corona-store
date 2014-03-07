//
//  NSDictionary+CreateFromLua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.
//
//

#import "NSDictionary+CreateFromLua.h"
#import "CoronaLibrary.h"

@implementation NSDictionary (CreateFromLua)

+ (NSDictionary *) dictionaryFromLua:(lua_State *)L tableIndex:(int) tableIndex {
    const int kDictionary_Key = -2;
    const int kDictionary_Value = -1;
    
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    if(lua_istable(L,tableIndex)) {
        lua_pushnil(L);
        while(lua_next(L,tableIndex) != 0) {
            NSString * key = [NSString stringWithFormat:@"%s",lua_tostring(L,kDictionary_Key)];
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
                    //TODO: Check if the table is an array or not
                    NSDictionary * value = [NSDictionary dictionaryFromLua:L tableIndex:lua_gettop(L)];
                    [dictionary setValue:value forKey:key];
                }
                default: {
                    NSLog(@"SOOMLA: Skipping not supported values");
                    break;
                }
            }
            lua_pop(L,1); //Removes 'value'; keeps 'key' for next iteration
        }
    }
    else NSLog(@"SOOMLA: There's no table at the top of lua_State. Returning a empty Dictionary");
    return dictionary;
}

@end
