//
//  VirtualCurrencyPack+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/11/14.
//
//

#import "VirtualCurrencyPack.h"

@interface VirtualCurrencyPack (Lua)

+ (VirtualCurrencyPack *) currencyPackFromLua:(NSDictionary *) luaData;

@end
