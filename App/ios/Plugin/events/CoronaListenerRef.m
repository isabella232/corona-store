//
//  CoronaListener.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/21/14.
//
//

#import "CoronaListenerRef.h"

@implementation CoronaListenerRef

- (void) deleteReference:(lua_State *) L {
    CoronaLuaDeleteRef(L,self.listener);
}

@end
