//
//  PurchaseWithMarket+Lua.m
//  Plugin
//
//  Created by Bruno Barbosa Pinheiro on 3/20/14.
//
//

#import "PurchaseWithMarket+Lua.h"
#import "PurchaseType+Lua.h"
#import "MarketItem+Lua.h"

@implementation PurchaseWithMarket (Lua)

+ (PurchaseWithMarket *) purchaseWithMarketFromLua:(NSDictionary *)luaData {
    MarketItem * storeItem = [MarketItem appStoreItemFromLua:luaData];
    if([storeItem isKindOfClass:[NSNull class]] || storeItem == nil) return nil;
    return [[PurchaseWithMarket alloc] initWithMarketItem:storeItem];
}

- (NSDictionary *) toLuaDictionary {
    return @{
             @"purchaseType" : kPurchaseType_Market,
             kPurchaseType_Product : [self.marketItem toLuaDictionary]
    };
}

@end
