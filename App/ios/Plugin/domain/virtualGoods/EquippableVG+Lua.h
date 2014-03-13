//
//  EquippableVG+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "EquippableVG.h"

@interface EquippableVG (Lua)

- (id) initFromLua:(NSDictionary *) luaData;

@end
