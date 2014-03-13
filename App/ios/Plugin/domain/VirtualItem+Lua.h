//
//  VirtualItem+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/13/14.
//
//

#import "VirtualItem.h"

@interface VirtualItem (Lua)

- (id) initFromLua:(NSDictionary *) luaData;

@end
