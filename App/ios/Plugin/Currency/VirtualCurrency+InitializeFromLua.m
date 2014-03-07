//
//  VirtualCurrency+InitializeFromLua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.

#import "VirtualCurrency+InitializeFromLua.h"

@implementation VirtualCurrency (InitializeFromLua)

+ (VirtualCurrency *) createFromLuaTable:(lua_State *) L {
    const int kParam_Table = 1;
    if(!lua_istable(L,kParam_Table)) NSLog(@"SOOMLA: You should use a table as a parameter to create a Currency");
    
    
    if(lua_istable(L,kParam_Table)) NSLog(@"It's a table!");
    else NSLog(@"Sorry, but we don't have any table");
    
    return [[VirtualCurrency alloc] initWithName:@"test" andDescription:@"test" andItemId:@"test"];
}

@end
