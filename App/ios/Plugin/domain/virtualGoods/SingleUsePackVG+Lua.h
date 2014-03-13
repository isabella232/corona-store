//
//  SingleUsePackVG+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "SingleUsePackVG.h"

@interface SingleUsePackVG (Lua)

- (id) initFromLua:(NSDictionary *) luaData;

@end
