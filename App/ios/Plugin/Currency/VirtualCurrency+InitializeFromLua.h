//
//  VirtualCurrency+InitializeFromLua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/7/14.
//
//

#import "VirtualCurrency.h"
#import "CoronaLua.h"
#import "CoronaMacros.h"

@interface VirtualCurrency (InitializeFromLua)

+ (VirtualCurrency *) createFromLuaTable:(lua_State *) L;

@end
