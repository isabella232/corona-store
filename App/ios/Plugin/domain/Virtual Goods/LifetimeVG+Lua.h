//
//  LifetimeVG+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "LifetimeVG.h"

@interface LifetimeVG (Lua)

+ (LifetimeVG *) lifetimeVGFromLua:(NSDictionary *) luaData;

@end
