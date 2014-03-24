//
//  NSArray+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/20/14.
//
//

#import <Foundation/Foundation.h>
#import "CoronaLua.h"

@interface NSArray (Lua)

- (void) toLuaArray:(lua_State *) L;

@end
