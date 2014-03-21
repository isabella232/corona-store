//
//  CoronaListener.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/21/14.
//
//

#import <Foundation/Foundation.h>
#import "CoronaLua.h"

@interface CoronaListenerRef : NSObject

@property CoronaLuaRef listener;

- (void) deleteReference:(lua_State *) L;

@end
