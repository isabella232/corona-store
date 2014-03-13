//
//  VirtualCategory+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "VirtualCategory.h"

@interface VirtualCategory (Lua)

- (id) initFromLua:(NSDictionary *) luaData;

@end
