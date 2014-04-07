//
//  PurchaseWithMarket+Lua.h
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/20/14.
//
//

#import "PurchaseWithMarket.h"

@interface PurchaseWithMarket (Lua)

+ (PurchaseWithMarket *) purchaseWithMarketFromLua:(NSDictionary *) luaData;

@end
