//
//  VirtualCurrencyPack+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/14/14.
//
//

#import "VirtualCurrencyPack.h"

@interface VirtualCurrencyPack (Lua)

- (id) initFromLua:(NSDictionary *) luaData;

@end
