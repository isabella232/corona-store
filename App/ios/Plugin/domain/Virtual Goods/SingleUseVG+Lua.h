//
//  SingleUseVG+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/12/14.
//
//

#import "SingleUseVG.h"

@interface SingleUseVG (Lua)

+ (SingleUseVG *) singleUseVGFromLua:(NSDictionary *) luaData;

@end
