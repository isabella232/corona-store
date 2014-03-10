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
    return dictionary;
}

@end
